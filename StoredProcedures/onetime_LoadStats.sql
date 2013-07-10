USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[onetime_LoadStats]    Script Date: 07/12/2011 14:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Winston Jansz
-- Create date: Feb 09, 2011
-- Description:	Populate Stats table with counts
-- =============================================
ALTER PROCEDURE [dbo].[onetime_LoadStats] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
    DECLARE
     @items        int    = NULL
    ,@colls        int    = NULL
    ,@repos        int    = NULL

    -- ItemCount
    select @items = COUNT(1) from dbo.Records;
    
    -- CollectionCount
    select cid,COUNT(1) from dbo.Records
    group by cid
    having COUNT(1) > 0;
    SET @colls = @@ROWCOUNT;
    
    -- InstitutionCount
    select repoID,COUNT(1) from dbo.Records
    group by repoID
    having COUNT(1) > 0;
    SET @repos = @@ROWCOUNT;
    
    -- Finally, inset into Stats table
    INSERT INTO [dbo].[Stats] 
        (ItemCount, CollectionCount, InstitutionCount) 
        VALUES 
        (@items, @colls, @repos);

END

GO

