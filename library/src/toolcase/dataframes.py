import pandas as pd


def uppercase_columns(df: pd.DataFrame) -> pd.DataFrame:
    df.columns = df.columns.str.upper()
    return df
