/*
 Cleaning Data in SQL Queries
 */

SELECT *
FROM nashvillehouse;

--Standardize Date Format
ALTER TABLE nashvillehouse ADD COLUMN NewDate DATE;

UPDATE nashvillehouse SET NewDate = CAST(SaleDate AS DATE) WHERE (SaleDate <> '') AND (SaleDate IS NOT NULL);

ALTER TABLE nashvillehouse
DROP COLUMN saledate;

ALTER TABLE nashvillehouse
RENAME COLUMN NewDate TO saledate;


--Populate Property Address data
SELECT a.uniqueid, a.parcelid, a.propertyaddress, b.propertyaddress, COALESCE(a.propertyaddress, b.propertyaddress) AS new_address
FROM nashvillehouse a
JOIN nashvillehouse b
    ON a.parcelid = b.parcelid
    AND a.uniqueid <> b.uniqueid
WHERE a.propertyaddress IS NULL;

UPDATE nashvillehouse a
SET propertyaddress = b.propertyaddress
FROM nashvillehouse b
WHERE a.parcelid = b.parcelid
  AND a.uniqueid <> b.uniqueid
  AND a.propertyaddress IS NULL;

--Breaking out Address into Individual Columns (Address, City, State)
SELECT propertyaddress
FROM nashvillehouse;

SELECT
    SUBSTRING(propertyaddress, 1, POSITION(',' in propertyaddress) -1) AS address,
    SUBSTRING(propertyaddress, POSITION(',' in propertyaddress) +1, length(propertyaddress)) AS city
FROM nashvillehouse;

ALTER TABLE nashvillehouse ADD COLUMN PropertySplitAddress VARCHAR(120);
ALTER TABLE nashvillehouse ADD COLUMN PropertySplitCity VARCHAR(120);

UPDATE nashvillehouse SET PropertySplitAddress = SUBSTRING(propertyaddress, 1, POSITION(',' in propertyaddress) -1);
UPDATE nashvillehouse SET PropertySplitCity = SUBSTRING(propertyaddress, POSITION(',' in propertyaddress) +1, length(propertyaddress));

ALTER TABLE nashvillehouse
DROP COLUMN propertyaddress;

--Split to string owneraddress

SELECT owneraddress
FROM nashvillehouse;


SELECT
    owneraddress,
    SPLIT_PART(owneraddress, ',', 1) AS address,
    SPLIT_PART(owneraddress, ',', 2) AS city,
    SPLIT_PART(owneraddress, ',', 3) AS state
FROM nashvillehouse;


ALTER TABLE nashvillehouse ADD COLUMN OwnerSplitAddress VARCHAR(120);
ALTER TABLE nashvillehouse ADD COLUMN OwnerSplitCity VARCHAR(120);
ALTER TABLE nashvillehouse ADD COLUMN OwnerSplitState VARCHAR(120);

UPDATE nashvillehouse SET OwnerSplitAddress = SPLIT_PART(owneraddress, ',', 1);
UPDATE nashvillehouse SET OwnerSplitCity = SPLIT_PART(owneraddress, ',', 2);
UPDATE nashvillehouse SET OwnerSplitState = SPLIT_PART(owneraddress, ',', 3);

ALTER TABLE nashvillehouse
DROP COLUMN owneraddress;

SELECT * FROM nashvillehouse;


-- Change Y and N to Yes and No in "Sold as Vacant" field
SELECT DISTINCT(soldasvacant), COUNT(soldasvacant)
FROM nashvillehouse
GROUP BY soldasvacant
ORDER BY 2;

SELECT soldasvacant, CASE
       WHEN soldasvacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From nashvillehouse;

UPDATE nashvillehouse
SET soldasvacant = CASE
       WHEN soldasvacant = 'Y' THEN 'Yes'
	   WHEN soldasvacant = 'N' THEN 'No'
	   ELSE soldasvacant
	   END;


--Finding Duplicates
WITH RowNumCTE AS (SELECT *,
                          ROW_NUMBER() OVER (
                              PARTITION BY parcelid, PropertySplitAddress, saleprice, saledate, legalreference
                              ORDER BY UniqueID
                              ) AS row_num
                   FROM nashvillehouse)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertySplitAddress;


-- Remove Duplicates
WITH CTE AS (
                SELECT *, ROW_NUMBER()
                OVER (
                PARTITION BY parcelid, PropertySplitAddress, saleprice, saledate, legalreference
                ORDER BY UniqueID
                    ) AS del
                FROM nashvillehouse
                )
DELETE from CTE
WHERE del > 1;

--
SELECT * FROM nashvillehouse;