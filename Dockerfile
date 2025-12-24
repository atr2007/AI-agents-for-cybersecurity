# syntax=docker/dockerfile:1
FROM python:3.11-slim

# Basic OS deps some Python libs may need (safe baseline)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl build-essential \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements first for better layer caching
COPY requirements.txt /app/requirements.txt

# Install deps
RUN python -m pip install --upgrade pip \
 && python -m pip install -r requirements.txt

# Now copy the rest of the repo
COPY . /app

# Default: drop into a shell so you can run whichever part you want
CMD ["bash"]