# Use the official Python 3.9 image from the Docker Hub
FROM python:3.9-slim

# Install OpenSSL and other necessary packages
RUN apt-get update && \
    apt-get install -y openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and switch to that user
RUN useradd -m myuser
USER myuser

# Set the working directory
WORKDIR /home/myuser

# Create directories for certificates and scripts
RUN mkdir -p /home/myuser/certs /home/myuser/scripts

# Generate self-signed certificates
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /home/myuser/certs/server.key \
    -out /home/myuser/certs/server.crt \
    -subj "/C=US/ST=State/L=City/O=Org/OU=Dept/CN=localhost"

# Copy the Python script into the container
COPY --chown=myuser:myuser secure_server.py /home/myuser/scripts/Secure.py

# Expose the port the app runs on
EXPOSE 4443

# Command to run the Python script
CMD ["python", "/home/myuser/scripts/Secure.py"]
