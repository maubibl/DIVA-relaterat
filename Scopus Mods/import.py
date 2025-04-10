#This script can be replaced by ScopusMods.py, that replaces import.py, merge_all_xml.py and transscopus.py

import requests
import os

# Replace with your actual API key
api_key = '{your api_key here}'
eids = ['2-s2.0-85206521431', '2-s2.0-85201666801']
base_url = 'https://api.elsevier.com/content/abstract/eid/'

# Define the directory to save the files
save_dir = os.path.expanduser('~/Downloads/SCOPUS')

# Create the directory if it doesn't exist
os.makedirs(save_dir, exist_ok=True)

for eid in eids:
    url = f"{base_url}{eid}?apiKey={api_key}"
    response = requests.get(url, headers={'Accept': 'application/xml'})
    if response.status_code == 200:
        # Save the response to a file
        file_path = os.path.join(save_dir, f"{eid}.xml")
        with open(file_path, 'wb') as f:
            f.write(response.content)
        print(f"Saved EID {eid} to {file_path}")
    else:
        print(f"Failed to retrieve EID {eid}: {response.status_code}")

print("All downloads completed.")
