import pandas as pd

def read_excel_file(file_path):
    try:
        df = pd.read_excel(file_path, usecols=[0, 1])

        df.iloc[:, 0] = df.iloc[:, 0].astype(str)
        return df.values.tolist()
    except Exception as e:
        raise ValueError(f"Error reading Excel file: {e}")
