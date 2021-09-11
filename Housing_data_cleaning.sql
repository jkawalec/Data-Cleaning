Select *
From [portfolio project]..NashvilleHousing

-- Standardize Date Format

Select SaledateConverted, CONVERT(Date,Saledate)
From [portfolio project]..NashvilleHousing

Update [portfolio project]..NashvilleHousing
SET SaleDate = CONVERT(Date,Saledate)

Alter table [portfolio project]..NashvilleHousing
Add SaleDateConverted Date;

Update [portfolio project]..NashvilleHousing
Set SaleDateConverted= Convert(Date,Saledate)


-- Populate Property Address

Select Propertyaddress
From [portfolio project]..NashvilleHousing
Where PropertyAddress is null

Select * 
From [portfolio project]..NashvilleHousing
--Where PropertyAddress is null
Order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
From [portfolio project]..NashvilleHousing a
join [portfolio project]..NashvilleHousing b
	on a.parcelid = b.parcelid
	and a.[uniqueid ] <> b.[uniqueid ]
Where a.PropertyAddress is null


Update a
SET propertyaddress = ISNULL(a.propertyaddress,b.propertyaddress)
From [portfolio project]..NashvilleHousing a
join [portfolio project]..NashvilleHousing b
	on a.parcelid = b.parcelid
	and a.[uniqueid ] <> b.[uniqueid ]
Where a.PropertyAddress is null


-- Breaking Out Address into Individual Columns

Select PropertyAddress
From [portfolio project]..NashvilleHousing

Select 
SUBSTRING(PropertyAddress,1,Charindex(',',PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address
From [portfolio project]..NashvilleHousing

Alter table [portfolio project]..NashvilleHousing
Add Propertysplitaddress Nvarchar(255);


Update [portfolio project]..NashvilleHousing
set Propertysplitaddress = SUBSTRING(PropertyAddress,1,Charindex(',',PropertyAddress) -1)

Alter table [portfolio project]..NashvilleHousing
Add Propertysplitcity Nvarchar(255);

Update [portfolio project]..NashvilleHousing
set Propertysplitcity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))

Select * 
From [portfolio project]..NashvilleHousing

Select OwnerAddress
From [portfolio project]..NashvilleHousing

Select
PARSENAME(Replace(OwnerAddress,',','.') ,3),
PARSENAME(Replace(OwnerAddress,',','.') ,2),
PARSENAME(Replace(OwnerAddress,',','.') ,1)
from [portfolio project]..NashvilleHousing


Alter Table [portfolio project]..NashvilleHousing
Add Ownersplitaddress Nvarchar(255);

Update [portfolio project]..NashvilleHousing
SET Ownersplitaddress = PARSENAME(Replace(OwnerAddress,',','.') ,3)

Alter Table [portfolio project]..NashvilleHousing
Add Ownersplitcity Nvarchar(255);

Update [portfolio project]..NashvilleHousing
Set Ownersplitcity = PARSENAME(Replace(OwnerAddress,',','.') ,2)

Alter Table [portfolio project]..NashvilleHousing
Add Ownersplitstate Nvarchar(255);

Update [portfolio project]..NashvilleHousing
Set Ownersplitstate = PARSENAME(Replace(OwnerAddress,',','.') ,3)

Select *
From [portfolio project]..NashvilleHousing

-- Change Y and N to Yes and No for 'Sold as Vacant' field

Select Distinct(soldasvacant)
From [portfolio project]..NashvilleHousing

Select Soldasvacant
, CASE When SoldAsVacant = 'Y' Then 'Yes'
	When SoldAsVacant = 'N' Then 'No'
	Else SoldAsVacant
	end
From [portfolio project]..NashvilleHousing

Update [portfolio project]..NashvilleHousing
Set soldasvacant = CASE when soldasvacant = 'Y' Then 'Yes'
	When soldasvacant = 'N' Then 'No'
	Else Soldasvacant
	End


--Remove Duplicates

With RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER(
	Partition BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order By 
					UniqueID
					) row_num
From [portfolio project]..NashvilleHousing
--order by ParcelID
)
Delete
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress



--Delete Unused Column

Select *
From [portfolio project]..NashvilleHousing

Alter Table [portfolio project]..NashvilleHousing
Drop Column OwnerAddress,TaxDistrict,PropertyAddress

Alter Table [portfolio project]..NashvilleHousing
Drop Column SaleDate
