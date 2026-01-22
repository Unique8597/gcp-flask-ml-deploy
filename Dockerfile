# ---- Base image ----
FROM python:3.11-slim

# ---- Set working directory ----
WORKDIR /app

# ---- Install system dependencies ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc && \
    rm -rf /var/lib/apt/lists/*

# ---- Copy project files ----
COPY requirements.txt .
COPY main.py .

# ---- Install dependencies ----
RUN pip install --no-cache-dir -r requirements.txt

# ---- Expose port for App Engine ----
EXPOSE 8080

# ---- Start the app ----
CMD ["gunicorn", "-b", "0.0.0.0:8080", "main:app"]
