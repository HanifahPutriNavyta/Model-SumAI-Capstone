# Gunakan image base Python
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements dan install
COPY requirements.txt .
RUN apt-get update && apt-get install -y build-essential && \
    pip install --no-cache-dir -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

# Copy seluruh kode aplikasi
COPY . .

# Expose port yang digunakan (sesuaikan dengan port API)
EXPOSE 8000

# Jalankan aplikasi
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]