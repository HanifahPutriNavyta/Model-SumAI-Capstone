# Gunakan image base Python
FROM python:3.11

# Set working directory
WORKDIR /app

# Install build tools dan clean apt cache agar image tetap ringan
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
 && rm -rf /var/lib/apt/lists/*

# Copy requirements dan install
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

# Copy seluruh kode aplikasi
COPY . .

# Expose port yang digunakan (sesuaikan dengan port API)
EXPOSE 8000

# Jalankan aplikasi
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]