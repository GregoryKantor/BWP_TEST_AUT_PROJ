import pandas as pd

def read_excel_file(file_path):
    try:
        df = pd.read_excel(file_path)
        df = df.iloc[:, :3]
        df = df.astype(str)
        df = df.fillna('')
        combined_rows = [[''.join(row)[:10]] for row in df.values.tolist()]
        return combined_rows
    except Exception as e:
        raise ValueError(f"Error reading Excel file: {e}")