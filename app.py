from flask import Flask, request, jsonify
from transformers import pipeline


app = Flask(__name__)

LABELS = {
    "LABEL_0": "Negative",
    "LABEL_1": "Neutral",
    "LABEL_2": "Positive"
}


def output_formatter(pred):
    label = LABELS[pred[0]["label"]]
    confidence = pred[0]["score"]
    return {
        "label": label,
        "confidence": confidence
    }


@app.route("/api/v1")
def home():
    return "Welcome to the sentiment API."


@app.route("/api/v1/sentiment")
def predict_sentiment():
    pipe = pipeline(model="cardiffnlp/twitter-roberta-base-sentiment")
    text = request.args.get("input")
    pred = pipe(text)

    return jsonify({"prediction": output_formatter(pred)})


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=10010, debug=True)
