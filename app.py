from flask import Flask, request, jsonify, Response
from transformers import pipeline

from typing import Dict

ModelPrediction = Dict[str, str | float]

app = Flask(__name__)

# Load the pipeline.
pipe = pipeline(model="cardiffnlp/twitter-roberta-base-sentiment",)

LABELS = {
    "LABEL_0": "Negative",
    "LABEL_1": "Neutral",
    "LABEL_2": "Positive",
}


def output_formatter(output: list[ModelPrediction]) -> ModelPrediction:
    prediction, = output
    return {
        "label": LABELS.get(prediction["label"]),
        "confidence": prediction.get("score"),
    }


@app.route("/api/v1")
def home() -> Response:
    return jsonify({"message": "Welcome to the sentiment API."},)


@app.route("/api/v1/sentiment", methods=["POST"])
def predict_sentiment() -> Response:
    data: dict = request.get_json()
    text: str = data.get("input")
    result: list[ModelPrediction] = pipe(text)
    return jsonify({"prediction": output_formatter(result)},)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10010, debug=True)
