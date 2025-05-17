FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy your local app code into the container
COPY . /app

# Install system dependencies needed by NLP/ML packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies with network-stable options
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir numpy
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir flask scikit-learn sentence-transformers
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir bertopic

# Expose the Flask app port
EXPOSE 8000

# Run the Flask app
CMD ["python", "app.py"]
