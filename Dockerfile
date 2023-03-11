# Set base image (host OS)
FROM python:3.9

# By default, listen on port 10010
EXPOSE 10010/tcp

# Set the working directory in the container
WORKDIR /app

# Copy fileS to the working directory
COPY ./* ./

# Install any dependencies
RUN  pip install --upgrade pip && pip install -r requirements.txt

# Specify the command to run on container start
ENTRYPOINT ["python"]

# Specify the file to run on container start
CMD ["app.py"]