-- First set the DB name below;
-- AND ALSO correct the DB name of the "SNAPSHOT" DB! -- search for "_snapshot"
USE [_IMLS_Items]
GO


/****** Object:  StoredProcedure [dbo].[onetime_updateItemCounts]    Script Date: 04/05/2012 17:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to update the itemCount
--				in Collections Table (only after
--				RecordsToMultiple Collections 
--				table has been populated
--		Could also do with trigger?
-- =============================================
ALTER PROCEDURE [dbo].[onetime_updateItemCounts] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @cid int;
	DECLARE @itemCount int;
	DECLARE myRow CURSOR LOCAL FOR
		(select collID as cid, COUNT(collid) as itemCount from RecordsToMultipleCollections group by collID);
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @cID, @itemCount;
	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE [dbo].[Collections] 
			SET [itemCount] = @itemCount
			WHERE collID = @cid
			FETCH NEXT FROM myRow INTO @cID, @itemCount;
		END
	CLOSE myRow;
	DEALLOCATE myRow;

END
GO


/****** Object:  StoredProcedure [dbo].[onetime_populateCollInstNameBrowse]    Script Date: 04/05/2012 17:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to update the itemCount
--				in Collections Table (only after
--				RecordsToMultiple Collections 
--				table has been populated
--		Could also do with trigger?
-- =============================================
ALTER PROCEDURE [dbo].[onetime_populateCollInstNameBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- This SP assumes all records have one and only one non-null titleText value
	
	-- need to modify not to get institution names associated with non-NLG physical collections, etc.
	-- need to modify not to put rows in pivot table that connect to non-NLG physical collections, etc.

	DECLARE @collID int;
	DECLARE @collInstNameID int;
	DECLARE @collInstNameText nvarchar(max);
	DECLARE @InstitutionID int;
	DECLARE myRow CURSOR LOCAL FOR
		(select i.institutionName as institution, ci.collectionID as collid, i.InstitutionID as InstitutionID
			from [_snapshot20110804_IH_IMLS].[dbo].[CollectionInstitutions] ci
			join [_snapshot20110804_IH_IMLS].[dbo].[Institutions] i on ci.institutionID = i.institutionID );
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @collInstNameText, @collID, @InstitutionID;
	WHILE @@FETCH_STATUS = 0
		BEGIN			   
		   
		   IF LEN(@collInstNameText) > 120
			 SET @collInstNameText = LEFT(@collInstNameText, 120) + '...'
			 
		   WHILE LEFT(@collInstNameText, 1) = '['
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '&amp;'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 6, 127)
		   WHILE LEFT(@collInstNameText, 1) = '&lt;'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 5, 127)
		   WHILE LEFT(@collInstNameText, 1) = '&gt;'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 5, 127)
		   WHILE LEFT(@collInstNameText, 1) = '&apos;'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 7, 127)
		   WHILE LEFT(@collInstNameText, 1) = '&quot;'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 7, 127)
		   WHILE LEFT(@collInstNameText, 1) = ''''
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '"'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '&nbsp;'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 7, 127)
		   WHILE LEFT(@collInstNameText, 1) = '('
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '{'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = ']'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = ')'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '}'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '.'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = ','
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = ';'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = ':'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '/'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '\'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '_'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 3, 127)
		   WHILE LEFT(@collInstNameText, 1) = '-'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '?'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   WHILE LEFT(@collInstNameText, 1) = '!'
		      SET @collInstNameText = SUBSTRING(@collInstNameText, 2, 127)
		   SET @collInstNameText = LTRIM(@collInstNameText)
		   SET @collInstNameText = RTRIM(@collInstNameText)
			
			IF EXISTS(select * from [dbo].[CollInstNameBrowse] tb where tb.CollInstNameText = @collInstNameText)
				set @collInstNameID = (select CollInstNameID from [dbo].[CollInstNameBrowse] tb where tb.CollInstNameText = @collInstNameText);
			ELSE
			  BEGIN	 
				insert into [dbo].[CollInstNameBrowse] (CollInstNameText, InstitutionID) VALUES (@collInstNameText, @InstitutionID);
				set @collInstNameID = (select @@IDENTITY);
			  END
			  
			insert into [dbo].[CollectionsToCollInstName] (CollID, CollInstNameID) VALUES (@collID, @collInstNameID);
			
			FETCH NEXT FROM myRow INTO @collInstNameText, @collID, @InstitutionID;
		END
		
	CLOSE myRow;
	DEALLOCATE myRow;
	
	--DECLARE @InstitutionID int;
	DECLARE @CollInstStateID int;
	DECLARE @CollInstTypeID int;
	DECLARE myRow2 CURSOR LOCAL FOR
		(select cin.institutionID, cis.CollInstStateID, cit.CollInstTypeID
			from [dbo].[CollInstNameBrowse] cin
			join [_snapshot20110804_IH_IMLS].[dbo].[InstitutionProperties] ip1 on cin.InstitutionID = ip1.InstitutionID
			join [_snapshot20110804_IH_IMLS].[dbo].[InstitutionProperties] ip2 on cin.InstitutionID = ip2.InstitutionID
			join [dbo].[CollInstStateBrowse] cis on ip1.[text] = cis.CollInstStateText
			join [dbo].[CollInstTypeBrowse] cit on ip2.[text] = cit.TypeOfInstText			
			where ip1.[property] = 'state'
			and ip2.[property] = 'type_institution'			
			);
			    
	OPEN myRow2;
	FETCH NEXT FROM myRow2 INTO @InstitutionID, @CollInstStateID, @collInstTypeID;
	
	WHILE @@FETCH_STATUS = 0
		BEGIN	
		
		UPDATE [dbo].[CollInstNameBrowse] 
			set CollInstStateID = @CollInstStateID
			Where institutionID = @InstitutionID;

		UPDATE [dbo].[CollInstNameBrowse] 
			set collInstTypeID = @collInstTypeID
			Where institutionID = @InstitutionID;
		
		FETCH NEXT FROM myRow2 INTO @InstitutionID, @CollInstStateID, @collInstTypeID;

		END	
		
	CLOSE myRow2;
	DEALLOCATE myRow2;
	


END
GO


/****** Object:  StoredProcedure [dbo].[onetime_populateCollInstStateBrowse]    Script Date: 04/05/2012 17:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to update the itemCount
--				in Collections Table (only after
--				RecordsToMultiple Collections 
--				table has been populated
--		Could also do with trigger?
-- =============================================
ALTER PROCEDURE [dbo].[onetime_populateCollInstStateBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	-- may need to modify not to get institution names associated with non-NLG physical collections, etc.
	-- may need to modify not to put rows in pivot table that connect to non-NLG physical collections, etc.

	SET NOCOUNT ON;

	INSERT INTO [dbo].[CollInstStateBrowse] (CollInstStateText)
		Select distinct ip.[text] from [_snapshot20110804_IH_IMLS].[dbo].[InstitutionProperties] ip
		  where ip.[property] = 'state'
		   and ip.institutionID in 
		      (select distinct i.institutionID from [_snapshot20110804_IH_IMLS].[dbo].[Institutions] i
					join [_snapshot20110804_IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = i.institutionID
					where ci.collectionID in (select distinct collid from [dbo].[Collections]));
     	    

   	DECLARE @iStateText as nvarchar(120);
	DECLARE myRow CURSOR LOCAL FOR
		(select cisb.CollInstStateText from [dbo].[CollInstStateBrowse] cisb);

	OPEN myRow;
	FETCH NEXT FROM myRow INTO @iStateText;
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		INSERT INTO [dbo].[CollectionsToCollInstState] (CollInstStateID, CollID)
		  SELECT distinct cisb.CollInstStateID, ci.collectionid
		  FROM [_snapshot20110804_IH_IMLS].[dbo].[InstitutionProperties] ip
		  join [_snapshot20110804_IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = ip.institutionID
		  join [dbo].[CollInstStateBrowse] cisb on cisb.CollInstStateText = ip.[text]  
		  where ip.[property] = 'state'
			and cisb.CollInstStateText = @iStateText
			and ci.collectionID in (select distinct collid from [dbo].[Collections]);	
		FETCH NEXT FROM myRow INTO @iStateText;
	  END
	  
	  CLOSE myRow;
	  DEALLOCATE myRow;
END
GO


/****** Object:  StoredProcedure [dbo].[onetime_populateCollInstTypeBrowse]    Script Date: 04/05/2012 17:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to update the itemCount
--				in Collections Table (only after
--				RecordsToMultiple Collections 
--				table has been populated
--		Could also do with trigger?
-- =============================================
ALTER PROCEDURE [dbo].[onetime_populateCollInstTypeBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[CollInstTypeBrowse] (TypeOfInstText)
		Select distinct ip.[text] from [_snapshot20110804_IH_IMLS].[dbo].[InstitutionProperties] ip
		  where ip.[property] = 'type_institution'
		   and ip.institutionID in 
		      (select distinct i.institutionID from [_snapshot20110804_IH_IMLS].[dbo].[Institutions] i
					join [_snapshot20110804_IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = i.institutionID
					where ci.collectionID in (select distinct collid from [dbo].[Collections]));
     	    

   	DECLARE @iTypeText as nvarchar(120);
	DECLARE myRow CURSOR LOCAL FOR
		(select citb.TypeOfInstText from [dbo].[CollInstTypeBrowse] citb);

	OPEN myRow;
	FETCH NEXT FROM myRow INTO @iTypeText;
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		INSERT INTO [dbo].[CollectionsToCollInstType] (CollInstTypeID, CollID, relationship)
		  SELECT distinct ctib.CollInstTypeID, ci.collectionid, ci.relationship
		  FROM [_snapshot20110804_IH_IMLS].[dbo].[InstitutionProperties] ip
		  join [_snapshot20110804_IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = ip.institutionID
		  join [dbo].[CollInstTypeBrowse] ctib on ctib.TypeOfInstText = ip.[text]  
		  where ip.[property] = 'type_institution'
			and ctib.TypeOfInstText = @iTypeText
			and ci.collectionID in (select distinct collid from [dbo].[Collections]);	
		FETCH NEXT FROM myRow INTO @iTypeText;
	  END
	  
	  CLOSE myRow;
	  DEALLOCATE myRow;
END
GO

