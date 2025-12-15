import os
import sys
import requests
from lxml import etree
from datetime import datetime
from dotenv import load_dotenv
import xml.etree.ElementTree as ET

# Load environment variables from a .env file
load_dotenv()

# Retrieve the API key from the environment variables
api_key = os.getenv('SCOPUS_API_KEY')

if not api_key:
    raise ValueError("API key not found. Please set SCOPUS_API_KEY in your .env file.")

# List of EIDs to fetch
eids = ['2-s2.0-105000536548', '2-s2.0-86000769007', '2-s2.0-86000772521', '2-s2.0-86000663903', '2-s2.0-105000540966', '2-s2.0-105000034525', '2-s2.0-105000034918', '2-s2.0-105000389895', '2-s2.0-105000494419', '2-s2.0-86000342360', '2-s2.0-105000429323']
base_url = 'https://api.elsevier.com/content/abstract/eid/'

# Define the directory to save the files
save_dir = os.path.join(os.path.dirname(__file__), 'SCOPUS')

# Create the directory if it doesn't exist
os.makedirs(save_dir, exist_ok=True)

# Step 1: Fetch records from Scopus API
print("Fetching records from Scopus API...")
for eid in eids:
    url = f"{base_url}{eid}?apiKey={api_key}"
    response = requests.get(url, headers={'Accept': 'application/xml'})
    if response.status_code == 200:
        # Save the response to a file
        file_path = os.path.join(save_dir, f"{eid}.xml")
        with open(file_path, 'wb') as f:
            f.write(response.content)
       # print(f"Saved EID {eid} to {file_path}")
    else:
        print(f"Failed to retrieve EID {eid}: {response.status_code}")

# Step 2: Merge all XML files into one
print("Merging all XML files...")
merged_root = ET.Element('records')
for filename in os.listdir(save_dir):
    if filename.endswith('.xml'):
        file_path = os.path.join(save_dir, filename)
        tree = ET.parse(file_path)
        root = tree.getroot()
        record = ET.SubElement(merged_root, 'record')
        record.append(root)

# Write the merged content to a new XML file
merged_filename = 'merged.xml'
merged_tree = ET.ElementTree(merged_root)
merged_tree.write(merged_filename, encoding='utf-8', xml_declaration=True)
print(f"Merged XML saved as {merged_filename}")

# Step 3: Apply XSLT transformation
print("Applying XSLT transformation...")
xml = etree.parse(merged_filename)
xslt = etree.parse('transform.xslt')
transform = etree.XSLT(xslt)
result = transform(xml)

# Save the transformed XML to a file
transformed_filename = 'temp.xml'
with open(transformed_filename, 'wb') as f:
    f.write(etree.tostring(result, pretty_print=True, xml_declaration=True, encoding='UTF-8'))
print(f"Transformed XML saved as {transformed_filename}")

# Step 4: Use Swepub classify API to add subject
def fetch_xlink_href(abstract, keywords, title):
    url = "https://bibliometri.swepub.kb.se/api/v1/classify"
    headers = {
        "Content-Type": "application/json"
    }
    
    # First attempt with level 5
    data = {
        "abstract": abstract,
        "keywords": keywords,
        "classes": 1,
        "level": 5,
        "title": title
    }
    response = requests.post(url, json=data, headers=headers)
    if response.status_code == 200:
        result = response.json()
        if 'suggestions' in result and len(result['suggestions']) > 0:
            best_suggestion = max(result['suggestions'], key=lambda x: x['_score'])
            return best_suggestion['code']
    
    # Second attempt with level 3 if no suggestions found in the first attempt
    data["level"] = 3
    response = requests.post(url, json=data, headers=headers)
    if response.status_code == 200:
        result = response.json()
        if 'suggestions' in result and len(result['suggestions']) > 0:
            best_suggestion = max(result['suggestions'], key=lambda x: x['_score'])
            return best_suggestion['code']
    
    raise Exception("No suggestions found in API response")

print("Adding subjects using Swepub classify API...")
transformed_xml = etree.parse(transformed_filename)
for record in transformed_xml.xpath('//mods:mods', namespaces={'mods': 'http://www.loc.gov/mods/v3'}):
    abstract = record.xpath('string(mods:abstract)', namespaces={'mods': 'http://www.loc.gov/mods/v3'})
    keywords = ' '.join(record.xpath('mods:subject/mods:topic/text()', namespaces={'mods': 'http://www.loc.gov/mods/v3'}))
    title = record.xpath('string(mods:titleInfo/mods:title)', namespaces={'mods': 'http://www.loc.gov/mods/v3'})
    eid = record.xpath('string(mods:identifier[@type="scopus"])', namespaces={'mods': 'http://www.loc.gov/mods/v3'})  # Extract EID

    try:
        xlink_href = fetch_xlink_href(abstract, keywords, title)
        subject_element = etree.Element("{http://www.loc.gov/mods/v3}subject", lang="eng", authority="hsv")
        subject_element.set("{http://www.w3.org/1999/xlink}href", xlink_href)
        record.append(subject_element)
    except Exception as e:
        print(f"Error fetching xlink:href for record with EID {eid}", file=sys.stderr)
        print(e, file=sys.stderr)

# Step 5: Save the final XML
today_date = datetime.now().strftime('%y%m%d')
final_filename = f'scopus_{today_date}.xml'
with open(final_filename, 'wb') as f:
    f.write(etree.tostring(transformed_xml, pretty_print=True, xml_declaration=True, encoding='UTF-8'))
print(f"Final XML saved as {final_filename}")