import kagglehub
import shutil
import os

# Download dataset
path = kagglehub.dataset_download("nnthanh101/aws-saas-sales")
print(f"Downloaded to: {path}")

# Copy CSV to data folder
csv_files = [f for f in os.listdir(path) if f.endswith('.csv')]
if csv_files:
    source = os.path.join(path, csv_files[0])
    shutil.copy(source, 'data/saas_sales.csv')
    print(f"✅ Saved to: data/saas_sales.csv")
else:
    print("⚠️ No CSV found")