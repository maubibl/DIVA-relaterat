#This script can be replaced by ScopusMods.py, that replaces import.py, merge_all_xml.py and transscopus.py

import sys
import requests
from lxml import etree
from datetime import datetime

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

# Load the XML and XSLT files
xml = etree.parse('merged.xml')
xslt = etree.parse('transform.xslt')

# Apply the transformation
transform = etree.XSLT(xslt)
result = transform(xml)

# Save the transformed XML to a file named temp.xml
transformed_filename = 'temp.xml'
with open(transformed_filename, 'wb') as f:
    f.write(etree.tostring(result, pretty_print=True, xml_declaration=True, encoding='UTF-8'))

# Load the transformed XML file
transformed_xml = etree.parse(transformed_filename)

# Iterate over each record in the transformed XML file
for record in transformed_xml.xpath('//mods:mods', namespaces={'mods': 'http://www.loc.gov/mods/v3'}):
    abstract = record.xpath('string(mods:abstract)', namespaces={'mods': 'http://www.loc.gov/mods/v3'})
    keywords = ' '.join(record.xpath('mods:subject/mods:topic/text()', namespaces={'mods': 'http://www.loc.gov/mods/v3'}))
    title = record.xpath('string(mods:titleInfo/mods:title)', namespaces={'mods': 'http://www.loc.gov/mods/v3'})
    
    # Fetch the xlink:href value from the API
    try:
        xlink_href = fetch_xlink_href(abstract, keywords, title)
        # Add the <subject> tag with the xlink:href value
        subject_element = etree.Element("{http://www.loc.gov/mods/v3}subject", lang="eng", authority="hsv")
        subject_element.set("{http://www.w3.org/1999/xlink}href", xlink_href)
        record.append(subject_element)
        print(f"xlink:href: {xlink_href}")
    except Exception as e:
        print(f"Error fetching xlink:href for record: {etree.tostring(record, pretty_print=True, encoding='unicode')}", file=sys.stderr)
        print(e, file=sys.stderr)

# Generate the filename with today's date in YYMMDD format
today_date = datetime.now().strftime('%y%m%d')
final_filename = f'scopus_{today_date}.xml'

# Save the final XML with the added <subject> tags
with open(final_filename, 'wb') as f:
    f.write(etree.tostring(transformed_xml, pretty_print=True, xml_declaration=True, encoding='UTF-8'))

# Print success message
print(f"Transformation and API fetching completed successfully! File saved as {final_filename}")
