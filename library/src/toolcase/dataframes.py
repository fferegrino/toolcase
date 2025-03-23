import pandas as pd


def uppercase_columns(df: pd.DataFrame) -> pd.Index[str]:
    return df.columns.str.upper()
