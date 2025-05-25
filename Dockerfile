FROM python:3.12-slim as base

LABEL maintainer="mateus-dev@me.com.br"
LABEL description="Backend application container"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN groupadd --gid 1000 appuser && \
    useradd --uid 1000 --gid appuser --shell /bin/bash --create-home appuser

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /backend

COPY --chown=appuser:appuser ./pyproject.toml ./

RUN pip install --upgrade pip && \
    pip install -e .

COPY --chown=appuser:appuser ./backend ./
COPY --chown=appuser:appuser ./scripts /scripts

RUN mkdir -p /data/web/static /data/web/media /data/logs && \
    chown -R appuser:appuser /data && \
    chmod -R 755 /data && \
    chmod +x /scripts/*.sh

ENV PATH="/scripts:$PATH"

USER appuser

EXPOSE 8000

CMD ["commands.sh"]
