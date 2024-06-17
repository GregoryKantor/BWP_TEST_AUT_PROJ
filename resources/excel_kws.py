import pandas as pd

def read_excel_file(file_path):
    try:
        df = pd.read_excel(file_path)
        return df.values.tolist()
    except Exception as e:
        raise ValueError(f"Error reading Excel file: {e}")

def compare_data(excel_data, web_data):
    if excel_data is None or web_data is None:
        raise ValueError("One of the data sets is None.")
    if excel_data != web_data:
        raise AssertionError("Excel data does not match web table data.")