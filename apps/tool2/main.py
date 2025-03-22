import pandas as pd
import typer
from toolcase import __version__

app = typer.Typer()

@app.command()
def main():
    print(f"Hello, World! (toolcase version: {__version__})")

if __name__ == "__main__":
    app()
