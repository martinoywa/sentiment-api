# Seniment Analysis API

Flask API exposing an endpoint for determining the
sentiment of text.

# How to run locally. (**_Terminal_**)

1. Create a virtual environment.
```jupyter
python3 -m venv env
```


2. Activate the virtual environment.
```jupyter
. ./env/bin/activate
```


3. Install dependecies. (Using the Makefile)
```jupyter
make install
```


4. Run the application.
```jupyter
python app.py
```


5. Query the api.

Example: I don't like this game.
```jupyter
curl -X GET "http://127.0.0.1:10010/api/v1/sentiment?input=I%20don't%20like%20this%20game"
```

Output:
```json
{
  "prediction": {
    "confidence": 0.9779077172279358,
    "label": "Negative"
  }
}
```

# How to run locally. (**_Docker_**)

1. Prerequisite: Make sure you have docker installed. [Link](https://docs.docker.com/desktop/install/mac-install/)


2. Build the docker image. This uses the Docker file in the repository's root.
```jupyter
docker build --build-arg VERSION=SENTIMENT-v1 -t sentiment-api .
```


3. Run a container using the image as its base.
```jupyter
docker run -p 10010:10010 --name sentiment-api --rm sentiment-api
```


4. Querying works like the previous one. You can also use **Postman**.


5. More Examples:

Query: I like this game 

```jupyter
curl -X GET "http://127.0.0.1:10010/api/v1/sentiment?input=I%20like%20this%20game"
```
```json
{
  "prediction": {
    "confidence": 0.9681828022003174,
    "label": "Positive"
  }
}
```

Query: I have no opninion.
```jupyter
curl -X GET "http://127.0.0.1:10010/api/v1/sentiment?input=I%20have%20no%20opinion"
```

```json
{
  "prediction": {
    "confidence": 0.4917212426662445,
    "label": "Neutral"
  }
}
```


# How to run on cloud. (**_AWS_**)

1. Code available in branches `deploy` for `AWS Lightsail` and `ebs` for `AWS Elasticbeanstalk`.
2. Documentations are available via this [link](https://bit.ly/3Z00RlR), Pages `8` & `9`.


###

Built with ❤️ by [martinoywa](https://github.com/martinoywa).