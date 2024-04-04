--DATA CLEANING SQL QUERIES
SELECT *
FROM nashville_housing.dbo.nashville;

--------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format
SELECT CONVERT(Date,SaleDate) AS saleDateConverted
FROM nashville_housing.dbo.nashville;

ALTER TABLE nashville
Add saleDateConverted Date;

UPDATE nashville
SET SaleDateConverted = CONVERT(Date,SaleDate);

-----------------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data using the ParseID as reference
SELECT *
FROM nashville_housing.dbo.nashville
--WHERE PropertyAddress IS NULL;
ORDER BY ParcelID;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,
ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM nashville_housing.dbo.nashville a 
JOIN nashville_housing.dbo.nashville b 
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM nashville_housing.dbo.nashville a 
JOIN nashville_housing.dbo.nashville b 
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

----------------------------------------------------------------------------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City, State)
SELECT PropertyAddress
FROM nashville_housing.dbo.nashville;

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) AS PropertySplitAddress,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as PropertySplitCity
FROM nashville_housing.dbo.nashville;

---------------------address
ALTER TABLE nashville
ADD PropertySplitAddress Nvarchar(255);

UPDATE nashville
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 );

------------city
ALTER TABLE nashville
ADD PropertySplitCity Nvarchar(255);

UPDATE nashville
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress));

----------------------------------------------------------------------------------------------------------------------------------------
-- Breaking out Owner Address into Individual Columns (Address, City, State)
SELECT OwnerAddress
FROM nashville_housing.dbo.nashville;

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)  
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2) 
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1) 
FROM nashville_housing.dbo.nashville;

-----------------address
ALTER TABLE nashville
ADD OwnerSplitAddress Nvarchar(255);

UPDATE nashville
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

----------------city
ALTER TABLE nashville
ADD OwnerSplitCity Nvarchar(255);

UPDATE nashville
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

------------state
ALTER TABLE nashville
Add OwnerSplitStates Nvarchar(255);

UPDATE nashville
SET OwnerSplitStates = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1);


-- Change Y and N to Yes and No in "Sold as Vacant" field
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM nashville_housing.dbo.nashville
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
FROM nashville_housing.dbo.nashville;


UPDATE nashville
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
FROM nashville_housing.dbo.nashville 
--ORDER BY ParcelID 
)
--104 DUPLICATE ROWS FOUND

--Deleting duplicate rows
--DELETE
--FROM RowNumCTE
--WWHERE row_num > 1

SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;

---------------------------------------------------------------------------------------------------------
-- Delete Unused Columns
SELECT *
FROM nashville_housing.dbo.nashville

ALTER TABLE nashville
DROP COLUMN OwnerAddress, PropertyAddress, SaleDate




