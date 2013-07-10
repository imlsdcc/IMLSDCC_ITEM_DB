-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	This SQL script is intended for executing in a new, empty DB.  It may be
--              run by:
--              (1) first loading this SQL script into a new Query Window (in MS SQL Server),
--              (2) and then invoking Execute in the Query Window in order to run the script.
--              This will result in several USPs (with names of the form:  setupdb_*) being 
--              created in the new DB.  (As well as other USPs, UDFs, etc.)  Running these
--              setupdb_* USPs, _in_sequence_, will setup the new DB.
--
-- *** NOTES ***
-- (1) The DB Name must first be set (immediately below).
-- (2) There is a 2nd DB (search below for the string "ih_") required/called at several
--     points in the SQL below.  If necessary, correct the DB's name in the occurences below.
--
-- ==========================================================================================



--
-- First, the DB Name must be set:
--
USE [test_IMLS_Items2]
GO



--
-- Instructions
--
select '* NOTE * - Once this script finishes, sequentially run the USPs named setupdb_*.'



--
-- Next, create the Table Type; because it is required later in the USPs/UDFs
--
CREATE TYPE [dbo].[FacetIDType] AS TABLE(
	[facetID] [int] NULL
)
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	In an empty, new database:  Create all the Tables, Primary Keys, Constraints,
--              and Users.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_1a_TblsPKsConstrsUsrs]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;
    
    CREATE USER [UIUC\Grainger IMLS Admin] FOR LOGIN [UIUC\Grainger IMLS Admin]
    
    CREATE USER [UIUC\iusr_libgrrama] FOR LOGIN [UIUC\IUSR_LIBGRRAMA] WITH DEFAULT_SCHEMA=[dbo]
    
    CREATE TABLE [dbo].[Types](
        [typeID] [int] IDENTITY(1,1) NOT NULL,
        [typeText] [nvarchar](max) NOT NULL,
        [typeNoPunct] [nvarchar](max) NOT NULL,
     CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
    (
        [typeID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[TitleBrowse](
        [titleID] [int] IDENTITY(1,1) NOT NULL,
        [titleText] [nvarchar](127) NULL,
     CONSTRAINT [PK_TitleBrowse] PRIMARY KEY CLUSTERED 
    (
        [titleID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[Subjects](
        [subjectID] [int] IDENTITY(1,1) NOT NULL,
        [subjectText] [nvarchar](max) NOT NULL,
        [subjectNoPunct] [nvarchar](max) NOT NULL,
     CONSTRAINT [PK_Subjects] PRIMARY KEY CLUSTERED 
    (
        [subjectID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[Repositories](
        [repoID] [int] IDENTITY(1,1) NOT NULL,
        [repositoryName] [nvarchar](250) NOT NULL,
        [baseURL] [nvarchar](250) NOT NULL,
        [baseDIR] [nvarchar](250) NOT NULL,
        [lastIndexed] [datetime] NULL,
        [displayName] [nvarchar](250) NULL,
        [codeName] [nvarchar](50) NULL,
        [portalCode] [tinyint] NULL,
     CONSTRAINT [PK_Repositories] PRIMARY KEY CLUSTERED 
    (
        [repoID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[Portals](
        [portalCode] [tinyint] NOT NULL,
        [lastUpdated] [datetime] NULL,
        [portalName] [nvarchar](100) NULL,
        [portalURL] [nvarchar](250) NULL,
     CONSTRAINT [PK_Portals] PRIMARY KEY CLUSTERED 
    (
        [portalCode] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    SET ANSI_PADDING ON
    CREATE TABLE [dbo].[Facets](
        [facetID] [int] IDENTITY(1,1) NOT NULL,
        [facetValue] [varchar](100) NOT NULL,
        [parentFacet] [int] NULL,
        [facetType] [varchar](50) NOT NULL,
     CONSTRAINT [PK_Facets] PRIMARY KEY CLUSTERED 
    (
        [facetID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    SET ANSI_PADDING OFF
    
    CREATE TABLE [dbo].[DateBrowse](
        [dateID] [int] IDENTITY(1,1) NOT NULL,
        [dateText] [nvarchar](255) NULL,
     CONSTRAINT [PK_DateBrowse] PRIMARY KEY CLUSTERED 
    (
        [dateID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    /*
    CREATE TABLE [dbo].[Collections](
        [collID] [int] IDENTITY(1,1) NOT NULL,
        [title] [nvarchar](250) NULL,
        [institution] [nvarchar](250) NULL,
        [description] [nvarchar](max) NULL,
        [isAvailableAt_URL] [nvarchar](250) NULL,
        [abstract] [nvarchar](250) NULL,
        [access] [nvarchar](250) NULL,
        [thumbnail] [nvarchar](250) NULL,
        [parentName] [nvarchar](250) NULL,
        [parentID] [int] NULL,
        [XMLBlob] [xml] NULL,
        [XMLBlob_Display] [xml] NULL,
        [portalCode] [tinyint] NULL,
        [itemCount] [int] NULL,
     CONSTRAINT [PK_Registry] PRIMARY KEY CLUSTERED 
    (
        [collID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    */
    
    -- The "new" Collections table schema:
    CREATE TABLE [dbo].[Collections](
        [collID] [int] NOT NULL,
        [itemCount] [int] NOT NULL,
     CONSTRAINT [PK_Registry] PRIMARY KEY CLUSTERED 
    (
        [collID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[Records](
        [recordID] [int] IDENTITY(1,1) NOT NULL,
        [repoID] [int] NULL,
        [cid] [int] NULL,
        [identifier] [nvarchar](250) NULL,
        [datestamp] [datetime] NULL,
        [status] [nvarchar](250) NULL,
        [filePath] [nvarchar](400) NULL,
        [harvestDate] [datetime] NULL,
        [prov_repositoryID] [nvarchar](100) NULL,
        [prov_datestamp] [datetime] NULL,
        [prov_baseURL] [nvarchar](150) NULL,
        [searchXML] [xml] NULL,
        [shortXML] [xml] NULL,
        [longXML] [xml] NULL,
        [AquiferOAIIdentifier] [nvarchar](250) NULL,
        [title] [xml] NULL,
        [creator] [xml] NULL,
        [subject] [xml] NULL,
        [titleText] [nvarchar](300) NULL,
        [titleNoPunct] [nvarchar](300) NULL,
        [parent_description] [nvarchar](max) NULL,
        [portalCode] [tinyint] NULL,
     CONSTRAINT [PK_Records] PRIMARY KEY CLUSTERED 
    (
        [recordID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollectionsToThumbnails](
        [collID] [int] NOT NULL,
        [oaiidentifier1] [nvarchar](250) NULL,
        [oaiidentifier2] [nvarchar](250) NULL,
        [oaiidentifier3] [nvarchar](250) NULL,
        [oaiidentifier4] [nvarchar](250) NULL,
     CONSTRAINT [PK_CollectionsToThumbnails] PRIMARY KEY CLUSTERED 
    (
        [collID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToTypes](
        [recordID] [int] NOT NULL,
        [typeID] [int] NOT NULL
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToTitleBrowse](
        [titlePivotRow] [int] IDENTITY(1,1) NOT NULL,
        [titleID] [int] NOT NULL,
        [recordID] [int] NOT NULL,
     CONSTRAINT [PK_RecordsToTitleBrowse] PRIMARY KEY CLUSTERED 
    (
        [titlePivotRow] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToSubjects](
        [recordID] [int] NOT NULL,
        [subjectID] [int] NOT NULL,
     CONSTRAINT [PK_RecordsToSubjects] PRIMARY KEY CLUSTERED 
    (
        [recordID] ASC,
        [subjectID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToMultipleCollections](
        [RecToCollID] [int] IDENTITY(1,1) NOT NULL,
        [collID] [int] NULL,
        [recordID] [int] NULL,
        [oaiIdentifier] [nvarchar](250) NULL,
        [code] [nvarchar](250) NULL,
        [title] [nvarchar](250) NULL,
     CONSTRAINT [PK_RecordsToMultipleCollections] PRIMARY KEY CLUSTERED 
    (
        [RecToCollID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToFacets](
        [facetID] [int] NOT NULL,
        [recordID] [int] NOT NULL,
     CONSTRAINT [PK_RecordsToFacets] PRIMARY KEY CLUSTERED 
    (
        [facetID] ASC,
        [recordID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToDateBrowse](
        [datePivotRow] [int] IDENTITY(1,1) NOT NULL,
        [dateID] [int] NOT NULL,
        [recordID] [int] NOT NULL,
     CONSTRAINT [PK_RecordsToDateBrowse] PRIMARY KEY CLUSTERED 
    (
        [datePivotRow] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[RecordsToCollections](
        [RecToCollID] [int] IDENTITY(1,1) NOT NULL,
        [collID] [int] NULL,
        [recordID] [int] NULL,
        [oaiIdentifier] [nvarchar](250) NULL,
        [code] [nvarchar](250) NULL,
     CONSTRAINT [PK_RecordsToCollections] PRIMARY KEY CLUSTERED 
    (
        [RecToCollID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    ALTER TABLE [dbo].[Collections] ADD  CONSTRAINT [DF_Collections_itemCount]  DEFAULT ((0)) FOR [itemCount]
    
    ALTER TABLE [dbo].[Portals] ADD  CONSTRAINT [DF_Portals_lastUpdated]  DEFAULT (getdate()) FOR [lastUpdated]
    
    ALTER TABLE [dbo].[Facets]  WITH CHECK ADD  CONSTRAINT [CK_Facets] CHECK  (([facetType]='Type' OR [facetType]='Date' OR [facetType]='Place'))

    ALTER TABLE [dbo].[Facets] CHECK CONSTRAINT [CK_Facets]
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/18/2011
-- Description:	Populate Facets table with its requisite data, and then create the Foreign
--              Keys, with the exception of the Collections-table-related FKs.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_1b_FacetsFKs]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;
    
    INSERT INTO [dbo].[Facets] (facetValue, parentFacet, facetType) VALUES 
     ('artifact', NULL, 'Type')
    ,('paintings', NULL, 'Type')
    ,('photograph', NULL, 'Type')
    ,('plans', NULL, 'Type')
    ,('postcard', NULL, 'Type')
    ,('stereograph', NULL, 'Type')
    ,('text', NULL, 'Type')
    ,('portrait', NULL, 'Type')
    ,('seascapes', NULL, 'Type')
    ,('abstract paintings', 2, 'Type')
    ,('negative', 3, 'Type')
    ,('photographic print', 3, 'Type')
    ,('slides', 3, 'Type')
    ,('floor plans', 4, 'Type')
    ,('bibliography', 7, 'Type')
    ,('book', 7, 'Type')
    ,('periodical', 7, 'Type')
    ,('film negative', 11, 'Type')
    ,('glass negative', 11, 'Type')
    ,('lantern slide', 13, 'Type')
    ,('Pre-1800', NULL, 'Date')
    ,('1800-1809', NULL, 'Date')
    ,('1810-1819', NULL, 'Date')
    ,('1820-1829', NULL, 'Date')
    ,('1830-1839', NULL, 'Date')
    ,('1840-1849', NULL, 'Date')
    ,('1850-1859', NULL, 'Date')
    ,('1860-1869', NULL, 'Date')
    ,('1870-1879', NULL, 'Date')
    ,('1880-1889', NULL, 'Date')
    ,('1890-1899', NULL, 'Date')
    ,('1900-1909', NULL, 'Date')
    ,('1910-1919', NULL, 'Date')
    ,('1920-1929', NULL, 'Date')
    ,('1930-1939', NULL, 'Date')
    ,('1940-1949', NULL, 'Date')
    ,('1950-1959', NULL, 'Date')
    ,('1960-1969', NULL, 'Date')
    ,('1970-1979', NULL, 'Date')
    ,('1980-1989', NULL, 'Date')
    ,('1990-1999', NULL, 'Date')
    ,('2000-Present', NULL, 'Date')
    ,('Early 19th century', NULL, 'Date')
    ,('Late 19th century', NULL, 'Date')
    ,('19th century', NULL, 'Date')
    ,('Early 20th century', NULL, 'Date')
    ,('Late 20th century', NULL, 'Date')
    ,('20th century', NULL, 'Date')
    ,('Alabama', NULL, 'Place')
    ,('Alaska', NULL, 'Place')
    ,('Arizona', NULL, 'Place')
    ,('Arkansas', NULL, 'Place')
    ,('California', NULL, 'Place')
    ,('Colorado', NULL, 'Place')
    ,('Connecticut', NULL, 'Place')
    ,('Delaware', NULL, 'Place')
    ,('Florida', NULL, 'Place')
    ,('Georgia', NULL, 'Place')
    ,('Hawaii', NULL, 'Place')
    ,('Idaho', NULL, 'Place')
    ,('Illinois', NULL, 'Place')
    ,('Indiana', NULL, 'Place')
    ,('Iowa', NULL, 'Place')
    ,('Kansas', NULL, 'Place')
    ,('Kentucky', NULL, 'Place')
    ,('Louisiana', NULL, 'Place')
    ,('Maine', NULL, 'Place')
    ,('Maryland', NULL, 'Place')
    ,('Massachusett', NULL, 'Place')
    ,('Michigan', NULL, 'Place')
    ,('Minnesota', NULL, 'Place')
    ,('Mississippi', NULL, 'Place')
    ,('Missouri', NULL, 'Place')
    ,('Montana', NULL, 'Place')
    ,('Nebraska', NULL, 'Place')
    ,('Nevada', NULL, 'Place')
    ,('New Hampshire', NULL, 'Place')
    ,('New Jersey', NULL, 'Place')
    ,('New Mexico', NULL, 'Place')
    ,('New York', NULL, 'Place')
    ,('North Carolina', NULL, 'Place')
    ,('North Dakota', NULL, 'Place')
    ,('Ohio', NULL, 'Place')
    ,('Oklahoma', NULL, 'Place')
    ,('Oregon', NULL, 'Place')
    ,('Pennsylvania', NULL, 'Place')
    ,('Rhode Island', NULL, 'Place')
    ,('South Carolina', NULL, 'Place')
    ,('South Dakota', NULL, 'Place')
    ,('Tennessee', NULL, 'Place')
    ,('Texas', NULL, 'Place')
    ,('Utah', NULL, 'Place')
    ,('Vermont', NULL, 'Place')
    ,('Virginia', NULL, 'Place')
    ,('Washington', NULL, 'Place')
    ,('West Virginia', NULL, 'Place')
    ,('Wisconsin', NULL, 'Place')
    ,('Wyoming', NULL, 'Place')


    ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Repositories] FOREIGN KEY([repoID])
    REFERENCES [dbo].[Repositories] ([repoID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Repositories]
    
    ALTER TABLE [dbo].[RecordsToCollections]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToCollections_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToCollections] CHECK CONSTRAINT [FK_RecordsToCollections_Records]
    
    ALTER TABLE [dbo].[RecordsToDateBrowse]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToDateBrowse_DateBrowse] FOREIGN KEY([dateID])
    REFERENCES [dbo].[DateBrowse] ([dateID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToDateBrowse] CHECK CONSTRAINT [FK_RecordsToDateBrowse_DateBrowse]
    
    ALTER TABLE [dbo].[RecordsToDateBrowse]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToDateBrowse_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToDateBrowse] CHECK CONSTRAINT [FK_RecordsToDateBrowse_Records]
    
    ALTER TABLE [dbo].[RecordsToFacets]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToFacet_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToFacets] CHECK CONSTRAINT [FK_RecordsToFacet_Records]
    
    ALTER TABLE [dbo].[RecordsToFacets]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToFacets_Facets] FOREIGN KEY([facetID])
    REFERENCES [dbo].[Facets] ([facetID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToFacets] CHECK CONSTRAINT [FK_RecordsToFacets_Facets]
    
    ALTER TABLE [dbo].[RecordsToMultipleCollections]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToMultipleCollections_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToMultipleCollections] CHECK CONSTRAINT [FK_RecordsToMultipleCollections_Records]
    
    ALTER TABLE [dbo].[RecordsToSubjects]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToSubjects_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToSubjects] CHECK CONSTRAINT [FK_RecordsToSubjects_Records]
    
    ALTER TABLE [dbo].[RecordsToSubjects]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToSubjects_Subjects] FOREIGN KEY([subjectID])
    REFERENCES [dbo].[Subjects] ([subjectID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToSubjects] CHECK CONSTRAINT [FK_RecordsToSubjects_Subjects]
    
    ALTER TABLE [dbo].[RecordsToTitleBrowse]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToTitleBrowse_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToTitleBrowse] CHECK CONSTRAINT [FK_RecordsToTitleBrowse_Records]
    
    ALTER TABLE [dbo].[RecordsToTitleBrowse]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToTitleBrowse_TitleBrowse] FOREIGN KEY([titleID])
    REFERENCES [dbo].[TitleBrowse] ([titleID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToTitleBrowse] CHECK CONSTRAINT [FK_RecordsToTitleBrowse_TitleBrowse]
    
    ALTER TABLE [dbo].[RecordsToTypes]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToTypes_Records] FOREIGN KEY([recordID])
    REFERENCES [dbo].[Records] ([recordID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToTypes] CHECK CONSTRAINT [FK_RecordsToTypes_Records]
    
    ALTER TABLE [dbo].[RecordsToTypes]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToTypes_Types] FOREIGN KEY([typeID])
    REFERENCES [dbo].[Types] ([typeID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToTypes] CHECK CONSTRAINT [FK_RecordsToTypes_Types]
    
    CREATE NONCLUSTERED INDEX [Repositories_portalCode] ON [dbo].[Repositories] 
    (
    	[portalCode] ASC
    )
    INCLUDE ( [repoID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [TitleBrowse_titleText] ON [dbo].[TitleBrowse] 
    (
    	[titleText] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [DateBrowse_dateText] ON [dbo].[DateBrowse] 
    (
    	[dateText] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	Intructions for loading the Data.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_2a_IntructionsforDataLoad]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;
    
    select '* NEXT STEP * - Load the DATA; accomplished by either:'
    select '(a) running IndexReap (for Items), -OR-'
    select '(b) copying another DB, using: Detach, Copy the .mdf & .ldf files, Rename the files, and then (re-)Attach.'
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	Populate the Collections table from Registry's Collections table, and load
--              the Collections-table-related FKs.  (All other FKs were added prior to the
--              general data load.)
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_2b_LoadCollectionsData]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Collections] (collID)
           SELECT c.collectionID 
           FROM   [IH_IMLS].[dbo].[Collections] c
           WHERE  c.ready=1
           ORDER  BY c.collectionID

END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	Populate the Collections table from Registry's Collections table, and load
--              the Collections-table-related FKs.  (All other FKs were added prior to the
--              general data load.)
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_3a_CollectionsFKs]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;

    ALTER TABLE [dbo].[CollectionsToThumbnails]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToThumbnails_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToThumbnails] CHECK CONSTRAINT [FK_CollectionsToThumbnails_Collections]

    ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Collections] FOREIGN KEY([cid])
    REFERENCES [dbo].[Collections] ([collID])
    ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Collections]

    ALTER TABLE [dbo].[RecordsToCollections]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToCollections_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToCollections] CHECK CONSTRAINT [FK_RecordsToCollections_Collections]
        
    ALTER TABLE [dbo].[RecordsToMultipleCollections]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToMultipleCollections_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToMultipleCollections] CHECK CONSTRAINT [FK_RecordsToMultipleCollections_Collections]
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	Create the Full-Text Catalogs and the Indexes.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_3b_FTCsNdxs]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;

    /*
    CREATE FULLTEXT CATALOG [Collections_XMLBlob]WITH ACCENT_SENSITIVITY = ON
    AUTHORIZATION [dbo]
    */
    
    CREATE FULLTEXT CATALOG [Records_XMLSearch]WITH ACCENT_SENSITIVITY = ON
    AUTHORIZATION [dbo]
    
    
    CREATE NONCLUSTERED INDEX [Repositories_portalCode] ON [dbo].[Repositories] 
    (
    	[portalCode] ASC
    )
    INCLUDE ( [repoID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    
    -- Need to use a modified version of the following - following the schema change for Collections table:
    /*
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE PRIMARY XML INDEX [collections_primaryXML] ON [dbo].[Collections] 
    (
    	[XMLBlob]
    )WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE XML INDEX [collections_secondaryXML_Path] ON [dbo].[Collections] 
    (
    	[XMLBlob]
    )
    USING XML INDEX [collections_primaryXML] FOR PATH WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE XML INDEX [collections_secondaryXML_property] ON [dbo].[Collections] 
    (
    	[XMLBlob]
    )
    USING XML INDEX [collections_primaryXML] FOR PROPERTY WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE XML INDEX [collections_secondaryXML_value] ON [dbo].[Collections] 
    (
    	[XMLBlob]
    )
    USING XML INDEX [collections_primaryXML] FOR VALUE WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    CREATE FULLTEXT INDEX ON [dbo].[Collections](
    [XMLBlob] LANGUAGE [English])
    KEY INDEX [PK_Registry]ON ([Collections_XMLBlob], FILEGROUP [PRIMARY])
    WITH (CHANGE_TRACKING = MANUAL, STOPLIST = SYSTEM)
    */
    
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE PRIMARY XML INDEX [creator_primaryXML] ON [dbo].[Records] 
    (
    	[creator]
    )WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    CREATE NONCLUSTERED INDEX [Datestamp] ON [dbo].[Records] 
    (
    	[datestamp] ASC
    )
    INCLUDE ( [identifier]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [Identifier] ON [dbo].[Records] 
    (
    	[identifier] ASC
    )
    INCLUDE ( [recordID],
    [cid]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [Records_cid] ON [dbo].[Records] 
    (
    	[cid] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [Records_portalCode] ON [dbo].[Records] 
    (
    	[portalCode] ASC
    )
    INCLUDE ( [recordID],
    [cid]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE PRIMARY XML INDEX [records_primaryXML] ON [dbo].[Records] 
    (
    	[searchXML]
    )WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    CREATE NONCLUSTERED INDEX [RepoID] ON [dbo].[Records] 
    (
    	[repoID] ASC
    )
    INCLUDE ( [recordID],
    [cid]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE PRIMARY XML INDEX [subject_primaryXML] ON [dbo].[Records] 
    (
    	[subject]
    )WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE PRIMARY XML INDEX [title_primaryXML] ON [dbo].[Records] 
    (
    	[title]
    )WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE XML INDEX [records_secondary_Path] ON [dbo].[Records] 
    (
    	[searchXML]
    )
    USING XML INDEX [records_primaryXML] FOR PATH WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE XML INDEX [records_secondary_PROPERTY] ON [dbo].[Records] 
    (
    	[searchXML]
    )
    USING XML INDEX [records_primaryXML] FOR PROPERTY WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    SET ARITHABORT ON
    SET CONCAT_NULL_YIELDS_NULL ON
    SET QUOTED_IDENTIFIER ON
    SET ANSI_NULLS ON
    SET ANSI_PADDING ON
    SET ANSI_WARNINGS ON
    SET NUMERIC_ROUNDABORT OFF
    CREATE XML INDEX [records_secondary_value] ON [dbo].[Records] 
    (
    	[searchXML]
    )
    USING XML INDEX [records_primaryXML] FOR VALUE WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
    CREATE FULLTEXT INDEX ON [dbo].[Records](
    [creator] LANGUAGE [English], 
    [grandp_XMLBlob] LANGUAGE [English], 
    [parent_XMLBlob] LANGUAGE [English], 
    [searchXML] LANGUAGE [English], 
    [subject] LANGUAGE [English], 
    [title] LANGUAGE [English])
    KEY INDEX [PK_Records]ON ([Records_XMLSearch], FILEGROUP [PRIMARY])
    WITH (CHANGE_TRACKING = MANUAL, STOPLIST = SYSTEM)
    
    CREATE NONCLUSTERED INDEX [recordsToTitleBrowse_recordID] ON [dbo].[RecordsToTitleBrowse] 
    (
    	[recordID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [recordsToTitleBrowse_titleID] ON [dbo].[RecordsToTitleBrowse] 
    (
    	[titleID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [RecordsToMultipleCollections_collID] ON [dbo].[RecordsToMultipleCollections] 
    (
    	[collID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [RecordsToMultipleCollections_recordID] ON [dbo].[RecordsToMultipleCollections] 
    (
    	[recordID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [RecordsToFacets_facetID] ON [dbo].[RecordsToFacets] 
    (
    	[facetID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [RecordsToFacets_recordID] ON [dbo].[RecordsToFacets] 
    (
    	[recordID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [RecordsToCollections_collID] ON [dbo].[RecordsToCollections] 
    (
    	[collID] ASC
    )
    INCLUDE ( [recordID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [RecordsToCollections_recordID] ON [dbo].[RecordsToCollections] 
    (
    	[recordID] ASC
    )
    INCLUDE ( [collID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 18 August 2011
-- Description:	
--	This function returns the given string after
--  "cleaning" it.
--
--	I/O: @txt (REQUIRED) - nvarchar(max)
--
-- =============================================
CREATE FUNCTION [dbo].[CleanText]
(	
	-- Add the parameters for the function here
	@txt nvarchar(max)
)
RETURNS nvarchar(127) WITH SCHEMABINDING
AS
BEGIN	
           IF LEN(@txt) > 120
			  SET @txt = LEFT(@txt, 120) + '...'
			 
		   WHILE LEFT(@txt, 1) = '['
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '&amp;'
		      SET @txt = SUBSTRING(@txt, 6, 127)
		   WHILE LEFT(@txt, 1) = '&lt;'
		      SET @txt = SUBSTRING(@txt, 5, 127)
		   WHILE LEFT(@txt, 1) = '&gt;'
		      SET @txt = SUBSTRING(@txt, 5, 127)
		   WHILE LEFT(@txt, 1) = '&apos;'
		      SET @txt = SUBSTRING(@txt, 7, 127)
		   WHILE LEFT(@txt, 1) = '&quot;'
		      SET @txt = SUBSTRING(@txt, 7, 127)
		   WHILE LEFT(@txt, 1) = ''''
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '"'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '&nbsp;'
		      SET @txt = SUBSTRING(@txt, 7, 127)
		   WHILE LEFT(@txt, 1) = '('
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '{'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = ']'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = ')'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '}'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '.'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = ','
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = ';'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = ':'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '/'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '\'                    --'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '_'
		      SET @txt = SUBSTRING(@txt, 3, 127)
		   WHILE LEFT(@txt, 1) = '-'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '?'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   WHILE LEFT(@txt, 1) = '!'
		      SET @txt = SUBSTRING(@txt, 2, 127)
		   SET @txt = LTRIM(@txt)
		   SET @txt = RTRIM(@txt)

	RETURN (@txt)
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to update the itemCount
--				in Collections Table (only after
--				RecordsToMultipleCollections 
--				table has been populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_updateItemCounts] 

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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:	Winston Jansz
-- Create date: Oct 28, 2011
-- Description:	Update portalCode in the 3 tables.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[onetime_updatePortalCodes] 
AS
BEGIN
	-- Prevent extra result sets from interfering with SELECT statements...
	SET NOCOUNT ON;

    /*
     *  Populate 'portalCode' column in relevant tables
     */           
    -- Records table
    UPDATE r
       SET r.portalCode = c.portalCode
      FROM [dbo].[Records] r
      JOIN [IH_IMLS].[dbo].[Collections] c 
           ON r.cid = c.collectionID
      JOIN [dbo].[RecordsToMultipleCollections] r2c 
           ON r.recordID = r2c.recordID
     where r.portalCode is NULL; -- -- add this condition ONLY if adding NEW item records!
    
    -- Also take care of NULLS
    UPDATE [dbo].[Records]
       SET portalCode = 1
     WHERE portalCode is null;
    
    -- Repositories table
    UPDATE t
       SET t.portalCode = c.portalCode
      FROM [dbo].[Repositories] t
      JOIN [dbo].[Records] r
           ON r.repoID = t.repoID
      JOIN [IH_IMLS].[dbo].[Collections] c
           ON r.cid = c.collectionID
     where t.portalCode is NULL; -- -- add this condition ONLY if adding NEW repositories!
    
    -- Also take care of NULLS
    UPDATE [dbo].[Repositories]
       SET portalCode = 1
     WHERE portalCode is null;

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to insert into TitleBrowse
--              and RecordsToTitleBrowse Tables (only
--              after Records table has been populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_populateTitleBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- This SP assumes all records have one and only one non-null titleText value

	DECLARE @recID int;
	DECLARE @titleID int;
	DECLARE @titleText nvarchar(max);
	DECLARE @titleTextClean nvarchar(max);
	DECLARE myRow CURSOR LOCAL FOR
		(select titleText, recordID from Records);
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @titleText, @recID;
	WHILE @@FETCH_STATUS = 0
		BEGIN			   
		    SET @titleTextClean = [dbo].CleanText(@titleText)
		   
			IF EXISTS(select 1 from [dbo].[TitleBrowse] tb where tb.titleText = @titleTextClean)
				set @titleID = (select titleID from [dbo].[TitleBrowse] tb where tb.titleText = @titleTextClean);
			ELSE
			  BEGIN	 
				insert into [dbo].[TitleBrowse] (titleText) VALUES (@titleTextClean);
				set @titleID = (select @@IDENTITY);
			  END
			  
			insert into [dbo].[RecordsToTitleBrowse] (recordID, titleID) VALUES (@recID, @titleID);
			
			FETCH NEXT FROM myRow INTO @titleText, @recID;
		END
		
	CLOSE myRow;
	DEALLOCATE myRow;

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to insert into DateBrowse
--              and RecordsToDateBrowse Tables (only
--              after Records table has been populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_populateDateBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- This SP assumes that no dateText rows reduce to empty string after parsing

	DECLARE @recID int;
	DECLARE @dateID int;
	DECLARE @dateText nvarchar(max);
	DECLARE @dateTextClean nvarchar(max);
	DECLARE myRow CURSOR LOCAL FOR
		( select distinct (t2.Loc.query('.')).value('.', 'nvarchar(255)') as dateText, recordID from
			(select longXML.query('/record/property[@name="date"]') as myXML, recordID from Records
				where longXML.exist('/record/property[@name="date"]') = 1) q1
			CROSS APPLY q1.myXML.nodes('/property/value') as t2(Loc) );
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @dateText, @recID;
	WHILE @@FETCH_STATUS = 0
		BEGIN			   
		    SET @dateTextClean = [dbo].CleanText(@dateText)
		   
			IF EXISTS(select 1 from [dbo].[DateBrowse] tb where tb.dateText = @dateTextClean)
				set @dateID = (select dateID from [dbo].[DateBrowse] tb where tb.dateText = @dateTextClean);
			ELSE
			  BEGIN	 
				insert into [dbo].[DateBrowse] (dateText) VALUES (@dateTextClean);
				set @dateID = (select @@IDENTITY);
			  END
			  
			insert into [dbo].[RecordsToDateBrowse] (recordID, dateID) VALUES (@recID, @dateID);
			
			FETCH NEXT FROM myRow INTO @dateText, @recID;
		END
		
	CLOSE myRow;
	DEALLOCATE myRow;

END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: Oct 28, 2011
-- Description:	Populate the Portals table, and the portalCode column in the other tables.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_4a_Portals] 
AS
BEGIN
	-- Prevent extra result sets from interfering with SELECT statements...
	SET NOCOUNT ON;

    
    /*
     *  Populate the Portals table
     */           
    INSERT   [dbo].[Portals]   (portalCode,portalName,portalURL)
    VALUES   ( 1, 'All',             'http://imlsdccweb.grainger.illinois.edu')
            ,( 2, 'Opening History', 'http://openinghistory.grainger.illinois.edu')
            ,( 4, 'IMLS',            'http://imls.grainger.illinois.edu')
            ,( 8, 'Aquifer',         'http://aquifer.grainger.illinois.edu')
            ,(16, 'DPLA',            'http://dpla.grainger.illinois.edu');


    /*
     *  Populate 'portalCode' column in relevant tables
     */           
    -- Records table
    UPDATE r
       SET r.portalCode = c.portalCode
      FROM [dbo].[Records] r
      JOIN [IH_IMLS].[dbo].[Collections] c 
           ON r.cid = c.collectionID
      JOIN [dbo].[RecordsToMultipleCollections] r2c 
           ON r.recordID = r2c.recordID;
    
    -- Also take care of NULLS
    UPDATE [dbo].[Records]
       SET portalCode = 1
     WHERE portalCode is null;
    
    -- Repositories table
    UPDATE t
       SET t.portalCode = c.portalCode
      FROM [dbo].[Repositories] t
      JOIN [dbo].[Records] r
           ON r.repoID = t.repoID
      JOIN [IH_IMLS].[dbo].[Collections] c
           ON r.cid = c.collectionID;
    
    -- Also take care of NULLS
    UPDATE [dbo].[Repositories]
       SET portalCode = 1
     WHERE portalCode is null;
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function splits a comma separated string (no spaces please) and returns as FacetIDType compatible table
-- =============================================
CREATE FUNCTION [dbo].[mySplit]
(	
	-- Add the parameters for the function here
	@String nvarchar(255)
)
RETURNS 
	@splitLst TABLE 
(
	-- Add the column definitions for the TABLE variable here
	facetID int
)
AS
BEGIN
	DECLARE @NextString INT
	DECLARE @Pos INT
	DECLARE @NextPos INT
	DECLARE @Delimiter NVARCHAR(3)

	SET @Delimiter = ','
	SET @String = @String + @Delimiter
	SET @Pos = charindex(@Delimiter,@String)

	WHILE (@pos <> 0)
		BEGIN
			SET @NextString = CAST(substring(@String,1,@Pos - 1) as INT)
			insert into @splitLst (facetID) (select @NextString)
			SET @String = substring(@String,@pos+1,len(@String))
			SET @pos = charindex(@Delimiter,@String)
		END 
		
	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		keyword
--		creator
--		subject
--		title
--		note:  * and (searchXML, parent_XMLBlob, grandp_XMLBlob) are not supported for queryType, use keyword instead
--	@portalCode will be bitwise AND'd with portalCode in Records table to filter by portal affiliation
--  @collectionID if not zero will be compared to collID in Records table to filter by collection
-- =============================================
CREATE FUNCTION [dbo].[cTQWithPCOnly]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode tinyint = 1
)
RETURNS 
	@containsTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int,
	ctRank int
)
AS
BEGIN

  IF (@collectionID = 0)
	BEGIN
		IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode)
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode)
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode)
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				where (r.portalCode & @portalCode) = @portalCode) 
				order by ctRank DESC
	END
  ELSE
	BEGIN
			IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode and r.cid = @collectionID)
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode and r.cid = @collectionID)
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode and r.cid = @collectionID)
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				where (r.portalCode & @portalCode) = @portalCode and r.cid = @collectionID) 
				order by ctRank DESC

	END
	
	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		*
--		creator
--		subject
--		title
--		note: (searchXML, parent_XMLBlob, grandp_XMLBlob) is not supported, use * instead
--	@collectionID is int that if non-zero is used to limit search to within a single collection 
--	@portalID is int that if present is binary anded with records.portalCode to create an additional search limit
--	Returns itemCount an int (max 2 mil) giving count of items that match query conditions.
-- =============================================
CREATE FUNCTION [dbo].[ItemCount]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(256),
	@queryType nvarchar(256) = '*' 
)
RETURNS int 
AS
BEGIN	
	Declare @itemCount int

	IF @queryType = 'title'
	   BEGIN
		set @itemCount = (select count(r.recordID)  
		from [dbo].[Records] r
		where contains ([title], @phrase))
	   END
	ELSE 
		BEGIN
		IF @queryType = 'creator'
		   BEGIN
			set @itemCount = (select count(r.recordID)  
			from [dbo].[Records] r
			where contains ([creator], @phrase))
		   END
		ELSE
			BEGIN
			IF @queryType = 'subject'
			   BEGIN
				set @itemCount = (select count(r.recordID) 
				from [dbo].[Records] r
				where contains ([subject], @phrase))
			   END
			ELSE
			   BEGIN
				set @itemCount = (select count(r.recordID) 
				from [dbo].[Records] r
				where contains (*, @phrase))
			   END
			END
		END
	RETURN (@itemCount)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		keyword
--		creator
--		subject
--		title
--		note:  * and (searchXML, parent_XMLBlob, grandp_XMLBlob) are not supported for queryType, use keyword instead
-- =============================================
CREATE FUNCTION [dbo].[containsTableQuery]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000
)
RETURNS 
	@containsTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int,
	ctRank int
)
AS
BEGIN
	IF ( @queryType = 'title')   
		INSERT INTO @containsTableQuery(RecordID, ctRank) (
			SELECT ct.[key] as RecordID, ct.[rank] as ctRank
			FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct) 
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @containsTableQuery(RecordID, ctRank) (
			SELECT ct.[key] as RecordID, ct.[rank] as ctRank
			FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct) 

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @containsTableQuery(RecordID, ctRank) (
			SELECT ct.[key] as RecordID, ct.[rank] as ctRank
			FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct) 

	ELSE  
		INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select ISNULL(ct.[key], ct2.[key]) as recordID, 
			  (ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
			  from containsTable([dbo].[records], *, @phrase, @top_n) ct
			  full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key])
			  order by ctRank desc

	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 18 August 2011
-- Description:	
--	This function returns count of records ID matching a date, subject, title, or type ID (i.e., selected by user from browse list)
--	@browseID (REQUIRED) 
--  @queryType is column_name | (column_list) | *, following supported:
--		date
--		subject
--		type
--		title (default)
-- =============================================
CREATE FUNCTION [dbo].[FacetItemCount]
(	
	-- Add the parameters for the function here
	@facetIn nvarchar(256) = '*' 
)
RETURNS int 
AS
BEGIN	
	Declare @itemCount int

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));
  
		set @itemCount = (select count(distinct bt.recordID)  
		from [dbo].[RecordsToFacets] bt
		where bt.facetID in(select * from @facet))


	RETURN (@itemCount)
END
GO

/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 18 August 2011
-- Description:	
--	This function returns table of records ID matching set of facets (i.e., for pre-canned searches)
--	@facets (REQUIRED) -- implies query type of browse
--
-- =============================================
CREATE FUNCTION [dbo].[bTQWith1Facet]
(	
	-- Add the parameters for the function here
	@facetIn nvarchar(255),
	@collectionID int = 0,
	@portalCode tinyint = 1 

)
RETURNS 
	@browseTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int
)
AS
BEGIN

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  IF (@collectionID = 0)
			INSERT INTO @browseTableQuery(RecordID) 
			select distinct bt.recordID from [dbo].[RecordsToFacets] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.facetID in (select * from @facet)
			  and (r.portalCode & @portalCode) = @portalCode
			  order by bt.recordID
	
  ELSE
			INSERT INTO @browseTableQuery(RecordID) 
			select distinct bt.recordID from [dbo].[RecordsToFacets] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.facetID in (select * from @facet)
			  and (r.portalCode & @portalCode) = @portalCode
			  and r.cid = @collectionID
			  order by bt.recordID	

  RETURN 
END
GO
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[RankByPhrase2]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(256),
	@queryType nvarchar(256),
	@phraseType nvarchar(256),
	@matchType nvarchar(256),
	@browseID int
)
RETURNS @retRankByPhrase TABLE 
(
	RecordID int,
	CollID int,
	SearchRank int
)
AS
BEGIN	
	IF (@phraseType = 'keyword' AND @queryType = 'title')   
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [title], @phrase)) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)
	ELSE IF (@phraseType = 'keyword' AND @queryType = 'creator')
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [creator], @phrase)) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)
	ELSE IF (@phraseType = 'keyword' AND @queryType = 'subject')  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [subject], @phrase)) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)
	ELSE IF (@phraseType = 'keyword' AND @queryType = 'keyword')  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [searchXML], @phrase)) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID )
	ELSE IF @phraseType = 'browse' AND @queryType = 'title' AND @matchType <> 'collection' AND @phrase = '[^a-z]%'  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT r.recordID [KEY], ROW_NUMBER() 
						OVER (ORDER BY r.titleText) AS [RANK]
					FROM dbo.Records r
					WHERE r.titleText LIKE '[^a-z]' + @phrase) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)	
	ELSE IF @phraseType = 'browse' AND @queryType = 'title' AND @matchType <> 'collection'  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
		SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT r.recordID [KEY], ROW_NUMBER() 
						OVER (ORDER BY r.titleText) AS [RANK]
					FROM dbo.Records r
					WHERE r.titleText LIKE @phrase or r.titleText LIKE '[^a-z0-9]' + @phrase) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)
	ELSE IF @phraseType = 'browse' AND @queryType = 'title' AND @matchType = 'collection'  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT DISTINCT NULL RecordID, c.collID CollID, ROW_NUMBER()
				OVER (ORDER BY c.title) SearchRank
			FROM dbo.Collections c
			WHERE c.title LIKE @phrase + '%')
	ELSE IF @phraseType = 'browse' AND @queryType = 'subject'  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM dbo.Records r INNER JOIN dbo.RecordsToSubjects rs ON r.recordID = rs.recordID
			WHERE rs.subjectID = @browseID) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)
	ELSE IF @phraseType = 'browse' AND @queryType = 'type'  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM dbo.Records r INNER JOIN dbo.RecordsToTypes rt ON r.recordID = rt.recordID
			WHERE rt.typeID = @browseID) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)
	ELSE IF @phraseType = 'browse' AND @queryType = 'date'  
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN (SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM dbo.Records r INNER JOIN dbo.RecordsToFacets rf ON r.recordID = rf.recordID
			WHERE rf.facetID = @browseID) rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID)

	RETURN

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 1/22/2010
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[RankByPhrase]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(256),
	@queryType nvarchar(256),
	@phraseType nvarchar(256),
	@matchType nvarchar(256),
	@browseID int,
	@portalCode tinyint
)
RETURNS @retRankByPhrase TABLE 
(
	RecordID int,
	CollID int,
	SearchRank int
)
AS
BEGIN
	DECLARE @phraseLength AS INT = (SELECT LEN(@phrase));	
	DECLARE @rankTable table ([KEY] int, [RANK] int);
	--DECLARE @maxCnt int;
	--SET @maxCnt=601;


    /*
     * NOTE (wnj): Change this into an IF-ELSE?
     */
	IF @phraseType = 'keyword' AND @queryType = 'title' GOTO keyword_title
	IF @phraseType = 'keyword' AND @queryType = 'creator' GOTO keyword_creator
	IF @phraseType = 'keyword' AND @queryType = 'subject' GOTO keyword_subject
	IF @phraseType = 'keyword' AND @queryType = 'keyword' GOTO keyword_keyword
	IF @phraseType = 'browse' AND @queryType = 'title' AND @matchType <> 'collection' GOTO browse_title
	IF @phraseType = 'browse' AND @queryType = 'title' AND @matchType = 'collection' GOTO return_browse_title_collection_insert
	IF @phraseType = 'browse' AND @queryType = 'subject' GOTO browse_subject
	IF @phraseType = 'browse' AND @queryType = 'type' GOTO browse_type
	IF @phraseType = 'browse' AND @queryType = 'date' GOTO browse_date

	keyword_title:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			--SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [title], @phrase, @maxCnt)
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [title], @phrase)
		)
		GOTO return_insert;

	keyword_creator:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			--SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [creator], @phrase, @maxCnt)
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [creator], @phrase)
		)
		GOTO return_insert;

	keyword_subject:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			--SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [subject], @phrase, @maxCnt)
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [subject], @phrase)
		)
		GOTO return_insert;

	keyword_keyword:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			--SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [searchXML], @phrase, @maxCnt)
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, ([searchXML],[parent_XMLBlob]), @phrase)
		)
		GOTO return_insert;

	browse_title:
		IF @phrase = '[^a-z]%'
			BEGIN
				INSERT INTO @rankTable ([KEY], [RANK]) (
					SELECT r.recordID [KEY], ROW_NUMBER() 
						OVER (ORDER BY r.titleText) AS [RANK]
					FROM dbo.Records r
					WHERE r.titleText LIKE '[^a-z]' + @phrase
				)
			END
		ELSE
			BEGIN
				INSERT INTO @rankTable ([KEY], [RANK]) (
					SELECT r.recordID [KEY], ROW_NUMBER() 
						OVER (ORDER BY r.titleText) AS [RANK]
					FROM dbo.Records r
					WHERE r.titleText LIKE @phrase or r.titleText LIKE '[^a-z0-9]' + @phrase
				)
			END
		GOTO return_insert;

	browse_subject:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM dbo.Records r INNER JOIN dbo.RecordsToSubjects rs ON r.recordID = rs.recordID
			WHERE rs.subjectID = @browseID
		)
		GOTO return_insert;

	browse_type:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM dbo.Records r INNER JOIN dbo.RecordsToTypes rt ON r.recordID = rt.recordID
			WHERE rt.typeID = @browseID
		)
		GOTO return_insert;

	browse_date:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM dbo.Records r INNER JOIN dbo.RecordsToFacets rf ON r.recordID = rf.recordID
			WHERE rf.facetID = @browseID
		)
		GOTO return_insert;

	return_insert:
		INSERT INTO @retRankByPhrase (RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
            /*
			FROM dbo.Records r INNER JOIN @rankTable rt ON r.recordID = rt.[KEY]
            */
			FROM @rankTable rt 
            INNER JOIN dbo.Records r ON r.recordID = rt.[KEY] AND (r.portalCode & @portalCode = @portalCode)
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID
		);
		GOTO return_statement;
		
	return_browse_title_collection_insert:
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT DISTINCT NULL RecordID, c.collID CollID, ROW_NUMBER()
				OVER (ORDER BY c.title) SearchRank
			FROM dbo.Collections c
			WHERE c.title LIKE @phrase + '%'
		);
		GOTO return_statement;

	return_statement:
		RETURN;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		keyword
--		creator
--		subject
--		title
--		note:  * and (searchXML, parent_XMLBlob, grandp_XMLBlob) are not supported for queryType, use keyword instead
--	@portalCode will be bitwise AND'd with portalCode in Records table to filter by portal affiliation
--  @collectionID if not zero will be compared to collID in Records table to filter by collection
--  @facetIn [facetIn2, facetIn3] is string, comma separated list of facetIDs for use in filtering search results
-- =============================================
CREATE FUNCTION [dbo].[cTQWith3Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode tinyint = 1,
	@facetIn nvarchar(255),
	@facetIn2 nvarchar(255),
	@facetIn3 nvarchar(255) 
)
RETURNS 
	@containsTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int,
	ctRank int
)
AS
BEGIN

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  declare @facet2 facetIDType;
  insert into @facet2 (facetID) (select * from [dbo].[mySplit](@facetIn2));

  declare @facet3 facetIDType;
  insert into @facet3 (facetID) (select * from [dbo].[mySplit](@facetIn3));


  IF (@collectionID = 0)
	BEGIN
		IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC
	END
  ELSE
	BEGIN
			IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2))				
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet3)))				
				order by ctRank DESC

	END
	
	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		keyword
--		creator
--		subject
--		title
--		note:  * and (searchXML, parent_XMLBlob, grandp_XMLBlob) are not supported for queryType, use keyword instead
--	@portalCode will be bitwise AND'd with portalCode in Records table to filter by portal affiliation
--  @collectionID if not zero will be compared to collID in Records table to filter by collection
--  @facetIn [facetIn2, facetIn3] is string, comma separated list of facetIDs for use in filtering search results
-- =============================================
CREATE FUNCTION [dbo].[cTQWith2Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode tinyint = 1,
	@facetIn nvarchar(255),
	@facetIn2 nvarchar(255) 
)
RETURNS 
	@containsTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int,
	ctRank int
)
AS
BEGIN

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  declare @facet2 facetIDType;
  insert into @facet2 (facetID) (select * from [dbo].[mySplit](@facetIn2));

  IF (@collectionID = 0)
	BEGIN
		IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC
	END
  ELSE
	BEGIN
			IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet))
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet2)))				
				order by ctRank DESC

	END
	
	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		keyword
--		creator
--		subject
--		title
--		note:  * and (searchXML, parent_XMLBlob, grandp_XMLBlob) are not supported for queryType, use keyword instead
--	@portalCode will be bitwise AND'd with portalCode in Records table to filter by portal affiliation
--  @collectionID if not zero will be compared to collID in Records table to filter by collection
--  @facetIn [facetIn2, facetIn3] is string, comma separated list of facetIDs for use in filtering search results
-- =============================================
CREATE FUNCTION [dbo].[cTQWith1Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode tinyint = 1,
	@facetIn nvarchar(255)
)
RETURNS 
	@containsTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int,
	ctRank int
)
AS
BEGIN

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  IF (@collectionID = 0)
	BEGIN
		IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC
	END
  ELSE
	BEGIN
			IF ( @queryType = 'title')   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC 
				
		ELSE IF ( @queryType = 'creator')
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC 

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
				SELECT ct.[key] as RecordID, ct.[rank] as ctRank
				FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
				join [dbo].[Records] r on ct.[key] = r.recordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC 

		ELSE   
			INSERT INTO @containsTableQuery(RecordID, ctRank) (
			select q1.recordID, q1.ctRank from(
				select ISNULL(ct.[key], ct2.[key]) as recordID, 
				(ISNULL(ct.[rank], 0) + ISNULL(2*ct2.[rank], 0)) as ctRank
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
				join [dbo].[Records] r on r.recordID = q1.RecordID
				join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
				where (r.portalCode & @portalCode) = @portalCode
				 and exists ((select rtf.facetid from [dbo].[RecordsToFacets] rtf where rtf.recordID = r.recordID) intersect (select * from @facet)))				
				order by ctRank DESC

	END
	
	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns total number of item-level records matching query
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		*
--		creator
--		subject
--		title
--		note: (searchXML, parent_XMLBlob, grandp_XMLBlob) is not supported, use * instead
--	@collectionID is int that if non-zero is used to limit search to within a single collection 
--	@portalID is int that if present is binary anded with records.portalCode to create an additional search limit
--	Returns itemCount an int (max 2 mil) giving count of items that match query conditions.
-- =============================================
CREATE FUNCTION [dbo].[CollectionCount]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(256),
	@queryType nvarchar(256) = '*' 
)
RETURNS int 
AS
BEGIN	
	Declare @collectionCount int

	IF @queryType = 'title'
	   BEGIN
		set @CollectionCount = (select count(q1.myCollID) from 
		(select distinct(rc.collID) as myCollID 
			from [dbo].[Records] r
			join [dbo].[recordstomultiplecollections] rc on r.recordid = rc.recordid
			where contains (r.[title], @phrase)
		union
		select c2.collid as myCollid
			from [dbo].[Collections] c2
			where contains(c2.*, @phrase)
		) q1)
	   END
	ELSE 
		BEGIN
		IF @queryType = 'creator'
		   BEGIN
			set @CollectionCount = (select count(q1.myCollID) from 
			(select distinct(rc.collID) as myCollID 
				from [dbo].[Records] r
				join [dbo].[recordstomultiplecollections] rc on r.recordid = rc.recordid
				where contains (r.[creator], @phrase)
			union
			select c2.collid as myCollid
				from [dbo].[Collections] c2
				where contains(c2.*, @phrase)
			) q1)
		   END
		ELSE
			BEGIN
			IF @queryType = 'subject'
			   BEGIN
				set @CollectionCount = (select count(q1.myCollID) from 
				(select distinct(rc.collID) as myCollID 
					from [dbo].[Records] r
					join [dbo].[recordstomultiplecollections] rc on r.recordid = rc.recordid
					where contains (r.[subject], @phrase)
				union
				select c2.collid as myCollid
					from [dbo].[Collections] c2
					where contains(c2.*, @phrase)
				) q1)
			   END
			ELSE
			   BEGIN
				set @CollectionCount = (select count(q1.myCollID) from 
				(select distinct(rc.collID) as myCollID 
					from [dbo].[Records] r
					join [dbo].[recordstomultiplecollections] rc on r.recordid = rc.recordid
					where contains (r.*, @phrase)
				union
				select c2.collid as myCollid
					from [dbo].[Collections] c2
					where contains(c2.*, @phrase)
				) q1)
			   END
			END
		END
	RETURN (@CollectionCount)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 6 August 2011
-- Description:	
--	This function returns collection records matching query
--   = collections having items that match plus collections that match on collection description
--	@phrase (REQUIRED) is query (string) exactly as will be used in CONTAINS query
--  @queryType is column_name | (column_list) | * that will be used in CONTAINS query, following supported:
--		keyword
--		creator
--		subject
--		title
--		note:  * and (searchXML, parent_XMLBlob, grandp_XMLBlob) are not supported for queryType, use keyword instead
-- =============================================
CREATE FUNCTION [dbo].[collCTQ]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = 'keyword', 
	@top_n int = 10000
)
RETURNS 
	@collCTQ TABLE 
(
	-- Add the column definitions for the TABLE variable here
	collID int,
	hitsInColl int,
	ctRank int
)
AS
BEGIN
	IF ( @queryType = 'title')   
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					group by rc.collID, c1.itemCount
				union				
				select ct2.[key] as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
			) q1
			group by q1.collectionID)
			order by myRankS DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					group by rc.collID, c1.itemCount
				union				
				select ct2.[key] as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
			) q1
			group by q1.collectionID)
			order by myRankS DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					group by rc.collID, c1.itemCount
				union				
				select ct2.[key] as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
			) q1
			group by q1.collectionID)
			order by myRankS DESC

	ELSE  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			  (SELECT rc.collid as collectionID, count(q0.recordID) as hitsInColl, cast(( count(q0.recordID)*(1000/c1.itemCount) ) as int) as myRank
				FROM 
				(select ISNULL(ct.[key], ct2.[key]) as recordID 
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					group by rc.collID, c1.itemCount
				union				
				select ct2.[key] as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
			) q1
			group by q1.collectionID)
			order by myRankS DESC

	RETURN 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/1/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetTypeSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @phrase = '[^a-z]%'
	BEGIN
		SELECT t.typeID, t.typeText 
		FROM [Types] t
		WHERE t.typeText LIKE '[^a-z]' + @phrase
		ORDER BY t.typeText
	END
	ELSE
	BEGIN
		SELECT t.typeID, t.typeText FROM [Types] t
		WHERE t.typeText LIKE @phrase or t.typeText LIKE '[^a-z0-9]' + @phrase
		ORDER BY t.typeText
	END
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/3/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetTypeByID] 
	-- Add the parameters for the stored procedure here
	@typeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t.typeText FROM [Types] t WHERE t.TypeID = @typeID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/1/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetSubjectSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @phrase = '[^a-z]%'
	BEGIN
		SELECT s.subjectID, s.subjectText 
		FROM Subjects s
		WHERE s.subjectText LIKE '[^a-z]' + @phrase
		ORDER BY s.subjectText
	END
	ELSE
	BEGIN
		SELECT s.subjectID, s.subjectText FROM Subjects s
		WHERE s.subjectText LIKE @phrase or s.subjectText LIKE '[^a-z0-9]' + @phrase
		ORDER BY s.subjectText
	END
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/3/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetDateByID] 
	-- Add the parameters for the stored procedure here
	@dateID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT facetValue dateText FROM Facets WHERE facetID = @dateID;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/1/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetCollSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @phrase = '[^a-z]%'
	BEGIN
		SELECT c.collID, c.title collText
		FROM Collections c
		WHERE c.title LIKE '[^a-z]' + @phrase
		ORDER BY c.title
	END
	ELSE
	BEGIN
		SELECT c.collID, c.title collText FROM Collections c
		WHERE c.title LIKE @phrase or c.title LIKE '[^a-z0-9]' + @phrase
		ORDER BY c.title
	END
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetRandomCollection] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 c.collID FROM Collections c
	ORDER BY NEWID();
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/3/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetSubjectByID] 
	-- Add the parameters for the stored procedure here
	@subjectID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT s.subjectText FROM Subjects s WHERE s.SubjectID = @subjectID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/23/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[CollectionDetails] 
	-- Add the parameters for the stored procedure here
	@identifier integer = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.XMLBlob_Display, ct.oaiidentifier1, ct.oaiidentifier2, ct.oaiidentifier3, 
		ct.oaiidentifier4, ISNULL(q.recordCount,0) recordCount, c.collID collectionID 
	FROM Collections c 
	LEFT JOIN CollectionsToThumbnails ct ON c.collID = ct.collID
	LEFT JOIN (
		SELECT rc.cid, Count(rc.cid) recordCount 
		FROM Records rc 
		GROUP BY rc.cid
	) q ON c.collID = q.cid
	WHERE c.collID = @identifier;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/23/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ItemDetails] 
	-- Add the parameters for the stored procedure here
	@identifier nvarchar(250) = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT r.longXML, c.collID collectionID, c.title collectionTitle, 
	c.[description] collectionDescription, c.isAvailableAt_URL collectionURL,
	q.recordCount, r.longXML.query('data(record/property[@name="identifier"]/value/a)') itemHome
	FROM Records r INNER JOIN Collections c ON r.cid = c.collID 
	LEFT JOIN (
		SELECT rc.cid, Count(rc.cid) recordCount 
		FROM Records rc 
		GROUP BY rc.cid) q
	ON r.cid = q.cid
	WHERE r.identifier = @identifier;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 4/20/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetStats] 
    @portalCode nvarchar(5) = "0"
AS
BEGIN
    DECLARE
     @items        int    = NULL
    ,@colls        int    = NULL
    ,@repos        int    = NULL
    ,@p            tinyint    = CAST(@portalCode AS tinyint)

    -- ItemCount
    SELECT @items = COUNT(1) from dbo.Records
     WHERE (portalCode & @p > 0);
    
    -- CollectionCount
    SELECT @colls = COUNT(1) from IH_IMLS.dbo.Collections
     WHERE (portalCode & @p > 0);
    
    -- InstitutionCount
    --SELECT @repos = COUNT(1) from dbo.Repositories
    /*
    select @repos = COUNT( distinct cin.CollInstNameID) 
    from dbo.CollInstNameBrowse cin
    join dbo.CollectionsToCollInstName c2cin on cin.CollInstNameID = c2cin.CollInstNameID
    join IH_IMLS.dbo.Collections c on c.collectionID = c2cin.collid
     WHERE (c.portalCode & @p > 0);
    */
    
	-- Prevent extra result sets from interfering with SELECT statements
	SET NOCOUNT ON;

	SELECT @items AS ItemCount, @colls AS CollectionCount --, @repos AS InstitutionCount;

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/25/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetItemSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL, 
	@queryType nvarchar(255) = 'keyword', 
	@phraseType nvarchar(255) = 'keyword',
	@collectionID int = NULL,
	@browseID int = NULL,
	@facets FacetIDType READONLY,
	@portalCode tinyint = 0
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
	SET NOCOUNT ON;
	
	-- Use this variable to see if @facets were passed in
	DECLARE @facetCount INT;
	SELECT @facetCount = COUNT(*) FROM @facets;

    -- Insert statements for procedure here
	IF @phrase IS NOT NULL
	BEGIN
		DECLARE @FacetedRecordCollRankTable table(SearchRank int, RecordID int, collID int); 
		IF @facetCount <> 0
		BEGIN
			INSERT INTO @FacetedRecordCollRankTable (SearchRank, RecordID, collID) (
				-- get records that have ALL the matching facets
				SELECT q1.searchRank, q1.recordID, q1.CollID  FROM (
					-- Get all the facets that match a filtering facet 
					-- for those records that match the keyword.
					SELECT rf.facetID, q.recordID, q.CollID, q.searchRank
					FROM (	
						-- get all records that match the keyword
						SELECT rbp.CollID, rbp.RecordID, Min(rbp.SearchRank) searchRank
						FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'item', @browseID, @portalCode) rbp
						GROUP BY rbp.RecordID, rbp.CollID
					) q 
					INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = q.RecordID
					INNER JOIN @facets tf ON rf.facetID = tf.FacetID
				) q1
				GROUP BY q1.recordID, q1.searchRank, q1.CollID
				HAVING Count(q1.facetID) = @facetCount
			)
		END
		ELSE
		BEGIN
			INSERT INTO @FacetedRecordCollRankTable (SearchRank, RecordID, collID) (
				-- get all records that match the keyword
				SELECT MIN(rbp.SearchRank) searchRank, rbp.RecordID, rbp.CollID
				FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'item', @browseID, @portalCode) rbp
				GROUP BY rbp.RecordID, rbp.CollID
			)
		END

		SELECT q2.searchRank, q2.RecordID, q2.CollID, --c.title collectionTitle, wnj: non-existent column in new schema
		--c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, wnj: non-existent columns in new schema
		r.identifier, r.shortXML
		FROM dbo.Records r INNER JOIN @FacetedRecordCollRankTable q2 
			ON r.recordID = q2.RecordID AND r.cid = q2.CollID
		INNER JOIN dbo.Collections c ON q2.CollID = c.collID
		ORDER BY q2.SearchRank, q2.RecordID
	END
	ELSE
	BEGIN
		IF @collectionID IS NOT NULL
		BEGIN
			-- Save the records filtered by collection and facets so we don't have to do
			-- a complex query multiple times.
			DECLARE @FacetedRecordTable table(RecordID int); 
			IF @facetCount <> 0
			BEGIN
				-- Do this when a list of facets was passed in.
				INSERT INTO @FacetedRecordTable (RecordID) (
					SELECT q.recordID FROM (
						-- Get all the facets that match a filtering facet 
						-- for those records that are in the collection.
						SELECT DISTINCT rf.facetID, rmc.recordID, rmc.collID
						FROM dbo.RecordsToMultipleCollections rmc
						INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = rmc.recordID
						INNER JOIN @facets tf ON rf.facetID = tf.facetID 
						WHERE rmc.collID = @collectionID
					) q
					GROUP BY q.recordID
					HAVING Count(q.facetID) = @facetCount
				)
			END
			ELSE
			BEGIN
				-- Do a simpler query when there were no facets passed in to filter on.
				INSERT INTO @FacetedRecordTable (RecordID) (
					SELECT DISTINCT rmc.recordID
					FROM dbo.RecordsToMultipleCollections rmc
					WHERE rmc.collID = @collectionID
				)
			END
			
			SELECT 1 searchRank, r.recordid RecordID, rmc.collid CollID, --c.title collectionTitle, wnj: non-existent column in new schema
			--c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, wnj: non-existent columns in new schema
			r.identifier, r.shortXML
			FROM dbo.Records r INNER JOIN dbo.RecordsToMultipleCollections rmc ON r.recordID = rmc.recordID
			INNER JOIN dbo.Collections c ON rmc.collid = c.collID
			INNER JOIN @FacetedRecordTable q1 ON q1.recordID = r.recordID
			WHERE c.collID = @collectionID
		END
		ELSE
		BEGIN
			IF @browseID IS NOT NULL
			BEGIN
				SELECT rbp.searchRank, rbp.RecordID, rbp.CollID, --c.title collectionTitle, wnj: non-existent column in new schema
				--c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, wnj: non-existent columns in new schema
				r.identifier, r.shortXML
				FROM dbo.Records r INNER JOIN dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'item', @browseID, @portalCode) rbp
					ON r.recordID = rbp.RecordID AND r.cid = rbp.CollID		
				INNER JOIN dbo.Collections c ON rbp.CollID = c.collID
				ORDER BY rbp.SearchRank, rbp.RecordID
			END
		END
	END
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/30/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetFacetCounts] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL, 
	@queryType nvarchar(255) = 'keyword', 
	@phraseType nvarchar(255) = 'keyword',
	@collectionID int = NULL, 
	@facets FacetIDType READONLY,
	@portalCode tinyint = 0
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
	SET NOCOUNT ON;

	-- Use this variable to see if @facets were passed in
	DECLARE @facetCount INT;
	SELECT @facetCount = COUNT(*) FROM @facets;

	IF @phrase IS NOT NULL
	BEGIN
		-- Save the records filtered by keyword and facets so we don't have to do
		-- a complex query multiple times.
		DECLARE @FacetedRecordCollTable table(RecordID int, collID int); 
		IF @facetCount <> 0
		BEGIN
			-- Do this when a list of facets was passed in.
			INSERT INTO @FacetedRecordCollTable (RecordID, collID) (
				-- Get records that have ALL the matching facets by comparing
				-- the number of rows per record with the number of facets requested.
				SELECT q1.recordID, q1.CollID  FROM (
					-- Get all the facets that match a filtering facet 
					-- for those records that match the keyword.
					SELECT rf.facetID, q.recordID, q.CollID
					FROM (	
						-- get all records that match the keyword
						SELECT rbp.CollID, rbp.RecordID, Min(rbp.SearchRank) searchRank
						FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'facet', NULL, @portalCode) rbp
						GROUP BY rbp.RecordID, rbp.CollID
					) q 
					INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = q.RecordID
					INNER JOIN @facets tf ON rf.facetID = tf.FacetID
				) q1
				GROUP BY q1.recordID, q1.CollID
				HAVING Count(q1.facetID) = @facetCount
			)
		END
		ELSE 
		BEGIN
			-- Do a simpler query when there were no facets passed in to filter on.
			INSERT INTO @FacetedRecordCollTable (RecordID, collID) (
				-- get all records that match the keyword
				SELECT rbp.RecordID, rbp.CollID
				FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'facet', NULL, @portalCode) rbp
				GROUP BY rbp.RecordID, rbp.CollID
			)
		END

		SELECT f.facetID, f.facetType, f.facetValue, 
			ISNULL(q2.collectionCount, 0) collectionCount, 
			ISNULL(q3.recordCount, 0) recordCount
		FROM dbo.Facets f 
		LEFT JOIN (
			SELECT q1.facetID, Count(q1.collID) collectionCount
			FROM (
				-- get all the facets that go with those records
				SELECT DISTINCT rf.facetID, q.collID 
				FROM @FacetedRecordCollTable q
				INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = q.recordID
			) q1	
			GROUP BY q1.facetID
		) q2 ON f.facetID = q2.facetID
		LEFT JOIN (
			-- get the count of records for all those facets
			SELECT q1.facetID, Count(q1.recordID) recordCount
			FROM (
				-- get all the facets that go with those records
				SELECT rf.facetID, q.recordID 
				FROM @FacetedRecordCollTable q
				INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = q.recordID
			) q1	
			GROUP BY q1.facetID
		) q3 ON f.facetID = q3.facetID
		ORDER BY facetType, recordCount DESC, collectionCount DESC
	END
	ELSE
	BEGIN
		IF @collectionID IS NOT NULL
		BEGIN
			-- Save the records filtered by collection and facets so we don't have to do
			-- a complex query multiple times.
			DECLARE @FacetedRecordTable table(RecordID int); 
			IF @facetCount <> 0
			BEGIN
				-- Do this when a list of facets was passed in.
				INSERT INTO @FacetedRecordTable (RecordID) (
					SELECT q.recordID FROM (
						-- Get all the facets that match a filtering facet 
						-- for those records that are in the collection.
						SELECT DISTINCT f.facetID, rmc.recordID
						FROM dbo.RecordsToMultipleCollections rmc
						INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = rmc.recordID
						INNER JOIN dbo.Facets f ON f.facetID = rf.facetID
						INNER JOIN @facets tf ON f.facetID = tf.facetID 
						WHERE rmc.collID = @collectionID
					) q
					GROUP BY q.recordID
					HAVING Count(q.facetID) = @facetCount
				)
			END
			ELSE
			BEGIN
				-- Do a simpler query when there were no facets passed in to filter on.
				INSERT INTO @FacetedRecordTable (RecordID) (
					SELECT DISTINCT rmc.recordID
					FROM dbo.RecordsToMultipleCollections rmc
					WHERE rmc.collID = @collectionID
				)
			END

			SELECT q1.facetID, q1.facetValue, q1.facetType,
				CASE COUNT(q1.recordID) WHEN 0 THEN 0 ELSE 1 END collectionCount, 
				Count(q1.recordID) recordCount
			FROM (
				-- get all the facets that go with those records
				SELECT f.facetID, f.facetValue, f.facetType, q.recordID 
				FROM @FacetedRecordTable q 
				INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = q.recordID
				INNER JOIN dbo.Facets f ON f.facetID = rf.facetID
			) q1	
			GROUP BY q1.facetID, q1.facetType, q1.facetValue
			ORDER BY facetType, recordCount DESC, collectionCount DESC
		END
	END

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/25/2010
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetCollectionSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL,
	@queryType nvarchar(255) = 'keyword', 
	@phraseType nvarchar(255) = 'keyword',
	@collectionID int = NULL,
	@browseID int = NULL,
	@facets FacetIDType READONLY,
	@portalCode tinyint = 0
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
	SET NOCOUNT ON;

	-- Use this variable to see if @facets were passed in
	DECLARE @facetCount INT;
	SELECT @facetCount = COUNT(*) FROM @facets;

    -- Insert statements for procedure here
    If @phrase IS NOT NULL
    BEGIN
		DECLARE @FacetedRecordCollRankTable table(SearchRank int, RecordID int, collID int); 
		IF @facetCount <> 0
		BEGIN
			INSERT INTO @FacetedRecordCollRankTable (SearchRank, RecordID, collID) (
				-- get records that have ALL the matching facets
				SELECT q1.searchRank, q1.recordID, q1.CollID  FROM (
					-- Get all the facets that match a filtering facet 
					-- for those records that match the keyword.
					SELECT rf.facetID, q.recordID, q.CollID, q.searchRank
					FROM (	
						-- get all records that match the keyword
						SELECT rbp.CollID, rbp.RecordID, Min(rbp.SearchRank) searchRank
						FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'collection', @browseID, @portalCode) rbp
						GROUP BY rbp.RecordID, rbp.CollID
					) q 
					INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = q.RecordID
					INNER JOIN @facets tf ON rf.facetID = tf.FacetID
				) q1
				GROUP BY q1.recordID, q1.searchRank, q1.CollID
				HAVING Count(q1.facetID) = @facetCount
			)
		END
		ELSE
		BEGIN
			INSERT INTO @FacetedRecordCollRankTable (SearchRank, RecordID, collID) (
				-- get all records that match the keyword
				SELECT MIN(rbp.SearchRank) searchRank, rbp.RecordID, rbp.CollID
				FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'collection', @browseID, @portalCode) rbp
				GROUP BY rbp.RecordID, rbp.CollID
			)
		END
	
		SELECT c.collID, c.title, c.institution, c.[description], c.isAvailableAt_URL, c.access,
			q3.searchRank, ct.oaiidentifier1 thumbnailIdentifier1, 
			ct.oaiidentifier2 thumbnailIdentifier2, ct.oaiidentifier3 thumbnailIdentifier3, 
			ct.oaiidentifier4 thumbnailIdentifier4, q3.collResultCount, q4.collCount
		FROM dbo.Collections c INNER JOIN (
			SELECT DISTINCT q1.CollID, q1.searchRank, q2.collResultCount FROM (
				SELECT DISTINCT q.collID, Min(q.searchRank) searchRank 
				FROM @FacetedRecordCollRankTable q 
				GROUP BY q.collID
			) q1 INNER JOIN (
				SELECT DISTINCT q.CollID, COUNT(q.recordID) collResultCount 
				FROM @FacetedRecordCollRankTable q
				GROUP BY q.CollID
			) q2 ON q1.collID = q2.collID
		) q3 ON c.collID = q3.collID 
		INNER JOIN (
			SELECT DISTINCT collID, COUNT(recordID) collCount 
			FROM dbo.RecordsToMultipleCollections
			GROUP BY collID
		) q4 ON c.collID = q4.collID
		LEFT JOIN dbo.CollectionsToThumbnails ct ON c.collID = ct.collID
		ORDER BY CASE WHEN @phraseType = 'browse' THEN c.title END, 
			q3.searchRank DESC, c.collID
	END
	ELSE
	BEGIN
		If @collectionID IS NOT NULL
		BEGIN
			-- Save the records filtered by collection and facets so we don't have to do
			-- a complex query multiple times.
			DECLARE @FacetedRecordCollTable table(CollID int, RecordID int); 
			IF @facetCount <> 0
			BEGIN
				-- Do this when a list of facets was passed in.
				INSERT INTO @FacetedRecordCollTable (CollID, RecordID) (
					SELECT q.collID, q.recordID FROM (
						-- Get all the facets that match a filtering facet 
						-- for those records that are in the collection.
						SELECT DISTINCT rf.facetID, rmc.recordID, rmc.collID
						FROM dbo.RecordsToMultipleCollections rmc
						INNER JOIN dbo.RecordsToFacets rf ON rf.recordID = rmc.recordID
						INNER JOIN @facets tf ON rf.facetID = tf.facetID 
						WHERE rmc.collID = @collectionID
					) q
					GROUP BY q.recordID, q.collID
					HAVING Count(q.facetID) = @facetCount
				)
			END
			ELSE
			BEGIN
				-- Do a simpler query when there were no facets passed in to filter on.
				INSERT INTO @FacetedRecordCollTable (CollID, RecordID) (
					SELECT DISTINCT rmc.collID, rmc.recordID
					FROM dbo.RecordsToMultipleCollections rmc
					WHERE rmc.collID = @collectionID
				)
			END
			
			SELECT c.collID, c.title, c.institution, c.[description], c.isAvailableAt_URL, c.access, 
				1 searchRank, ct.oaiidentifier1 thumbnailIdentifier1, 
				ct.oaiidentifier2 thumbnailIdentifier2, ct.oaiidentifier3 thumbnailIdentifier3, 
				ct.oaiidentifier4 thumbnailIdentifier4, q2.collResultCount, q3.collCount
			FROM dbo.Collections c INNER JOIN (
				SELECT q1.collID, COUNT(q1.recordID) collResultCount 
				FROM @FacetedRecordCollTable q1
				GROUP BY q1.collID
			) q2 ON c.collID = q2.collID 
			INNER JOIN (
				SELECT collID, COUNT(recordID) collCount 
				FROM dbo.RecordsToMultipleCollections
				GROUP BY collID
			) q3
			ON c.collID = q3.collID
			LEFT JOIN dbo.CollectionsToThumbnails ct ON c.collID = ct.collID
			ORDER BY c.collID
		END	
		ELSE
		BEGIN
			IF @browseID IS NOT NULL
			BEGIN
				DECLARE @RecordCollRankTable table(SearchRank int, RecordID int, collID int); 
				INSERT INTO @RecordCollRankTable (SearchRank, RecordID, collID) (
					-- get all records that match the keyword
					SELECT  MIN(rbp.SearchRank) searchRank, rbp.RecordID, rbp.CollID
					FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'collection', @browseID, @portalCode) rbp
					GROUP BY rbp.RecordID, rbp.CollID
				)

				SELECT c.collID, c.title, c.institution, c.[description], c.isAvailableAt_URL, c.access,
					q3.searchRank, ct.oaiidentifier1 thumbnailIdentifier1, 
					ct.oaiidentifier2 thumbnailIdentifier2, ct.oaiidentifier3 thumbnailIdentifier3, 
					ct.oaiidentifier4 thumbnailIdentifier4, q3.collResultCount, q4.collCount
				FROM dbo.Collections c INNER JOIN (
					SELECT DISTINCT q1.CollID, q1.searchRank, q2.collResultCount FROM (
						SELECT DISTINCT q.collID, Min(q.searchRank) searchRank 
						FROM @RecordCollRankTable q 
						GROUP BY q.collID
					) q1 INNER JOIN (
						SELECT DISTINCT q.CollID, COUNT(q.recordID) collResultCount 
						FROM @RecordCollRankTable q
						GROUP BY q.CollID
					) q2 ON q1.collID = q2.collID
				) q3 ON c.collID = q3.collID 
				INNER JOIN (
					SELECT DISTINCT collID, COUNT(recordID) collCount 
					FROM dbo.RecordsToMultipleCollections
					GROUP BY collID
				) q4 ON c.collID = q4.collID
				LEFT JOIN dbo.CollectionsToThumbnails ct ON c.collID = ct.collID
				ORDER BY c.title
			END
		END
	END
	
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	Setup GRANT permission for designated generic web user, for the above USPs,
--              UDFs, and the Type.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_4b_Grants]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;
    
    --DECLARE @dbName sysname; SET @dbName = DB_NAME()
    DECLARE @usrName sysname; SET @usrName = QUOTENAME('UIUC\iusr_libgrrama')
    DECLARE @schema sysname; SET @schema = 'dbo'
    DECLARE @schemaID sysname; SET @schemaID = -99
    DECLARE @tableType sysname; SET @tableType = QUOTENAME('FacetIDType')
    DECLARE @sql nvarchar(max) = ''
    
    SELECT @schemaID = schema_id FROM sys.schemas WHERE name = @schema
    
    -- (a) USPs:
    SELECT @sql += 'grant execute on ' + 
    				QUOTENAME(@schema) + '.' + QUOTENAME(name) + ' to ' + 
    				@usrName + char(13) + char(10)
      FROM sys.objects
     WHERE type = 'P'
       AND schema_id = @schemaID
       AND name not like 'onetime%'
    
    --print @sql
    exec(@sql)
    
    -- (b) Scalar UDFs:
    SET    @sql = ''
    SELECT @sql += 'grant execute on ' + 
    				QUOTENAME(@schema) + '.' + QUOTENAME(name) + ' to ' + 
    				@usrName + char(13) + char(10) +
                   'grant references on ' + 
    				QUOTENAME(@schema) + '.' + QUOTENAME(name) + ' to ' + 
    				@usrName + char(13) + char(10)
      FROM sys.objects
     WHERE type = 'FN'
       AND schema_id = @schemaID
    
    --print @sql
    exec(@sql)
    
    -- (c) Table-valued UDFs:
    SET    @sql = ''
    SELECT @sql += 'grant references on ' + 
    				QUOTENAME(@schema) + '.' + QUOTENAME(name) + ' to ' + 
    				@usrName + char(13) + char(10) +
    			   'grant select on ' + 
    				QUOTENAME(@schema) + '.' + QUOTENAME(name) + ' to ' + 
    				@usrName + char(13) + char(10)
      FROM sys.objects
     WHERE type in ('TF', 'IF')
       AND schema_id = @schemaID
       AND name <> 'RankByPhrase2'
    
    --print @sql
    exec(@sql)
    
    -- (d) UD Table Type(s):
    SET    @sql = ''
    SELECT @sql += 'grant references on TYPE::' + 
    				QUOTENAME(@schema) + '.' + @tableType + ' to ' + 
    				@usrName + char(13) + char(10) +
                   'grant control on TYPE::' + 
    				QUOTENAME(@schema) + '.' + @tableType + ' to ' + 
    				@usrName + char(13) + char(10)
    
    --print @sql
    exec(@sql)
    
END
GO

