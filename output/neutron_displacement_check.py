import pandas as pd
import matplotlib.pyplot as plt

# Read the data from the text file
file_path = '/usr/WS1/mtv/software/ratpac-setup/mtv/output/paper_B/ibd_cube_005wt_10k_run0/cube_005wt_10k_run0_neutrons_truth.txt'  # Replace with your actual file path


# Define the column names based on your data structure
column_names = [
    'Row', 'Instance',
    'trackPDG', 'trackPos1', 'trackPos2', 'trackPos3',
    'trackTim', 'trackMom1', 'trackMom2', 'trackMom3', 'trackKE', 'trackPro',
    'evid', 'mcx', 'mcy', 'mcz', 'mcu', 'mcv', 'mcw', 'mcpdg'
]

# Read the data into a DataFrame, skipping the first row
data = pd.read_csv(file_path, delim_whitespace=True, header=None, names=column_names, skiprows=1)
print(data)

data = data.drop_duplicates(subset='Row')
print(data)

# Convert relevant columns to numeric, if necessary
data['mcx'] = pd.to_numeric(data['mcx'], errors='coerce')
data['trackPos1'] = pd.to_numeric(data['trackPos1'], errors='coerce')

# Create a unique column for mcx resets
data['mcx_reset'] = (data['mcx'] != data['mcx'].shift()).cumsum()

# Display the updated DataFrame with the new column
print(data[['mcx', 'mcx_reset']].head())  # Displaying the first few rows for verification

# Drop rows with NaN values that may have resulted from conversion
data.dropna(subset=['mcx', 'trackPos1'], inplace=True)

# Plot mcx vs trackPos(1)
plt.figure(figsize=(10, 6))
plt.scatter(data['mcx'], data['trackPos1'], marker='o', color='b')
plt.title('Plot of mcx vs trackPos(1)')
plt.xlabel('mcx')
plt.ylabel('trackPos(1)')
plt.grid()
plt.savefig('plots/neutronXturth.png')

plt.clf()

plt.figure(figsize=(10, 6))
plt.scatter(data['mcy'], data['trackPos2'], marker='o', color='b')
plt.title('Plot of mcy vs trackPos(2)')
plt.xlabel('mcy')
plt.ylabel('trackPos(2)')
plt.grid()
plt.savefig('plots/neutronYturth.png')

plt.clf()

data['DifferenceX'] = data['mcx'] - data['trackPos1']

plt.figure(figsize=(10, 6))
plt.hist(data['DifferenceX'], bins=30, color='blue', alpha=0.7)
plt.title('Histogram of mcx - TrackPos1')
plt.xlabel('mcx - TrackPos1 Values')
plt.ylabel('Frequency')
plt.grid(axis='y', alpha=0.75)
plt.savefig('plots/histo_mcx_neutron1stScatter.png')

