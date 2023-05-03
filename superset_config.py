import pdfplumber
import re
import os
import pandas as pd

def extract_data(pdf_path):
    with pdfplumber.open(pdf_path) as pdf:
        page = pdf.pages[0]
        content = page.extract_text()

    date_pattern = r'\d{1,2} \w+ \d{4}'
    date = re.search(date_pattern, content).group(0)

    total_pattern = r'Total (\d+\,\d{2}) \$CA'
    total = re.search(total_pattern, content).group(1).replace(',', '.')

    driver_pattern = r'Votre chauffeur était (\w+)'
    driver_match = re.search(driver_pattern, content)

    restaurant_pattern = r'restaurant suivant : (.+?)\.'
    restaurant_match = re.search(restaurant_pattern, content)

    if driver_match:
        return {'type': 'Uber', 'date': date, 'total': total, 'driver': driver_match.group(1)}
    elif restaurant_match:
        return {'type': 'Uber Eats', 'date': date, 'total': total, 'restaurant': restaurant_match.group(1)}

    return {'error': 'Invalid receipt format'}

pdf_directory = '/home/stefen/uber/data'
pdf_files = [f for f in os.listdir(pdf_directory) if f.endswith('.pdf')]

uber_data = []
uber_eats_data = []

for pdf_file in pdf_files:
    pdf_path = os.path.join(pdf_directory, pdf_file)
    extracted_data = extract_data(pdf_path)
    if extracted_data['type'] == 'Uber':
        uber_data.append(extracted_data)
    elif extracted_data['type'] == 'Uber Eats':
        uber_eats_data.append(extracted_data)

# Create separate DataFrames for Uber and Uber Eats data
uber_df = pd.DataFrame(uber_data)
uber_eats_df = pd.DataFrame(uber_eats_data)

# Save the data to CSV files
uber_df.to_csv('uber_receipts.csv', index=False)
uber_eats_df.to_csv('uber_eats_receipts.csv', index=False)
