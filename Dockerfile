FROM python:3.9-slim-bullseye

# keep non-interactive and small image
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /bot

# install system deps (ffmpeg, mediainfo, etc.)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    git \
    wget \
    pv \
    jq \
    python3-dev \
    ffmpeg \
    mediainfo \
 && rm -rf /var/lib/apt/lists/*

# copy project files (adjust as repo layout requires)
COPY . /bot

# install python deps
RUN pip install --no-cache-dir -r requirements.txt

# expose any port if your bot uses webhooks (Render provides $PORT)
ENV PORT=8080

# default command (adjust to how the repo runs the bot)
CMD ["bash", "run.sh"]
