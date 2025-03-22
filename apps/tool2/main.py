import pandas as pd
import typer
from toolcase import __version__

from utils import hola

app = typer.Typer()


@app.command()
def main(name: str | None = None):
    if not name:
        name = "World"
    print(f"Hello, {name}! (toolcase version: {__version__})")
    print(f"Pandas version: {pd.__version__}")
    hola(name)


if __name__ == "__main__":
    app()
