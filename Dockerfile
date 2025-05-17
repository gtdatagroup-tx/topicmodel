FROM python:3.10-slim

WORKDIR /app
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir numpy
RUN pip install --no-cache-dir flask scikit-learn sentence-transformers
RUN pip install --no-cache-dir bertopic

EXPOSE 8000
CMD ["python", "app.py"]
