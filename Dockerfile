FROM python:3.9-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /bot

# Install system deps including libs needed for lxml and ffmpeg
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev gcc libxml2-dev libxslt1-dev zlib1g-dev \
    ffmpeg mediainfo \
 && rm -rf /var/lib/apt/lists/*

# Copy project
COPY . /bot

# Install python deps
RUN pip install --no-cache-dir -r requirements.txt

ENV PORT=8080

CMD ["bash", "run.sh"]
