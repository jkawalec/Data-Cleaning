![Logo](https://s3.amazonaws.com/mlsphotos.idxbroker.com/photos/3c87/78c3b9bfecdd715421b862f4dba465f6/b022)

    
# Housing Data Cleaning

In this project, We are going to clean data using data cleaning techniques from a Nashville Housing Dataset


## Authors

- [@jkawalec](https://www.github.com/jkawalec)

  
## Installation

Used Microsoft SQL Server for this entire project

Install Microsoft SQL Server at: https://www.microsoft.com/en-us/sql-server/sql-server-downloads

Housing Dataset used: https://github.com/jkawalec/Housing-Data-Cleaning/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx

SQL server project file: https://github.com/jkawalec/Housing-Data-Cleaning/blob/main/Housing_data_cleaning.sql

    
## Usage

Use this project as a way to use data cleaning techniques for messy datasets. Using SQL to properly clean and standardize a dataset.


```javascript
Select SaledateConverted, CONVERT(Date,Saledate)
From [portfolio project]..NashvilleHousing

Update [portfolio project]..NashvilleHousing
SET SaleDate = CONVERT(Date,Saledate)

Alter table [portfolio project]..NashvilleHousing
Add SaleDateConverted Date;

Update [portfolio project]..NashvilleHousing
Set SaleDateConverted= Convert(Date,Saledate)

```

```javascript
Update a
SET propertyaddress = ISNULL(a.propertyaddress,b.propertyaddress)
From [portfolio project]..NashvilleHousing a
join [portfolio project]..NashvilleHousing b
	on a.parcelid = b.parcelid
	and a.[uniqueid ] <> b.[uniqueid ]
Where a.PropertyAddress is null

``` 
