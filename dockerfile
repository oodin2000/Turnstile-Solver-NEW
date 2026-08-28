# Gunakan Python versi 3.11 (ringan)
FROM python:3.11-slim

# Set folder kerja di dalam container
WORKDIR /app

# Install sistem operasi yang dibutuhkan Playwright
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Salin daftar dependensi Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install browser Chromium (dipakai oleh patchright)
RUN python -m patchright install chromium

# Salin semua kode proyek ke container
COPY . .

# Port yang akan digunakan (Hugging Face pakai 7860)
EXPOSE 7860

# Perintah untuk menjalankan API
CMD ["python", "api.py", "--port", "7860", "--host", "0.0.0.0"]
