import pandas as pd

def read_excel_file(file_path):
    try:
        df = pd.read_excel(file_path)
        df = df.iloc[:, :3]
        df = df.astype(str)
        df = df.fillna('')
        
        df.iloc[:, 0] = df.iloc[:, 0].astype(int)

        df = df.sort_values(by=df.columns[0])

        df.iloc[:, 0] = df.iloc[:, 0].astype(str)
        
        combined_rows = [[f"{row[0]} {row[1]} {row[2]}"[:3]] for row in df.values.tolist()]
        
        return combined_rows
    except Exception as e:
        raise ValueError(f"Error reading Excel file: {e}")