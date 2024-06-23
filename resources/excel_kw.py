import pandas as pd

def read_excel_file(file_path):
    try:
        df = pd.read_excel(file_path)
        result = []
        for _, row in df.iloc[:, :2].iterrows():
            result.append([str(row.iloc[0]), row.iloc[1]])
        return result
    except Exception as e:
        raise ValueError(f"Error reading Excel file: {e}")