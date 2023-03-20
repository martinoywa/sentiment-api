FROM python:3.9

# TODO: Use the alpine image for smaller images.

ARG VERSION

LABEL io.martinoywa.version=$VERSION

COPY Makefile /app/Makefile

WORKDIR /app

COPY ./* /app

RUN make all

ENTRYPOINT ["python"]

CMD ["app.py"]