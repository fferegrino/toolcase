import pandas as pd
import typer
from toolcase.dataframes import uppercase_columns

from utils import hola

app = typer.Typer()


@app.command()
def main(columns: int = 10, rows: int = 10) -> None:
    df = pd.DataFrame(
        {
            chr(i): range(rows)
            for i in range(columns)
        }
    )
    print(uppercase_columns(df))


if __name__ == "__main__":
    app()
