CREATE PROCEDURE dbo.UpdateDimProductCategory
	@ProductCategoryId int,
	@ProductCategoryName nvarchar(50),
	@ModifiedDate datetime
	as
	begin
	if not exists (
		select ProductCategorySK
		from dbo.DimProductCategory
		where AlternateProductCategoryID = @ProductCategoryID
		)
		
		BEGIN
			insert into dbo.DimProductCategory(AlternateProductCategoryID, ProductCategoryName, SrcModifiedDate, InsertDate, ModifiedDate) 
			values(@ProductCategoryID, @ProductCategoryName, @ModifiedDate, GETDATE(), GETDATE())
		END;

	if exists (
		select ProductCategorySK
		from dbo.DimProductCategory
		where AlternateProductCategoryID = @ProductCategoryID
		)
		
		BEGIN
			update dbo.DimProductCategory
			set ProductCategoryName = @ProductCategoryName,
			SrcModifiedDate = @ModifiedDate,
			ModifiedDate = GETDATE()
			where AlternateProductCategoryID = @ProductCategoryID
		END;
END;

CREATE PROCEDURE dbo.UpdateDimProductSubCategory 
	@ProductSubCategoryID int,
	@ProductCategoryKey int,
	@ProductSubCategoryName nvarchar(50), 
	@ModifiedDate datetime
	AS
	BEGIN
	if not exists (
		select ProductSubCategorySK
		from dbo.DimProductSubCategory
		where AlternateProductSubCategoryID = @ProductSubCategoryID
		)
		
		BEGIN
			insert into dbo.DimProductSubCategory (AlternateProductSubCategoryID, ProductCategoryKey, ProductSubCategoryName, SrcModifiedDate, InsertDate, ModifiedDate)
			values (@ProductSubCategoryID, @ProductCategoryKey, @ProductSubCategoryName, @ModifiedDate, GETDATE(), GETDATE())
		END;

	if exists (
		select ProductSubCategorySK
		from dbo.DimProductSubCategory
		where AlternateProductSubCategoryID = @ProductSubCategoryID)
		
		BEGIN
			update dbo.DimProductSubCategory
			set ProductCategoryKey = @ProductCategoryKey,
			ProductSubCategoryName = @ProductSubCategoryName,
			SrcModifiedDate = @ModifiedDate,
			ModifiedDate = GETDATE()
			where AlternateProductSubCategoryID = @ProductSubCategoryID
		END;
END;

CREATE PROCEDURE dbo.UpdateDimProduct 
	@ProductID int,
	@ProductName nvarchar(50), 
	@ProductNumber nvarchar(25), 
	@MakeFlag bit,
	@FinishedGoodsFlag bit, 
	@Color nvarchar(15), 
	@SafetyStockLevel smallint, 
	@ReorderPoint smallint, 
	@StandardCost money, 
	@ListPrice money,
	@Size nvarchar(5),
	@SizeUnitMeasureCode nvarchar(3),
	@Weight decimal(8,2),
	@WeightUnitMeasureCode nvarchar(3),
	@ProductSubCategoryKey int
	AS
	BEGIN
	if not exists (
		select ProductSK 
		from dbo.DimProduct
		where AlternateProductID = @ProductID
		)

		BEGIN
			insert into dbo.DimProduct (AlternateProductID, ProductName, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, [Weight], WeightUnitMeasureCode, ProductSubCategoryKey, InsertDate, ModifiedDate)
			values(@ProductID, @ProductName, @ProductNumber, @MakeFlag, @FinishedGoodsFlag, @Color, @SafetyStockLevel, @ReorderPoint, @StandardCost, @ListPrice, @Size, @SizeUnitMeasureCode, @Weight, @WeightUnitMeasureCode, @ProductSubCategoryKey, GETDATE(), GETDATE())
		END;
	
	if exists (
		select ProductSK 
		from dbo.DimProduct 
		where AlternateProductID = @ProductID
		)
		
		BEGIN
			update dbo.DimProduct
			set ProductName = @ProductName, ProductNumber = @ProductNumber, MakeFlag = @MakeFlag,
				FinishedGoodsFlag = @FinishedGoodsFlag, Color = @Color, SafetyStockLevel = @SafetyStockLevel,
				ReorderPoint = @ReorderPoint, StandardCost = @StandardCost, ListPrice = @ListPrice,
				Size = @Size, SizeUnitMeasureCode = @SizeUnitMeasureCode, [Weight] = @Weight,
				WeightUnitMeasureCode = @WeightUnitMeasureCode, ProductSubCategoryKey = @ProductSubCategoryKey, ModifiedDate = GETDATE()
			where AlternateProductID = @ProductID
		END;
END;