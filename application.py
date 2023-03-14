from flask import Flask, request, jsonify
from torch import nn
import numpy as np
from transformers import AutoModelForSequenceClassification
from transformers import AutoTokenizer


application = Flask(__name__)


def output_formatter(confidence_scores):
    labels = ['Negative', 'Neutral', 'Positive']
    pred = np.argmax(confidence_scores)
    return {
        "highest": {
            "label": labels[pred],
            "confidence_score": str(confidence_scores[pred])
        },
        "all": {
            "labels": labels,
            "confidence_scores": list(map(str, confidence_scores))
        }

    }


@application.route("/api/v1")
def home():
    return "Welcome to the sentiment API."


@application.route("/api/v1/sentiment")
def predict_sentiment():
    text = request.args.get("input")
    # load the models
    model = AutoModelForSequenceClassification.from_pretrained("models/", local_files_only=True)
    tokenizer = AutoTokenizer.from_pretrained("models/")
    # encode the input
    encoded_input = tokenizer(text, return_tensors='pt')
    output = model(**encoded_input)
    # get scores
    softmax = nn.Softmax(dim=1)
    scores = softmax(output[0])
    confidence_scores = scores[0].detach().numpy()

    return jsonify({"prediction": output_formatter(confidence_scores)})


if __name__ == "__main__":
    application.run(debug=True)
