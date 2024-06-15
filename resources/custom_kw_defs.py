import os

def get_most_recent_file(directory, pattern):
    files = [os.path.join(directory, f) for f in os.listdir(directory) if f.endswith(pattern)]
    most_recent_file = max(files, key=os.path.getctime)
    return most_recent_file