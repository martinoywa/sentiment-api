FROM python:3.12.3-slim-bullseye

ARG VERSION
LABEL io.martinoywa.version=$VERSION

WORKDIR /usr/src/app

COPY . ./

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

EXPOSE 10010
ENTRYPOINT ["python3"]
CMD ["app.py"]
