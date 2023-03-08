FROM python:3.9

WORKDIR /app

COPY ./* ./

RUN  pip install --upgrade pip && pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["app.py"]