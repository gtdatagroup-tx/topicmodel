FROM python:3.10-slim

# Set working directory
WORKDIR /app
COPY . /app

# Install build tools and libraries for numpy, bertopic, and sentence-transformers
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python packages
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir \
    numpy \
    cython \
    flask \
    scikit-learn \
    sentence-transformers \
    bertopic

# Expose the app port
EXPOSE 8000

# Run the app
CMD ["python", "app.py"]
