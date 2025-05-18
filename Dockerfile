FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy your app files
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir numpy
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir flask scikit-learn sentence-transformers
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir bertopic

# Copy the startup script and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the Flask port
EXPOSE 8000

# Run the app using a shell script (reliable entrypoint)
ENTRYPOINT ["/start.sh"]
