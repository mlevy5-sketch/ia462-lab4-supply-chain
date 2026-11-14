# IA 462 Lab 4 - digest-pinned base image (Week 8 slide: pin, don't float)
FROM python:3.15-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928

LABEL maintainer="student@emich.edu"
LABEL description="IA 462 Lab 4 - Supply-Chain-Hardened App"

RUN groupadd --system appgroup && \
    useradd --system --gid appgroup --home /app --shell /usr/sbin/nologin appuser

WORKDIR /app

COPY --chown=appuser:appgroup requirements.lock ./requirements.txt
RUN pip install --no-cache-dir --require-hashes -r requirements.txt

COPY --chown=appuser:appgroup app/ ./app/

USER appuser

EXPOSE 5000

CMD ["python3", "app/app.py"]
