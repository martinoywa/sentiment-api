# syntax=docker/dockerfile:1

ARG PYTHON_VERSION=3.12.3
FROM python:${PYTHON_VERSION}-slim-bullseye as base

ARG VERSION
LABEL io.martinoywa.version=$VERSION

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

# Avoids overhead network calls to PYPI to check for latest pip version.
ENV PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /usr/src/app

# Create a non-privileged user that the app will run under.
# Set appropriate ownership for the user home directory.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN <<EOF
adduser \
    --disabled-password \
    --gecos "" \
    --home "/usr/src/app/user-home" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
mkdir -p /usr/src/app/user-home
chown appuser:appuser /usr/src/app/user-home
EOF

# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

# Switch to the non-privileged user to run the application.
USER appuser

# Copy the source code into the container.
COPY . ./

# Expose the port that the application listens on.
EXPOSE 10010

# Run the application.
ENTRYPOINT ["python3"]
CMD ["app.py"]
