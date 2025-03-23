import pandas as pd
from pandas.testing import assert_frame_equal

from toolcase.dataframes import uppercase_columns


def test_uppercase_columns():
    df = pd.DataFrame({"a": [1, 2, 3], "b": [4, 5, 6]})
    expected = pd.DataFrame({"A": [1, 2, 3], "B": [4, 5, 6]})
    assert_frame_equal(uppercase_columns(df), expected)
