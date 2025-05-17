FROM python:3.10-slim

WORKDIR /app
COPY . /app

# Install system dependencies required by NLP packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install necessary Python libraries explicitly
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    flask \
    numpy \
    scikit-learn \
    sentence-transformers \
    bertopic

EXPOSE 8000
CMD ["python", "app.py"]
