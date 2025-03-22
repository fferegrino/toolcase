FROM ghcr.io/astral-sh/uv:python3.10-bookworm

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /app

WORKDIR /app/library

COPY library/pyproject.toml library/uv.lock ./

RUN uv sync

COPY library/ ./library

WORKDIR /app

COPY apps/ ./apps/

COPY run_app.sh ./

RUN chmod +x run_app.sh

ENTRYPOINT ["./run_app.sh"]
