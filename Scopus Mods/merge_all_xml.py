import os
import xml.etree.ElementTree as ET

# Function to read and parse an XML file
def parse_xml(file_path):
    tree = ET.parse(file_path)
    return tree.getroot()

# Directory containing the XML files
directory = '/Users/ah3264/Downloads/SCOPUS'

# Create a new root element
merged_root = ET.Element('records')

# Iterate over all XML files in the directory
for filename in os.listdir(directory):
    if filename.endswith('.xml'):
        file_path = os.path.join(directory, filename)
        root = parse_xml(file_path)
        
        # Create a new record element for each file and append the contents
        record = ET.SubElement(merged_root, 'record')
        record.append(root)

# Write the merged content to a new XML file
merged_tree = ET.ElementTree(merged_root)
merged_tree.write('/Users/ah3264/Downloads/ScopusMods/merged.xml', encoding='utf-8', xml_declaration=True)

print("All XML files merged successfully!")