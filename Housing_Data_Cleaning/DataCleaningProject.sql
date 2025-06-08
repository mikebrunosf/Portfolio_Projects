/* Cleaning data in SQl Queries */
Select
*
From [Portfolio Project]..Nashville_Housing

Select
SaleDate, CONVERT(Date, SaleDate)
FROM
[Portfolio Project]..Nashville_Housing

Select
SaleDateConverted, CONVERT(Date, SaleDate)
FROM
[Portfolio Project]..Nashville_Housing

/*
Update Nashville_Housing
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE Nashville_Housing ALTER COLUMN SaleDate DATE
*/

-- Populate Property Address data

Select *
From [Portfolio Project]..Nashville_Housing
--Where PropertyAddress is null
order by ParcelID

Select
a.parcelID, a.PropertyAddress, b.parcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From [Portfolio Project]..Nashville_Housing a
JOIN [Portfolio Project]..Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
--Where a.PropertyAddress is NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b. PropertyAddress)
FROM [Portfolio Project]..Nashville_Housing a
JOIN [Portfolio Project]..Nashville_Housing b
on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From [Portfolio Project]..nashville_housing
--Where PropertyAddress is null
--order by ParcelID

Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
From [Portfolio Project]..nashville_housing

ALTER TABLE Nashville_Housing
Add PropertySplitAddress Nvarchar(255);

Update Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE Nashville_Housing
Add PropertySplitCity Nvarchar(255);

Update Nashville_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [Portfolio Project]..nashville_housing

ALTER TABLE Nashville_Housing
Add OwnerSplitAddress Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Nashville_Housing
Add OwnerSplitCity Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE Nashville_Housing
Add OwnerSplitState Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [Portfolio Project]..nashville_housing
Group by SoldAsVacant
order by 2

Select SoldAsVacant,
 CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [Portfolio Project]..nashville_housing

Update Nashville_Housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() Over(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From [Portfolio Project]..nashville_housing)
--Order by ParcelID

----Delete Duplicates (Delete/Select)
Select *
From RowNumCTE
Where row_num > 1
Order By PropertyAddress

-- Delete Unused Columns

Select *
From [Portfolio Project]..nashville_housing

ALTER TABLE[Portfolio Project]..nashville_housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
ALTER TABLE[Portfolio Project]..nashville_housing
DROP COLUMN SaleDateConverted


