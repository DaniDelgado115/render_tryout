FROM python:3.11-slim

# Install minimal system deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy only requirements first to leverage Docker cache
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# copy application code
COPY arxiv.py /app/arxiv.py
COPY papers /app/papers

EXPOSE 8001

ENV PYTHONUNBUFFERED=1

CMD ["python", "arxiv.py"]
