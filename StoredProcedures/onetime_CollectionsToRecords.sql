USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[onetime_CollectionsToRecords]    Script Date: 07/12/2011 14:32:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Winston Jansz
-- Create date: Nov 12, 2010
-- Description:	Add collection-level (parent/grandparent) 
--              information to item records.
-- =============================================
ALTER PROCEDURE [dbo].[onetime_CollectionsToRecords] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE
     @iter       int            = NULL   -- for loop iteration
    ,@min_ID     int            = NULL
    ,@max_ID     int            = NULL
    ,@id         int            = NULL
    ,@descr      nvarchar(max)  = NULL   -- for description column
    ,@pDescr     nvarchar(max)  = NULL
    ,@xml        xml            = NULL   -- for XMLBlob column
    ,@pXml       xml            = NULL
    -- Insert statements for procedure here
    CREATE TABLE tmpRelCollections (
             ID                  int              NOT NULL
            ,parent_ID           int              NOT NULL
            ,description         nvarchar(max)    NOT NULL
            ,parent_description  nvarchar(max)
            ,XMLBlob             xml              NOT NULL
            ,parent_XMLBlob      xml
                ,CONSTRAINT PK_TMPRC PRIMARY KEY CLUSTERED ( ID )
    );
    CREATE INDEX NDX_parent_ID ON tmpRelCollections ( parent_ID ASC );

    INSERT INTO tmpRelCollections
        (ID, parent_ID, description, XMLBlob)
        (SELECT collID, parentID, description, XMLBlob FROM dbo.Collections);

    UPDATE p
        SET  p.parent_description = gp.description
            ,p.parent_XMLBlob     = gp.XMLBlob
                FROM tmpRelCollections p
                INNER JOIN tmpRelCollections gp
                ON p.parent_ID = gp.ID
                WHERE p.parent_ID <> 0;
    
    -- Create temp index on Records table
    CREATE INDEX NDXtmp_cid ON dbo.Records ( cid );
    
    select   @min_ID = MIN(ID)
            ,@max_ID = MAX(ID)
    from tmpRelCollections;
    
    set @iter = @min_ID;
    while @iter <= @max_ID
    begin
        select @descr  = description
              ,@xml    = XMLBlob
              ,@pDescr = parent_description
              ,@pXml   = parent_XMLBlob
        from tmpRelCollections
        where ID = @iter;
    
        if @@ROWCOUNT > 0   -- then update Records table
        begin
            update dbo.Records
            set parent_description = @descr
               ,parent_XMLBlob     = @xml
               ,grandp_description = @pDescr
               ,grandp_XMLBlob     = @pXml
            where cid = @iter;
        end

        set @iter = 1 + @iter;
    end
    
    -- Dropping the temp index created above...
    DROP INDEX dbo.Records.NDXtmp_cid;
    
    -- Drop the temp table
    DROP TABLE tmpRelCollections;
    
END

GO

