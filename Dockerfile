FROM python:3.12-slim
LABEL mantainer="mateus-dev-me.com.br"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV POETRY_VIRTUALENVS_CREATE=false

COPY ./app /app
COPY ./pyproject.toml /app
COPY ./scripts /scripts

WORKDIR /app

EXPOSE 8000

RUN pip install --upgrade pip && \
    pip install poetry && \
    poetry install --no-root && \
    mkdir -p /data/web/static && \
    mkdir -p /data/web/media && \
    mkdir -p /data/logs && \
    chmod -R +x /scripts

ENV PATH="/scripts:$PATH"

CMD ["commands.sh"]
