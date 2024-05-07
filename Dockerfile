FROM python:3.12.3-alpine3.19

ARG VERSION
LABEL io.martinoywa.version=$VERSION

WORKDIR /usr/src/app

COPY . ./

RUN make all

EXPOSE 10010
ENTRYPOINT ["python3"]
CMD ["app.py"]
