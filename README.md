# Nashville Housing Data Cleaning Project
![Housing](image_intro.jpg)

## Project Overview
This project involves cleaning the Nashville housing dataset to prepare it for analysis. The dataset contains information about properties in Nashville, including details like ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, etc.

## Data Description
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

## Data Source
The dataset is provided in CSV format. (56477

### Tools
---
- Microsoft Excel for Data Cleaning and Preparation
     - [Download Dataset Here](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)
- Microsoft SQL Server for Data Manipulation and Exploration
- Tableau for Data Visualization
  
## Approach
### Data Cleaning Steps:
1. **Standardize Date Format**: Convert the `SaleDate` column to a standardized date format.
2. **Populate Property Address**: Fill in missing `PropertyAddress` values using `ParcelID` as a reference.
3. **Break out Address into Individual Columns**: Split `PropertyAddress` into separate columns for address, city, and state.
4. **Break out Owner Address into Individual Columns**: Split `OwnerAddress` into separate columns for address, city, and state.
   > yuojsogiolsls
6. **Change Y and N to Yes and No**: Update values in the `SoldAsVacant` column to standardize them.
7. **Remove Duplicates**: Identify and remove duplicate rows based on selected criteria.
8. **Delete Unused Columns**: Remove columns that are no longer needed after cleaning.

### SQL Queries:
### SQL Code
---
For the rest of the code, check the [SQL Code](SQLQuery.sql) file
```SQL
CREATE DATABASE healthcare_database;

---import helathcare csv file

SELECT *
  FROM healthcare;


```
Below are the SQL queries used for each step of the data cleaning process:


## Data Cleaning Challenges
During the data cleaning process, several challenges were encountered, including missing values in the `PropertyAddress` and `OwnerAddress` columns, inconsistencies in date formats, and duplicate rows in the dataset. These challenges were addressed using various SQL queries and data manipulation techniques.

## Data Cleaning Results
The data cleaning process resulted in a cleaned dataset ready for further analysis. A total of X rows were cleaned, including filling in missing address information, standardizing date formats, and removing duplicate rows. The cleaned dataset provides a reliable foundation for future analysis and exploration.

## Data Usage
The cleaned dataset can be used for various analyses, including exploratory data analysis, predictive modeling, and trend analysis. It can provide valuable insights into the Nashville housing market, support real estate market analysis, and inform policy decisions related to housing.




