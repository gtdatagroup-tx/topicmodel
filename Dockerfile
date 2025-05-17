FROM python:3.10-slim

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir numpy
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir flask scikit-learn sentence-transformers
RUN pip install --default-timeout=100 --retries=10 --no-cache-dir bertopic

EXPOSE 8000

CMD ["python3", "app.py"]
