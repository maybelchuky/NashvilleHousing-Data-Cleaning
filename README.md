# Nashville Housing Data Cleaning Project
![Housing](housing-image.jpg)

### Project Overview
---
This project involves cleaning the Nashville housing dataset to prepare it for analysis. The dataset contains information about properties in Nashville, including details like ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, etc.

### Data Description
---
The dataset contains the following columns:
- UniqueID: Unique identifier for each record
- ParcelID: Unique identifier for each property parcel
- LandUse: Classification of land use for each property
- PropertyAddress: Address of the property
- SaleDate: Date of property sale
- SalePrice: Price at which the property was sold
- LegalReference: Legal reference for the property transaction
- SoldAsVacant: Indicates whether the property was sold as vacant
- OwnerName: Name of the property owner
- OwnerAddress: Address of the property owner
- Acreage: Acreage of the property
- TaxDistrict: Tax district of the property
- LandValue: Value of the land
- BuildingValue: Value of the building on the property
- TotalValue: Total value of the property
- YearBuilt: Year the property was built
- Bedrooms: Number of bedrooms in the property
- FullBath: Number of full bathrooms in the property
- HalfBath: Number of half bathrooms in the property

### Data Source
---
The dataset is provided in CSV format and contains 1 file, 19 rows and 56477 columns - [Download Raw Dataset Here](NashvilleHousing.csv) and for updated and cleaned version of the dataset - [Download Cleaned Dataset Here](NashvilleHousing-Cleaned.csv) 

### Tools
---
- Microsoft SQL Server for Data Cleaning and Transformation
  
### Approach Used In Data Cleaning:
---
1. **Standardize Date Format**:
   - The aim of this step is to standardize the format of the SaleDate column to a date format recognized by the database. This involves converting the SaleDate values to a consistent date format and adding a new column (SaleDateConverted) to the dataset to store the standardized dates using the **CONVERT()** Function.
2. **Populate Property Address**:
   - The aim of this step is to populate missing PropertyAddress values by matching ParcelID values with other records in the dataset. If a PropertyAddress is missing for a record (a), it looks for records with the same ParcelID but different UniqueID (b). It then updates the missing PropertyAddress using the PropertyAddress from the matched record (b) using the **ISNULL()** Function.
3. **Break out Address into Individual Columns**:
   - The aim of this step is to break down the PropertyAddress column into separate columns for the address and city. This involves adding new columns (PropertySplitAddress and PropertySplitCity) to the dataset and extracting the address and city information from the PropertyAddress column using string manipulation functions **SUBSTRING(), CHARINDEX()**.
4. **Break out Owner Address into Individual Columns**:
   - The aim of this step is to break down the OwnerAddress column into separate columns for the address, city, and state of the property owner. This involves adding new columns (OwnerSplitAddress, OwnerSplitCity, and OwnerSplitState) to the dataset and parsing the address information using string manipulation functions **PARSENAME(), REPLACE()**.
5. **Change Y and N to Yes and No**:
    -  The aim of this step is to standardize the values in the SoldAsVacant column to 'Yes' and 'No' instead of 'Y' and 'N', respectively. This involves updating the values in the SoldAsVacant column using a **CASE STATEMENT** to replace 'Y' with 'Yes', 'N' with 'No', and keep other values unchanged.
6. **Remove Duplicates**: Identify and remove duplicate rows based on selected criteria.
    -  The aim of this step is to identify and display duplicate rows in the dataset based on selected criteria. **Common Table Expressions (CTEs)** are used to create a temporary result set (RowNumCTE) that assigns a row number to each record within groups defined by the **PARTITION BY** clause. Records with the same combination of ParcelID, PropertyAddress, SalePrice, SaleDate, and LegalReference are considered duplicates. The row_num column indicates the occurrence of each record within its group. The final SELECT statement retrieves duplicate rows where row_num is greater than 1, indicating duplicate occurrences.
7. **Delete Unused Columns**:
    - The aim of this step is to remove unused columns from the dataset to improve data clarity and efficiency. The **ALTER TABLE** statement with the **DROP COLUMN** clause is used to permanently remove the specified columns (OwnerAddress, PropertyAddress, SaleDate) from the nashville table. These columns are considered unnecessary for further analysis after completing the data cleaning process.

### SQL Queries:
---
For the rest of the code, check the [SQL Code](NashvilleHousing.sql) file
```SQL
CREATE DATABASE nashville_housing;
---import nashville housing csv file

SELECT *
FROM nashville_housing.dbo.nashville;

```

### Data Cleaning Challenges
---
During the data cleaning process, several challenges were encountered, including missing values in the some columns, inconsistencies in date formats, and duplicate rows in the dataset. These challenges were addressed using various SQL queries and data manipulation techniques.

### Data Cleaning Results
The data cleaning process resulted in a cleaned dataset ready for further analysis. A total of 56,00+ columns were cleaneand, including filling in missing address information, standardizing date formats, and removing 104 duplicate rows. The cleaned dataset provides a reliable foundation for future analysis and exploration. For updated and cleaned version of the dataset - [Download Cleaned Dataset Here](NashvilleHousing-Cleaned.csv) 

## Data Usage
The cleaned dataset can be used for various analyses, including exploratory data analysis, predictive modeling, and trend analysis. It can provide valuable insights into the Nashville housing market, support real estate market analysis, and inform policy decisions related to housing.




