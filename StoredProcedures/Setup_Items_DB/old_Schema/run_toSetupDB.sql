-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	This SQL script is intended for executing in a new, empty DB.  It may be
--              run by invoking Execute in a Query Window containing this SQL script (within
--              MS SQL Server Management Studio).  This will result in several USPs (with
--              names of the form:  setupdb_*) being created in the new DB.  (As well as
--              other USPs, UDFs, etc.)  Running the setupdb_* USPs, in sequence, will setup
--              the DB.
--  * NOTE *  : The DB Name must first be set (below).
-- ==========================================================================================



--
-- First, the DB Name must be set:
--
USE [IMLS_]
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
        [portalCode] [int] NULL,
     CONSTRAINT [PK_Repositories] PRIMARY KEY CLUSTERED 
    (
        [repoID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[Portals](
        [portalCode] [int] NOT NULL,
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
    
    CREATE TABLE [dbo].[CollTitleBrowse](
        [CollTitleID] [int] IDENTITY(1,1) NOT NULL,
        [CollTitleText] [nvarchar](127) NOT NULL,
        [itemCount] [int] NULL,
     CONSTRAINT [PK_CollTitleBrowse] PRIMARY KEY CLUSTERED 
    (
        [CollTitleID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollInstTypeBrowse](
        [CollInstTypeID] [int] IDENTITY(1,1) NOT NULL,
        [TypeOfInstText] [nvarchar](120) NOT NULL,
     CONSTRAINT [PK_CollInstTypeBrowse] PRIMARY KEY CLUSTERED 
    (
        [CollInstTypeID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollInstStateBrowse](
        [CollInstStateID] [int] IDENTITY(1,1) NOT NULL,
        [CollInstStateText] [nvarchar](50) NOT NULL,
     CONSTRAINT [PK_CollInstStateBrowse] PRIMARY KEY CLUSTERED 
    (
        [CollInstStateID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
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
        [portalCode] [int] NULL,
        [itemCount] [int] NULL,
     CONSTRAINT [PK_Registry] PRIMARY KEY CLUSTERED 
    (
        [collID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[Records](
        [recordID] [int] IDENTITY(2,1) NOT NULL,
        [repoID] [int] NULL,
        [cid] [int] NULL,
        [identifier] [nvarchar](250) NULL,
        [datestamp] [datetime] NULL,
        [status] [nvarchar](250) NULL,
        [filePath] [nvarchar](400) NULL,
        [minYear] [int] NULL,
        [maxYear] [int] NULL,
        [harvestDate] [datetime] NULL,
        [firstCreator] [nvarchar](250) NULL,
        [prov_repositoryID] [nvarchar](100) NULL,
        [prov_datestamp] [datetime] NULL,
        [prov_baseURL] [nvarchar](150) NULL,
        [searchXML] [xml] NULL,
        [shortXML] [xml] NULL,
        [longXML] [xml] NULL,
        [facetXML] [xml] NULL,
        [AquiferOAIIdentifier] [nvarchar](250) NULL,
        [title] [xml] NULL,
        [creator] [xml] NULL,
        [subject] [xml] NULL,
        [titleText] [nvarchar](max) NULL,
        [titleNoPunct] [nvarchar](max) NULL,
        [parent_description] [nvarchar](max) NULL,
        [parent_XMLBlob] [xml] NULL,
        [grandp_description] [nvarchar](max) NULL,
        [grandp_XMLBlob] [xml] NULL,
        [portalCode] [int] NULL,
     CONSTRAINT [PK_Records] PRIMARY KEY CLUSTERED 
    (
        [recordID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[PortalsToCollections](
        [PortalToCollID] [int] IDENTITY(1,1) NOT NULL,
        [portalCode] [int] NOT NULL,
        [collID] [int] NOT NULL,
     CONSTRAINT [PK_PortalsToCollections] PRIMARY KEY CLUSTERED 
    (
        [PortalToCollID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollInstNameBrowse](
        [CollInstNameID] [int] IDENTITY(1,1) NOT NULL,
        [CollInstNameText] [nvarchar](127) NULL,
        [CollInstStateID] [int] NULL,
        [CollInstTypeID] [int] NULL,
        [InstitutionID] [int] NULL,
     CONSTRAINT [PK_CollInstNameBrowse] PRIMARY KEY CLUSTERED 
    (
        [CollInstNameID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'InstitutionID from IH_IMLS table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CollInstNameBrowse', @level2type=N'COLUMN',@level2name=N'InstitutionID'
    
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
    
    CREATE TABLE [dbo].[CollectionsToFacets](
        [cfRow] [int] IDENTITY(1,1) NOT NULL,
        [facetID] [int] NOT NULL,
        [collid] [int] NOT NULL,
     CONSTRAINT [PK_CollectionsToFacets] PRIMARY KEY CLUSTERED 
    (
        [cfRow] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollectionsToCollTitle](
        [CollTitlePivotRow] [int] IDENTITY(1,1) NOT NULL,
        [CollTitleID] [int] NOT NULL,
        [CollID] [int] NOT NULL,
     CONSTRAINT [PK_CollectionsToCollTitle] PRIMARY KEY CLUSTERED 
    (
        [CollTitlePivotRow] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollectionsToCollInstType](
        [CollITypePivotRow] [int] IDENTITY(1,1) NOT NULL,
        [CollInstTypeID] [int] NOT NULL,
        [CollID] [int] NOT NULL,
        [relationship] [nvarchar](120) NULL,
     CONSTRAINT [PK_CollectionsToCollInstType] PRIMARY KEY CLUSTERED 
    (
        [CollITypePivotRow] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    ) ON [PRIMARY]
    
    CREATE TABLE [dbo].[CollectionsToCollInstState](
        [CollInstStatePivotRow] [int] IDENTITY(1,1) NOT NULL,
        [CollInstStateID] [int] NOT NULL,
        [CollID] [int] NOT NULL,
     CONSTRAINT [PK_CollectionsToCollInstState] PRIMARY KEY CLUSTERED 
    (
        [CollInstStatePivotRow] ASC
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
    
    CREATE TABLE [dbo].[CollectionsToCollInstName](
        [CollINamePivot] [int] IDENTITY(1,1) NOT NULL,
        [collID] [int] NOT NULL,
        [CollInstNameID] [int] NOT NULL,
     CONSTRAINT [PK_CollNamePivot] PRIMARY KEY CLUSTERED 
    (
        [CollINamePivot] ASC
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
-- Create date: 11/10/2011
-- Description:	Populate the Facets table with the requisite data.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_1b_Facets]
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
CREATE PROCEDURE [dbo].[setupdb_2_IntructionsforDataLoad]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;
    
    select '* NEXT STEP * - Load the DATA; accomplished by either running:'
    select '(a) IndexReap for Collections, & for Records, OR'
    select '(b) the sequence: Detach; Copy & Rename the 2 DB files .mdf & .ldf; Attach.'
    
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Winston Jansz
-- Create date: 11/10/2011
-- Description:	Create the Foreign Keys, the remaining Indexes, and Full-Text Catalogs.
-- ==========================================================================================
CREATE PROCEDURE [dbo].[setupdb_3a_FKsNdxsFTCs]
AS
BEGIN
    -- Prevent extra result sets from interfering with SELECT statements
    SET NOCOUNT ON;
    
    CREATE FULLTEXT CATALOG [Collections_XMLBlob]WITH ACCENT_SENSITIVITY = ON
    AUTHORIZATION [dbo]
    
    CREATE FULLTEXT CATALOG [Records_XMLSearch]WITH ACCENT_SENSITIVITY = ON
    AUTHORIZATION [dbo]
    
    ALTER TABLE [dbo].[CollectionsToCollInstName]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollInstName_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollInstName] CHECK CONSTRAINT [FK_CollectionsToCollInstName_Collections]
    
    ALTER TABLE [dbo].[CollectionsToCollInstName]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollInstName_CollInstNameBrowse] FOREIGN KEY([CollInstNameID])
    REFERENCES [dbo].[CollInstNameBrowse] ([CollInstNameID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollInstName] CHECK CONSTRAINT [FK_CollectionsToCollInstName_CollInstNameBrowse]
    
    ALTER TABLE [dbo].[CollectionsToCollInstState]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollInstState_Collections] FOREIGN KEY([CollID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollInstState] CHECK CONSTRAINT [FK_CollectionsToCollInstState_Collections]
    
    ALTER TABLE [dbo].[CollectionsToCollInstState]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollInstState_CollInstStateBrowse] FOREIGN KEY([CollInstStateID])
    REFERENCES [dbo].[CollInstStateBrowse] ([CollInstStateID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollInstState] CHECK CONSTRAINT [FK_CollectionsToCollInstState_CollInstStateBrowse]
    
    ALTER TABLE [dbo].[CollectionsToCollInstType]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollInstType_Collections] FOREIGN KEY([CollID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollInstType] CHECK CONSTRAINT [FK_CollectionsToCollInstType_Collections]
    
    ALTER TABLE [dbo].[CollectionsToCollInstType]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollInstType_CollInstTypeBrowse] FOREIGN KEY([CollInstTypeID])
    REFERENCES [dbo].[CollInstTypeBrowse] ([CollInstTypeID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollInstType] CHECK CONSTRAINT [FK_CollectionsToCollInstType_CollInstTypeBrowse]
    
    ALTER TABLE [dbo].[CollectionsToCollTitle]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollTitle_Collections] FOREIGN KEY([CollID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollTitle] CHECK CONSTRAINT [FK_CollectionsToCollTitle_Collections]
    
    ALTER TABLE [dbo].[CollectionsToCollTitle]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToCollTitle_CollTitleBrowse] FOREIGN KEY([CollTitleID])
    REFERENCES [dbo].[CollTitleBrowse] ([CollTitleID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToCollTitle] CHECK CONSTRAINT [FK_CollectionsToCollTitle_CollTitleBrowse]
    
    ALTER TABLE [dbo].[CollectionsToFacets]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToFacets_Collections] FOREIGN KEY([collid])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToFacets] CHECK CONSTRAINT [FK_CollectionsToFacets_Collections]
    
    ALTER TABLE [dbo].[CollectionsToFacets]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToFacets_Facets] FOREIGN KEY([facetID])
    REFERENCES [dbo].[Facets] ([facetID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToFacets] CHECK CONSTRAINT [FK_CollectionsToFacets_Facets]
    
    ALTER TABLE [dbo].[CollectionsToThumbnails]  WITH CHECK ADD  CONSTRAINT [FK_CollectionsToThumbnails_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[CollectionsToThumbnails] CHECK CONSTRAINT [FK_CollectionsToThumbnails_Collections]
    
    ALTER TABLE [dbo].[CollInstNameBrowse]  WITH CHECK ADD  CONSTRAINT [FK_CollInstNameBrowse_CollInstStateBrowse] FOREIGN KEY([CollInstStateID])
    REFERENCES [dbo].[CollInstStateBrowse] ([CollInstStateID])
    ALTER TABLE [dbo].[CollInstNameBrowse] CHECK CONSTRAINT [FK_CollInstNameBrowse_CollInstStateBrowse]
    
    ALTER TABLE [dbo].[CollInstNameBrowse]  WITH CHECK ADD  CONSTRAINT [FK_CollInstNameBrowse_CollInstTypeBrowse] FOREIGN KEY([CollInstTypeID])
    REFERENCES [dbo].[CollInstTypeBrowse] ([CollInstTypeID])
    ALTER TABLE [dbo].[CollInstNameBrowse] CHECK CONSTRAINT [FK_CollInstNameBrowse_CollInstTypeBrowse]
    
    ALTER TABLE [dbo].[PortalsToCollections]  WITH CHECK ADD  CONSTRAINT [FK_PortalsToCollections_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[PortalsToCollections] CHECK CONSTRAINT [FK_PortalsToCollections_Collections]
    
    ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Collections] FOREIGN KEY([cid])
    REFERENCES [dbo].[Collections] ([collID])
    ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Collections]
    
    ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Repositories] FOREIGN KEY([repoID])
    REFERENCES [dbo].[Repositories] ([repoID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Repositories]
    
    ALTER TABLE [dbo].[RecordsToCollections]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToCollections_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToCollections] CHECK CONSTRAINT [FK_RecordsToCollections_Collections]
    
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
    
    ALTER TABLE [dbo].[RecordsToMultipleCollections]  WITH CHECK ADD  CONSTRAINT [FK_RecordsToMultipleCollections_Collections] FOREIGN KEY([collID])
    REFERENCES [dbo].[Collections] ([collID])
    ON UPDATE CASCADE
    ON DELETE CASCADE
    ALTER TABLE [dbo].[RecordsToMultipleCollections] CHECK CONSTRAINT [FK_RecordsToMultipleCollections_Collections]
    
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
    
    CREATE NONCLUSTERED INDEX [CollTitleBrowse_titleText] ON [dbo].[CollTitleBrowse] 
    (
    	[CollTitleText] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [CollInstTypeBrowse_typeText] ON [dbo].[CollInstTypeBrowse] 
    (
    	[TypeOfInstText] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [CollInstNameStateBrowse_stateText] ON [dbo].[CollInstStateBrowse] 
    (
    	[CollInstStateText] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [Collections_portalCode] ON [dbo].[Collections] 
    (
    	[portalCode] ASC
    )
    INCLUDE ( [collID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
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
    
    CREATE NONCLUSTERED INDEX [CollectionsToFacets] ON [dbo].[CollectionsToFacets] 
    (
    	[facetID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [CollectionsToFacets_collID] ON [dbo].[CollectionsToFacets] 
    (
    	[collid] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [CollToCollTitle_collID] ON [dbo].[CollectionsToCollTitle] 
    (
    	[CollID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [CollToCollTitle_titleID] ON [dbo].[CollectionsToCollTitle] 
    (
    	[CollTitleID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [CollToCollInstType_collID] ON [dbo].[CollectionsToCollInstType] 
    (
    	[CollID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [CollToCollInstType_instTypeID] ON [dbo].[CollectionsToCollInstType] 
    (
    	[CollInstTypeID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [CollToCollInstType_relationship] ON [dbo].[CollectionsToCollInstType] 
    (
    	[relationship] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
    CREATE NONCLUSTERED INDEX [CollToCollInstState_collID] ON [dbo].[CollectionsToCollInstState] 
    (
    	[CollID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [CollToCollInstState_stateID] ON [dbo].[CollectionsToCollInstState] 
    (
    	[CollInstStateID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
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
    
    CREATE NONCLUSTERED INDEX [CollToCollInstName_collID] ON [dbo].[CollectionsToCollInstName] 
    (
    	[collID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    CREATE NONCLUSTERED INDEX [CollToCollInstName_nameID] ON [dbo].[CollectionsToCollInstName] 
    (
    	[CollInstNameID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
    
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
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to update the CollectionsToFacets
--				Table (only after Collections and Facets
--              tables have been populated).
-- =============================================
CREATE PROCEDURE [dbo].[onetime_updateColls2Facets] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Step 1; associate facets with collections based on collection XMLBlob
	DECLARE @facetid int;
	DECLARE @facetValue nvarchar(100);
	DECLARE @facetType nvarchar(50);

	DECLARE myRow CURSOR LOCAL FOR
		(select facetid, facetValue, facetType from facets);
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @facetID, @facetValue, @facetType;

	-- CHANGED varchar(255) to nvarhar(255) in .value method of XML objects, without retesting

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@facetType = 'Type')
				BEGIN
					insert into CollectionsToFacets (collID, facetID) (
					select collid, @facetID as facetID
						from Collections
						where XMLBlob.value('(/record/metadata[1]/dc/type[contains(., sql:variable("@facetValue"))])[1]', 'nvarchar(max)') <> '')
				END
			ELSE
				IF (@facetType = 'Date')
					BEGIN
						DECLARE @xMatchOn nvarchar(100) = '';
						DECLARE @xMatchOn2 nvarchar(100) = '';
						IF (@facetValue='Pre-1800')
						  BEGIN
							set @xMatchOn = '1700-1799';
							set @xMatchOn2 = '1400s-1699';
							insert into CollectionsToFacets (collID, facetID) (
							(select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
							union
							(select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn2")])[1]', 'nvarchar(max)') <> '')
							)
							
						  END
						ELSE IF (@facetValue='Early 19th century')
						  BEGIN
							set @xMatchOn = '1800-1849';
							insert into CollectionsToFacets (collID, facetID) (
							select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
							
						  END
						ELSE IF (@facetValue='Late 19th century')
						  BEGIN
							set @xMatchOn = '1850-1899';
							insert into CollectionsToFacets (collID, facetID) (
							select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
							
						  END
						ELSE IF (@facetValue='Early 20th century')
						  BEGIN
							set @xMatchOn = '1900-1929';							
							set @xMatchOn2 = '1930-1949';
							insert into CollectionsToFacets (collID, facetID) (
							(select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
							union
							(select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn2")])[1]', 'nvarchar(max)') <> ''))
							
						  END
						ELSE IF (@facetValue='Late 20th century')
						  BEGIN
							set @xMatchOn = '1950-1969';							
							set @xMatchOn2 = '1970-1999';
							insert into CollectionsToFacets (collID, facetID) (
							(select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
							union
							(select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn2")])[1]', 'nvarchar(max)') <> ''))
							
						  END
						ELSE IF (@facetValue='2000-Present')
						  BEGIN
							set @xMatchOn = '2000 to present';
							insert into CollectionsToFacets (collID, facetID) (
							select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
							
						  END 
						ELSE 
						  BEGIN
							set @xMatchOn = @facetValue;
							insert into CollectionsToFacets (collID, facetID) (
							select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xMatchOn")])[1]', 'nvarchar(max)') <> '')
						  END
							
					END
				ELSE
					IF (@facetType = 'Place')
						BEGIN
							DECLARE @xState nvarchar(127) = @facetValue + ' (state)';
							insert into CollectionsToFacets (collID, facetID) (
							select collid, @facetID as facetID
								from Collections
								where XMLBlob.value('(/record/metadata[1]/dc/coverage[.=sql:variable("@xState")])[1]', 'nvarchar(max)') <> '')
						END
			FETCH NEXT FROM myRow INTO @facetID, @facetValue, @facetType;

		END
	CLOSE myRow;
	DEALLOCATE myRow;
	
	-- Step 2: Associate facets with Collections having items based on the facets of those items 
	DECLARE @cid int;

	DECLARE myRow CURSOR LOCAL FOR
		(select c5.collid from [dbo].[Collections] c5 where c5.itemCount >0);
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @cid;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @fid int;
			
			DECLARE myInsideRow CURSOR LOCAL FOR
				(select rf5.facetID from [dbo].[Records] r5
					join [dbo].[RecordsToFacets] rf5 on rf5.recordid = r5.recordid
					where r5.cid = @cid
					group by rf5.facetID);
				OPEN myInsideRow;
				FETCH NEXT FROM myInsideRow INTO @fid;
				
				WHILE @@FETCH_STATUS = 0
				BEGIN
					DECLARE @myCnt int;
					SET @myCnt = (SELECT COUNT(*) from [dbo].[CollectionsToFacets] cf6 where cf6.collid = @cid and cf6.facetID=@fid)
					IF @myCnt = 0
						INSERT INTO [dbo].[CollectionsToFacets] (collid, facetID) VALUES (@cid, @fid)
					FETCH NEXT FROM myInsideRow INTO @fid;
				
				END
				CLOSE myInsideRow;
				DEALLOCATE myInsideRow;

			FETCH NEXT FROM myRow INTO @cid;

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
-- Author:		Winston Jansz
-- Create date: Nov 12, 2010
-- Description:	Run this to update the Records
--				Table (ONLY after Collections &
--				Records tables have been populated).
--              - Adds collection-level (parent &
--              grandparent) info to item records.
-- =============================================
CREATE PROCEDURE [dbo].[onetime_CollectionsToRecords] 
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to insert into CollTitleBrowse
--              and CollectionsToCollTitle Tables (only
--              after Collections table has been populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_populateCollTitleBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- This SP assumes all records have one and only one non-null titleText value
	
	-- may need to modify not to get institution names associated with non-NLG physical collections, etc.
	-- may need to modify not to put rows in pivot table that connect to non-NLG physical collections, etc.


	DECLARE @collID int;
	DECLARE @collTitleID int;
	DECLARE @collTitleText nvarchar(max);
	DECLARE @collTitleTextClean nvarchar(max);
	declare @collItemCount int;
	DECLARE myRow CURSOR LOCAL FOR
		(select title, collID, itemCount  from Collections);
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @collTitleText, @collID, @collItemCount;
	WHILE @@FETCH_STATUS = 0
		BEGIN			   
		    SET @collTitleTextClean = [dbo].CleanText(@collTitleText)
			
			IF EXISTS(select * from [dbo].[CollTitleBrowse] tb where tb.CollTitleText = @collTitleTextClean)
				set @collTitleID = (select CollTitleID from [dbo].[CollTitleBrowse] tb where tb.CollTitleText = @collTitleTextClean);
			ELSE
			  BEGIN	 
				insert into [dbo].[CollTitleBrowse] (CollTitleText, itemCount) VALUES (@collTitleTextClean, @collItemCount);
				set @collTitleID = (select @@IDENTITY);
			  END
			  
			insert into [dbo].[CollectionsToCollTitle] (CollID, CollTitleID) VALUES (@collID, @collTitleID);
			
			FETCH NEXT FROM myRow INTO @collTitleText, @collID, @collItemCount;
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
-- Description:	Run this to insert into CollInstTypeBrowse
--              and CollectionsToCollInstType Tables (only
--              after Collections table has been populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_populateCollInstTypeBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[CollInstTypeBrowse] (TypeOfInstText)
		Select distinct ip.[text] from [IH_IMLS].[dbo].[InstitutionProperties] ip
		  where ip.[property] = 'type_institution'
		   and ip.institutionID in 
		      (select distinct i.institutionID from [IH_IMLS].[dbo].[Institutions] i
					join [IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = i.institutionID
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
		  FROM [IH_IMLS].[dbo].[InstitutionProperties] ip
		  join [IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = ip.institutionID
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to insert into CollInstStateBrowse
--              and CollectionsToCollInstState Tables (only
--              after Collections table has been populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_populateCollInstStateBrowse] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	-- may need to modify not to get institution names associated with non-NLG physical collections, etc.
	-- may need to modify not to put rows in pivot table that connect to non-NLG physical collections, etc.

	SET NOCOUNT ON;

	INSERT INTO [dbo].[CollInstStateBrowse] (CollInstStateText)
		Select distinct ip.[text] from [IH_IMLS].[dbo].[InstitutionProperties] ip
		  where ip.[property] = 'state'
		   and ip.institutionID in 
		      (select distinct i.institutionID from [IH_IMLS].[dbo].[Institutions] i
					join [IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = i.institutionID
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
		  FROM [IH_IMLS].[dbo].[InstitutionProperties] ip
		  join [IH_IMLS].[dbo].[CollectionInstitutions] ci on ci.institutionID = ip.institutionID
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 12 August 2011
-- Description:	Run this to insert into CollInstNameBrowse
--              and CollectionsToCollInstName Tables (only
--              after Collections, CollInstStateBrowse,
--              and CollInstTypeBrowse tables have been
--              populated).
--		Could also do with trigger?
-- =============================================
CREATE PROCEDURE [dbo].[onetime_populateCollInstNameBrowse] 

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
    DECLARE @collInstNameTextClean nvarchar(max);
	DECLARE @InstitutionID int;
	DECLARE myRow CURSOR LOCAL FOR
		(select i.institutionName as institution, ci.collectionID as collid, i.InstitutionID as InstitutionID
			from [IH_IMLS].[dbo].[CollectionInstitutions] ci
			join [IH_IMLS].[dbo].[Institutions] i on ci.institutionID = i.institutionID );
	    
	OPEN myRow;
	FETCH NEXT FROM myRow INTO @collInstNameText, @collID, @InstitutionID;
	WHILE @@FETCH_STATUS = 0
		BEGIN			   
		    SET @collInstNameTextClean = [dbo].CleanText(@collInstNameText)
		   
			IF EXISTS(select * from [dbo].[CollInstNameBrowse] tb where tb.CollInstNameText = @collInstNameTextClean)
				set @collInstNameID = (select CollInstNameID from [dbo].[CollInstNameBrowse] tb where tb.CollInstNameText = @collInstNameTextClean);
			ELSE
			  BEGIN	 
				insert into [dbo].[CollInstNameBrowse] (CollInstNameText, InstitutionID) VALUES (@collInstNameTextClean, @InstitutionID);
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
			join [IH_IMLS].[dbo].[InstitutionProperties] ip1 on cin.InstitutionID = ip1.InstitutionID
			join [IH_IMLS].[dbo].[InstitutionProperties] ip2 on cin.InstitutionID = ip2.InstitutionID
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
		   
			IF EXISTS(select * from [dbo].[TitleBrowse] tb where tb.titleText = @titleTextClean)
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
		   
			IF EXISTS(select * from [dbo].[DateBrowse] tb where tb.dateText = @dateTextClean)
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



--
-- Create this function in the Registry (Collections) DB if it does not already exist
--
IF NOT EXISTS ( SELECT     1
                FROM       [IH_IMLS].sys.objects
                WHERE      name = 'GetPortalCode'
                AND        type IN (N'FN', N'IF', N'TF', N'FS', N'FT') )
BEGIN

    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
    -- ==========================================================================================
    -- Author:		Winston Jansz
    -- Create date: Oct 28, 2011
    -- Description:	Determine the Portal Code from the Registry (Collections DB).
    --
    --	I:   @collID        int
    --	O:   @portalCode    int
    --
    -- ==========================================================================================
    CREATE FUNCTION [dbo].[GetPortalCode]
    (	
    	-- Formal Parameters for the function go here
    	@collID     int
    )
    RETURNS int --@portalCode
    WITH SCHEMABINDING
    AS
    BEGIN
    	-- Constants
    	DECLARE  @STR_HISTORY   nvarchar(5); SET @STR_HISTORY   = 'Hist'; -- FYI: the DB is case-insensitive to strings
    	DECLARE  @STR_IMLS_NLG  nvarchar(5); SET @STR_IMLS_NLG  = 'NLG';
    	DECLARE  @STR_IMLS_LSTA nvarchar(5); SET @STR_IMLS_LSTA = 'LSTA';
    	DECLARE  @STR_IMLS_MFA  nvarchar(5); SET @STR_IMLS_MFA  = 'MFA';
    	DECLARE  @STR_AQUIFER   nvarchar(5); SET @STR_AQUIFER   = 'DLF';
    	DECLARE  @STR_DPLA      nvarchar(5); SET @STR_DPLA      = 'DPLA';
    	DECLARE  @INT_HISTORY   tinyint;     SET @INT_HISTORY   =  2;
    	DECLARE  @INT_IMLS      tinyint;     SET @INT_IMLS      =  4;
    	DECLARE  @INT_AQUIFER   tinyint;     SET @INT_AQUIFER   =  8;
    	DECLARE  @INT_DPLA      tinyint;     SET @INT_DPLA      = 16;
    
    	-- Variables
        DECLARE  @portalCode    int; SET @portalCode = 1;
        DECLARE  @ready         bit
                ,@hist          nvarchar(50)
                ,@imls          nvarchar(50)
                ,@dlf           nvarchar(50)
                ,@dpla          nvarchar(50);
    
    	-- Select pertinent row from IH_IMLS.Collections table
        SELECT   @ready = c.ready
                ,@hist  = LTRIM(RTRIM(c.hist))
                ,@imls  = LTRIM(RTRIM(c.imls))
                ,@dlf   = LTRIM(RTRIM(c.dlf))
                ,@dpla  = LTRIM(RTRIM(c.dpla))
        FROM     [IH_IMLS].[dbo].[Collections] c
        WHERE    c.collectionID = @collID;
    
    	-- Make sure .ready is set!
        IF ISNULL(@ready, 0) <> 1
    		RETURN NULL; -- this would be an ERROR!
    		
    	-- Update the Portal Code
    	IF ISNULL(@hist, '') = @STR_HISTORY
    		SET @portalCode = @portalCode | @INT_HISTORY;
    	IF ISNULL(@imls, '') IN (@STR_IMLS_NLG, @STR_IMLS_LSTA, @STR_IMLS_MFA)
    		SET @portalCode = @portalCode | @INT_IMLS;
    	IF ISNULL(@dlf, '') = @STR_AQUIFER
    		SET @portalCode = @portalCode | @INT_AQUIFER;
    	IF ISNULL(@dpla, '') = @STR_DPLA
    		SET @portalCode = @portalCode | @INT_DPLA;
    		
    	RETURN (@portalCode);
    END

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
CREATE PROCEDURE [dbo].[setupdb_3b_Portals] 
AS
BEGIN
	-- Prevent extra result sets from interfering with SELECT statements...
	SET NOCOUNT ON;

    -- Variables
    DECLARE  @iterCurrCollID    int = NULL
            ,@iterNextCollID    int = NULL
            ,@portalCode        int;

            
    /*
     *  First, populate the Portals table
     */           
    INSERT   [dbo].[Portals]   (portalCode,portalName,portalURL)
    VALUES   ( 1, 'All',             'http://imlsdccweb.grainger.illinois.edu')
            ,( 2, 'Opening History', 'http://openinghistory.grainger.illinois.edu')
            ,( 4, 'IMLS',            'http://imls.grainger.illinois.edu')
            ,( 8, 'Aquifer',         'http://aquifer.grainger.illinois.edu')
            ,(16, 'DPLA',            'http://dpla.grainger.illinois.edu');

    /*
     *  Next, the pivot table PortalsToCollections
     *  (Using a non-cursor method to cycle through the Collections table.)
     */           
    -- Initialize loop variable
    SELECT   @iterCurrCollID = MIN(collID) 
    FROM     [dbo].[Collections];

    -- Make sure the table has data
    IF ISNULL(@iterCurrCollID, 0) = 0
    BEGIN
        SELECT 'No data was found in Collections table!';
        RETURN;
    END

    -- Start the main processing loop
    WHILE @iterCurrCollID IS NOT NULL
    BEGIN
        -- This is where you perform your detailed row-by-row processing
        INSERT   [dbo].[PortalsToCollections] (portalCode, collID)
        VALUES   ( [IH_IMLS].[dbo].GetPortalCode(@iterCurrCollID), @iterCurrCollID )   -- call UDF to get portalCode

        -- Get the next collID
        SELECT   @iterNextCollID = MIN(collID)
        FROM     [dbo].[Collections]
        WHERE    collID > @iterCurrCollID;

        -- Did we get a valid collID?
        IF ISNULL(@iterNextCollID, 0) = 0
        BEGIN
            BREAK; -- it's time to exit!
        END

		-- Set/Reset looping variables
        SET @iterCurrCollID = @iterNextCollID;
        SET @iterNextCollID = NULL;
    END --WHILE


    /*
     *  Finally, populate the 'portalCode' column in relevant tables
     */           
    -- Records table
    UPDATE r
       SET r.portalCode = p.portalCode
      FROM [dbo].[Records] r
          ,[dbo].[RecordsToMultipleCollections] r2c
          ,[dbo].[PortalsToCollections] p
     WHERE r.recordID = r2c.recordID
       AND r.cid = p.collID;
    
    -- Also take care of NULLS
    UPDATE [dbo].[Records]
       SET portalCode = 1
     WHERE portalCode is null;
    
    -- Collections table
    update c
       set c.portalCode = p.portalCode
      from [dbo].[Collections] c
          ,[dbo].[PortalsToCollections] p
     where c.collID = p.collID;
    
    -- Also take care of NULLS
    update [dbo].[Collections]
       set portalCode = 1
     where portalCode is null;
    
    -- Repositories table
    update t
       set t.portalCode = p.portalCode
      from [dbo].[Repositories] t
          ,[dbo].[Records] r
          ,[dbo].[PortalsToCollections] p
     where r.repoID = t.repoID
       and r.cid = p.collID;
    
    -- Also take care of NULLS
    update [dbo].[Repositories]
       set portalCode = 1
     where portalCode is null;
    
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
	@portalCode int = 1
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
--	This function returns table of records ID matching set of facets (i.e., for pre-canned searches)
--	@facets (REQUIRED) -- implies query type of browse
--
-- =============================================
CREATE FUNCTION [dbo].[collBrowseTQWith1Facet]
(	
	-- Add the parameters for the function here
	@facetIn nvarchar(255),
	@portalCode int = 1 

)
RETURNS 
	@collBrowseTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	collID int
)
AS
BEGIN

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct cbt.collID from [dbo].[CollectionsToFacets] cbt
			join [dbo].[collections] c on cbt.collID = c.collID
			  where cbt.facetID in (select * from @facet)
			  and (c.portalCode & @portalCode) = @portalCode
			  order by cbt.collID
	
  
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 18 August 2011
-- Description:	
--	This function returns table of records ID matching a date, subject, title, or type ID (i.e., selected by user from browse list)
--	@browseID (REQUIRED) 
--  @queryType is column_name | (column_list) | *, following supported:
--		date
--		subject
--		type
--		title (default)
-- =============================================
CREATE FUNCTION [dbo].[collBrowseTableQuery]
(	
	-- Add the parameters for the function here
	@browseID int = 1,
	@queryType nvarchar(255) = '*'

)
RETURNS 
	@collBrowseTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	collID int
)
AS
BEGIN

	IF (LEFT(@queryType, 1)='c') 
		BEGIN
		IF @queryType = 'citype'
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollInstType] bt
			where bt.collInstTypeID = @browseID 

		ELSE IF @queryType = 'ciname'
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollInstName] bt
			where bt.collInstNameID = @browseID 

		ELSE IF @queryType = 'cistate'
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollInstState] bt
			where bt.collInstStateID = @browseID 
    
		ELSE    
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollTitle] bt
			where bt.collTitleID = @browseID 
		
		END

	ELSE
	BEGIN
		IF ( @queryType = 'date')   
			INSERT INTO @collBrowseTableQuery(collID)			
			(select r.cid as collID
			from [dbo].[RecordsToDateBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.dateID = @browseID
			  group by r.cid)
				
		ELSE IF ( @queryType = 'type')
			INSERT INTO @collBrowseTableQuery(collID)
			(select r.cid as collID
			from [dbo].[RecordsToTypes] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.typeID = @browseID
			  group by r.cid)

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @collBrowseTableQuery(collID)
			(select r.cid as collID
			from [dbo].[RecordsToSubjects] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.subjectID = @browseID
			  group by r.cid)

		ELSE   
			INSERT INTO @collBrowseTableQuery(collID)
			(select r.cid as collID
			from [dbo].[RecordsToTitleBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.titleID = @browseID
			  group by r.cid)
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
-- Create date: 18 August 2011
-- Description:	
--	This function returns table of records ID matching a date, subject, title, or type ID (i.e., selected by user from browse list)
--	@browseID (REQUIRED) 
--  @queryType is column_name | (column_list) | *, following supported:
--		date
--		subject
--		type
--		title (default)
-- =============================================
CREATE FUNCTION [dbo].[bTQWithPCOnly]
(	
	-- Add the parameters for the function here
	@browseID int = 1,
	@queryType nvarchar(255) = '*',
	@collectionID int = 0,
	@portalCode int = 1
 

)
RETURNS 
	@browseTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int
)
AS
BEGIN
 IF (LEFT(@queryType, 1)='c') 
		BEGIN
		IF @queryType = 'citype'
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollInstType] bt
			where bt.collInstTypeID = @browseID) 
			q1
			join [dbo].[Records] r on r.cid = q1.collID
			where (r.portalCode & @portalCode) = @portalCode

		ELSE IF @queryType = 'ciname'
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollInstName] bt
			where bt.collInstNameID = @browseID)
			q1
			join [dbo].[Records] r on r.cid = q1.collID
			where (r.portalCode & @portalCode) = @portalCode

		ELSE IF @queryType = 'cistate'
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollInstState] bt
			where bt.collInstStateID = @browseID)
			q1
			join [dbo].[Records] r on r.cid = q1.collID    
			where (r.portalCode & @portalCode) = @portalCode
    
		ELSE    
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollTitle] bt
			where bt.collTitleID = @browseID) 
			q1
			join [dbo].[Records] r on r.cid = q1.collID
			where (r.portalCode & @portalCode) = @portalCode
		
		END
 ELSE
  IF (@collectionID = 0)
	BEGIN
		IF ( @queryType = 'date')   
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToDateBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.dateID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  order by bt.recordID
				
		ELSE IF ( @queryType = 'type')
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToTypes] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.typeID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  order by bt.recordID

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToSubjects] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.subjectID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  order by bt.recordID

		ELSE   
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToTitleBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.titleID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  order by bt.recordID
	END
	
  ELSE
	BEGIN
		IF ( @queryType = 'date')   
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToDateBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.dateID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  and r.cid = @collectionID
			  order by bt.recordID
				
		ELSE IF ( @queryType = 'type')
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToTypes] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.typeID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  and r.cid = @collectionID
			  order by bt.recordID

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToSubjects] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.subjectID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  and r.cid = @collectionID
			  order by bt.recordID

		ELSE   
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToTitleBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.titleID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  and r.cid = @collectionID
			  order by bt.recordID	
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
	@portalCode int = 1 

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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Tim Cole
-- Create date: 18 August 2011
-- Description:	
--	This function returns table of records ID matching a date, subject, title, or type ID (i.e., selected by user from browse list)
--	@browseID (REQUIRED) 
--  @queryType is column_name | (column_list) | *, following supported:
--		date
--		subject
--		type
--		title (default)
-- =============================================
CREATE FUNCTION [dbo].[BrowseTableQuery]
(	
	-- Add the parameters for the function here
	@browseID int = 1,
	@queryType nvarchar(255) = '*'

)
RETURNS 
	@browseTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	RecordID int
)
AS
BEGIN

	IF (LEFT(@queryType, 1)='c') 
		BEGIN
		IF @queryType = 'citype'
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollInstType] bt
			where bt.collInstTypeID = @browseID) 
			q1
			join [dbo].[Records] r on r.cid = q1.collID

		ELSE IF @queryType = 'ciname'
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollInstName] bt
			where bt.collInstNameID = @browseID)
			q1
			join [dbo].[Records] r on r.cid = q1.collID

		ELSE IF @queryType = 'cistate'
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollInstState] bt
			where bt.collInstStateID = @browseID)
			q1
			join [dbo].[Records] r on r.cid = q1.collID    
    
		ELSE    
			INSERT INTO @browseTableQuery(RecordID) 
			select r.recordID as recordID from
			(select bt.collID  
			from [dbo].[CollectionsToCollTitle] bt
			where bt.collTitleID = @browseID) 
			q1
			join [dbo].[Records] r on r.cid = q1.collID
    
		END	

	ELSE
		BEGIN
		IF ( @queryType = 'date')   
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToDateBrowse] bt
			  where bt.dateID = @browseID order by bt.recordID
			
				
		ELSE IF ( @queryType = 'type')
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToTypes] bt
			  where bt.typeID = @browseID  order by bt.recordID
			

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToSubjects] bt
			  where bt.subjectID = @browseID order by bt.recordID
			

		ELSE   
			INSERT INTO @browseTableQuery(RecordID) 
			select bt.recordID from [dbo].[RecordsToTitleBrowse] bt
			  where bt.titleID = @browseID order by bt.recordID
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
CREATE FUNCTION [dbo].[BrowseItemCount]
(	
	-- Add the parameters for the function here
	@browseID as int = 1,
	@queryType nvarchar(256) = '*' 
)
RETURNS int 
AS
BEGIN	
	Declare @itemCount int

 IF (LEFT(@queryType, 1)='c') 
    BEGIN
	IF @queryType = 'citype'
		set @itemCount = (select count(r.recordID) as ItemCount from
		(select bt.collID  
		from [dbo].[CollectionsToCollInstType] bt
		where bt.collInstTypeID = @browseID) 
		q1
		join [dbo].[Records] r on r.cid = q1.collID)

	ELSE IF @queryType = 'ciname'
		set @itemCount = (select count(r.recordID) as ItemCount from
		(select bt.collID  
		from [dbo].[CollectionsToCollInstName] bt
		where bt.collInstNameID = @browseID)
		q1
		join [dbo].[Records] r on r.cid = q1.collID)

	ELSE IF @queryType = 'cistate'
		set @itemCount = (select count(r.recordID) as ItemCount from
		(select bt.collID  
		from [dbo].[CollectionsToCollInstState] bt
		where bt.collInstStateID = @browseID)
		q1
		join [dbo].[Records] r on r.cid = q1.collID)

	ELSE 
		set @itemCount = (select count(r.recordID) as ItemCount from
		(select bt.collID  
		from [dbo].[CollectionsToCollTitle] bt
		where bt.collTitleID = @browseID) 
		q1
		join [dbo].[Records] r on r.cid = q1.collID)
    
    END   
 ELSE   

    BEGIN
	IF @queryType = 'date'
		set @itemCount = (select count(bt.recordID)  
		from [dbo].[RecordsToDateBrowse] bt
		where bt.dateID = @browseID)

	ELSE IF @queryType = 'subject'
		set @itemCount = (select count(bt.recordID)  
		from [dbo].[RecordsToSubjects] bt
		where bt.subjectID = @browseID)

	ELSE IF @queryType = 'type'
		set @itemCount = (select count(bt.recordID)  
		from [dbo].[RecordsToTypes] bt
		where bt.typeID = @browseID)

	ELSE 
		set @itemCount = (select count(bt.recordID)  
		from [dbo].[RecordsToTitleBrowse] bt
		where bt.TitleID = @browseID)
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
CREATE FUNCTION [dbo].[BrowseCollCount]
(	
	-- Add the parameters for the function here
	@browseID as int = 1,
	@queryType nvarchar(256) = '*' 
)
RETURNS int 
AS
BEGIN	
	Declare @collCount int
  IF (LEFT(@queryType, 1)='c') 
    BEGIN
	IF @queryType = 'citype'
		set @collCount = (select count(bt.collID)  
		from [dbo].[CollectionsToCollInstType] bt
		where bt.collInstTypeID = @browseID)

	ELSE IF @queryType = 'ciname'
		set @collCount = (select count(bt.collID)  
		from [dbo].[CollectionsToCollInstName] bt
		where bt.collInstNameID = @browseID)

	ELSE IF @queryType = 'cistate'
		set @collCount = (select count(bt.collID)  
		from [dbo].[CollectionsToCollInstState] bt
		where bt.collInstStateID = @browseID)

	ELSE 
		set @collCount = (select count(bt.collID)  
		from [dbo].[CollectionsToCollTitle] bt
		where bt.collTitleID = @browseID)
	END
	
  ELSE
	BEGIN
	IF @queryType = 'date'
		set @collCount = (select count(q1.collID) as collCount from
		(select r.cid as collID 
		from [dbo].[RecordsToDateBrowse] bt
		join [dbo].[Records] r on r.recordID = bt.recordID
		where bt.dateID = @browseID
		group by r.cid) q1)

	ELSE IF @queryType = 'subject'
		set @collCount = (select count(q1.collID) as collCount from
		(select r.cid as collID 
		from [dbo].[RecordsToSubjects] bt
		join [dbo].[Records] r on r.recordID = bt.recordID
		where bt.subjectID = @browseID
		group by r.cid) q1)
		
	ELSE IF @queryType = 'type'
		set @collCount = (select count(q1.collID) as collCount from
		(select r.cid as collID 
		from [dbo].[RecordsToTypes] bt
		join [dbo].[Records] r on r.recordID = bt.recordID
		where bt.typeID = @browseID
		group by r.cid) q1)

	ELSE 
		set @collCount = (select count(q1.collID) as collCount from
		(select r.cid as collID 
		from [dbo].[RecordsToTitleBrowse] bt
		join [dbo].[Records] r on r.recordID = bt.recordID
		where bt.TitleID = @browseID	
		group by r.cid) q1)

	END
 
	RETURN (@collCount)
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
CREATE FUNCTION [dbo].[GetFacetsCTQWithPCOnly]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode int = 1
)
RETURNS 
	@GetFacetsCTQ TABLE 
(
	-- Add the column definitions for the TABLE variable here
	facetID int,
	itemCount int,
	collCount int
)
AS
BEGIN

  IF (@collectionID = 0)
	BEGIN
	IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE 
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID	FROM 
					(select ISNULL(ct.[key], ct2.[key]) as recordID 
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(q00.recordID) as ItemCount, 0 as CollCount from
					(select ISNULL(ct.[key], ct2.[key]) as recordID
					  from containsTable([dbo].[records], *, @phrase, @top_n) ct
					  full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q00
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q00.recordID
					join [dbo].[Records] r on q00.recordID = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
				group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	END
  ELSE
	BEGIN
		IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					group by rtf.facetID)
					order by itemCount DESC
				
		ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					group by rtf.facetID)
					order by itemCount DESC

		ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					group by rtf.facetID)
					order by itemCount DESC

		ELSE   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(q1.recordID) as ItemCount, 1 as CollCount
					from (select ISNULL(ct.[key], ct2.[key]) as recordID
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
					join [dbo].[Records] r on q1.recordID = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q1.recordID
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					group by rtf.facetID)
					order by itemCount DESC

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
-- =============================================
CREATE FUNCTION [dbo].[GetFacetsCTQWith3Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode int = 1,
	@facetIn nvarchar(255),
	@facetIn2 nvarchar(255),
	@facetIn3 nvarchar(255)
)
RETURNS 
	@GetFacetsCTQ TABLE 
(
	-- Add the column definitions for the TABLE variable here
	facetID int,
	itemCount int,
	collCount int
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
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet3))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet3))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet3))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE 
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID	FROM 
					(select ISNULL(ct.[key], ct2.[key]) as recordID 
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet3))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(q00.recordID) as ItemCount, 0 as CollCount from
					(select ISNULL(ct.[key], ct2.[key]) as recordID
					  from containsTable([dbo].[records], *, @phrase, @top_n) ct
					  full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q00
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q00.recordID
					join [dbo].[Records] r on q00.recordID = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	END
  ELSE
	BEGIN
		IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID)
					order by itemCount DESC
				
		ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID)
					order by itemCount DESC

		ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID)
					order by itemCount DESC

		ELSE   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(q1.recordID) as ItemCount, 1 as CollCount
					from (select ISNULL(ct.[key], ct2.[key]) as recordID
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
					join [dbo].[Records] r on q1.recordID = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q1.recordID
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet3))				
					group by rtf.facetID)
					order by itemCount DESC

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
-- =============================================
CREATE FUNCTION [dbo].[GetFacetsCTQWith2Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode int = 1,
	@facetIn nvarchar(255),
	@facetIn2 nvarchar(255)
)
RETURNS 
	@GetFacetsCTQ TABLE 
(
	-- Add the column definitions for the TABLE variable here
	facetID int,
	itemCount int,
	collCount int
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
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE 
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID	FROM 
					(select ISNULL(ct.[key], ct2.[key]) as recordID 
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet2))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(q00.recordID) as ItemCount, 0 as CollCount from
					(select ISNULL(ct.[key], ct2.[key]) as recordID
					  from containsTable([dbo].[records], *, @phrase, @top_n) ct
					  full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q00
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q00.recordID
					join [dbo].[Records] r on q00.recordID = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	END
  ELSE
	BEGIN
		IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID)
					order by itemCount DESC
				
		ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID)
					order by itemCount DESC

		ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID)
					order by itemCount DESC

		ELSE   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(q1.recordID) as ItemCount, 1 as CollCount
					from (select ISNULL(ct.[key], ct2.[key]) as recordID
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
					join [dbo].[Records] r on q1.recordID = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q1.recordID
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet2))				
					group by rtf.facetID)
					order by itemCount DESC

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
-- =============================================
CREATE FUNCTION [dbo].[GetFacetsCTQWith1Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = '*', 
	@top_n int = 10000,
	@collectionID int = 0,
	@portalCode int = 1,
	@facetIn nvarchar(255)
)
RETURNS 
	@GetFacetsCTQ TABLE 
(
	-- Add the column definitions for the TABLE variable here
	facetID int,
	itemCount int,
	collCount int
)
AS
BEGIN
  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));	

  IF (@collectionID = 0)
	
	IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[Records] r on ct.[key] = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE 
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID	FROM 
					(select ISNULL(ct.[key], ct2.[key]) as recordID 
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				join [dbo].[Collections] co1 on co1.collid = qc.collectionID
				where (co1.portalCode & @portalCode) = @portalCode
				  and exists ((select ctf2.facetid from CollectionsToFacets ctf2 where ctf2.collid = qc.collectionID) intersect (select * from @facet))
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(q00.recordID) as ItemCount, 0 as CollCount from
					(select ISNULL(ct.[key], ct2.[key]) as recordID
					  from containsTable([dbo].[records], *, @phrase, @top_n) ct
					  full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q00
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q00.recordID
					join [dbo].[Records] r on q00.recordID = r.recordID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	
  ELSE
	
		IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID)
					order by itemCount DESC
				
		ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID)
					order by itemCount DESC

		ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 1 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = ct.[key] and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID)
					order by itemCount DESC

		ELSE   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
				SELECT rtf.facetID as facetID, count(q1.recordID) as ItemCount, 1 as CollCount
					from (select ISNULL(ct.[key], ct2.[key]) as recordID
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q1
					join [dbo].[Records] r on q1.recordID = r.recordID
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = q1.recordID
					join [dbo].[RecordsToMultipleCollections] rm on rm.recordID = q1.recordID and rm.collid = @collectionID
					where (r.portalCode & @portalCode) = @portalCode 
					  and exists ((select rtf2.facetid from [dbo].[RecordsToFacets] rtf2 where rtf2.recordID = r.recordID) intersect (select * from @facet))				
					group by rtf.facetID)
					order by itemCount DESC

		
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
-- =============================================
CREATE FUNCTION [dbo].[GetFacetsCTQ]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = 'keyword', 
	@top_n int = 10000
)
RETURNS 
	@GetFacetsCTQ TABLE 
(
	-- Add the column definitions for the TABLE variable here
	facetID int,
	itemCount int,
	collCount int
)
AS
BEGIN

	IF ( @queryType = 'title')   
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(ct.[key]) as ItemCount, 0 as CollCount
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[RecordsToFacets] rtf on rtf.recordID = ct.[key]
					group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	ELSE 
		INSERT INTO @GetFacetsCTQ (facetID, itemCount, collCount) (
			select q1.facetID, sum(q1.ItemCount) as itemCount, SUM(q1.CollCount) as CollCount  from (			 
				-- 1. get the facets of collections that match or have items that match the query
			  (select ctf.facetID as facetID, 0 as itemCount, count(qc.collectionID) as CollCount from
				(SELECT distinct(rc.collid) as collectionID	FROM 
					(select ISNULL(ct.[key], ct2.[key]) as recordID 
					from containsTable([dbo].[records], *, @phrase, @top_n) ct
					full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
				union				
				select ct2.[key] as collectionID
					from containsTable([dbo].[Collections], *, @phrase) ct2
				) qc
				join [dbo].[CollectionsToFacets] ctf on ctf.collid = qc.collectionID
				group by ctf.facetID)
				union
				-- 2. get the facets of items that match the query 
				SELECT rtf.facetID as facetID, count(q00.recordID) as ItemCount, 0 as CollCount from
					(select ISNULL(ct.[key], ct2.[key]) as recordID
					  from containsTable([dbo].[records], *, @phrase, @top_n) ct
					  full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q00
				join [dbo].[RecordsToFacets] rtf on rtf.recordID = q00.recordID
				group by rtf.facetID
			) q1
			group by q1.facetID)
			order by itemCount DESC

	RETURN 
END
GO

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
	@portalCode int
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
	@portalCode int = 1,
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
	@portalCode int = 1,
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
	@portalCode int = 1,
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
CREATE FUNCTION [dbo].[collCTQWithPCOnly]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = 'keyword', 
	@top_n int = 10000,
	@portalCode int = 1
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
					where (c1.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
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
					where (c1.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
				
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
					where (c1.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			group by q1.collectionID)
			order by myRankS DESC

	ELSE  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(q0.recordID) as hitsInColl, cast(( count(q0.recordID)*(1000/c1.itemCount) ) as int) as myRank
				FROM 
				(select ISNULL(ct.[key], ct2.[key]) as recordID 
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					where (c1.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
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
CREATE FUNCTION [dbo].[collCTQWith3Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = 'keyword', 
	@top_n int = 10000,
	@portalCode int = 1, 
	@facetIn nvarchar(255),
	@facetIn2 nvarchar(255),
	@facetIn3 nvarchar(255)	
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

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  declare @facet2 facetIDType;
  insert into @facet2 (facetID) (select * from [dbo].[mySplit](@facetIn2));

  declare @facet3 facetIDType;
  insert into @facet3 (facetID) (select * from [dbo].[mySplit](@facetIn3));

	IF ( @queryType = 'title')   
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					join [dbo].[CollectionsToFacets] f3 on rc.collID = f3.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					AND f3.facetID in (select * from @facet3)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet3))
			group by q1.collectionID)
			order by myRankS DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					join [dbo].[CollectionsToFacets] f3 on rc.collID = f3.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					AND f3.facetID in (select * from @facet3)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
				
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet3))
			group by q1.collectionID)
			order by myRankS DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					join [dbo].[CollectionsToFacets] f3 on rc.collID = f3.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					AND f3.facetID in (select * from @facet3)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet3))
			group by q1.collectionID)
			order by myRankS DESC

	ELSE  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], *, @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					join [dbo].[CollectionsToFacets] f3 on rc.collID = f3.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					AND f3.facetID in (select * from @facet3)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet3))
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
CREATE FUNCTION [dbo].[collCTQWith2Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = 'keyword', 
	@top_n int = 10000,
	@portalCode int = 1, 
	@facetIn nvarchar(255),
	@facetIn2 nvarchar(255)	
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

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

  declare @facet2 facetIDType;
  insert into @facet2 (facetID) (select * from [dbo].[mySplit](@facetIn2));


	IF ( @queryType = 'title')   
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			group by q1.collectionID)
			order by myRankS DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
				
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			group by q1.collectionID)
			order by myRankS DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
			group by q1.collectionID)
			order by myRankS DESC

	ELSE  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], *, @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					join [dbo].[CollectionsToFacets] f on rc.collID = f.collid
					join [dbo].[CollectionsToFacets] f2 on rc.collID = f2.collid
					where (r.portalCode & @portalCode) = @portalCode
					AND f.facetID in (select * from @facet)
					AND f2.facetID in (select * from @facet2)
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			  and exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet2))
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
CREATE FUNCTION [dbo].[collCTQWith1Facet]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(255),
	@queryType nvarchar(255) = 'keyword', 
	@top_n int = 10000,
	@portalCode int = 1, 
	@facetIn nvarchar(255)	
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

  declare @facet facetIDType;
  insert into @facet (facetID) (select * from [dbo].[mySplit](@facetIn));

	IF ( @queryType = 'title')   
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [title], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					where (r.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			group by q1.collectionID)
			order by myRankS DESC
			
	ELSE IF ( @queryType = 'creator')
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [creator], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					where (r.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
				
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			group by q1.collectionID)
			order by myRankS DESC

	ELSE IF ( @queryType = 'subject')  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(ct.[key]) as hitsInColl, cast(( count(ct.[key])*(1000/c1.itemCount) ) as int) as myRank
					FROM  containsTable([dbo].[records], [subject], @phrase, @top_n) ct
					join [dbo].[Records] r on ct.[key] = r.recordID
					join [dbo].[RecordsToMultipleCollections] rc on ct.[key] = rc.recordid
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					where (r.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
			group by q1.collectionID)
			order by myRankS DESC

	ELSE  
		INSERT INTO @collCTQ (collID, hitsInColl, ctRank) (
			select q1.collectionID as myCollID, sum(q1.hitsInColl) as myHitsInColl, sum(q1.myRank) as myRankS from
			(	SELECT rc.collid as collectionID, count(q0.recordID) as hitsInColl, cast(( count(q0.recordID)*(1000/c1.itemCount) ) as int) as myRank
				FROM 
				(select ISNULL(ct.[key], ct2.[key]) as recordID 
				from containsTable([dbo].[records], *, @phrase, @top_n) ct
				full outer join containsTable([dbo].[records], [searchXML], @phrase, @top_n) ct2 on ct2.[key] = ct.[key]) q0
					join [dbo].[RecordsToMultipleCollections] rc on q0.recordID = rc.recordid
					join [dbo].[Records] r on q0.recordID = r.recordID
					join [dbo].[Collections] c1 on rc.collID = c1.collid
					where (r.portalCode & @portalCode) = @portalCode
					group by rc.collID, c1.itemCount
				union				
				select c2.collID as collectionID, 0 as hitsInColl, (ct2.[rank] *5) as myRank
					from containsTable([dbo].[Collections], *, @phrase) ct2
					join [dbo].[Collections] c2 on ct2.[key] = c2.collID
					where (c2.portalCode & @portalCode) = @portalCode
			) q1
			where exists ((select facetid from CollectionsToFacets ctf where ctf.collid = q1.collectionID) intersect (select * from @facet))
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
-- Author:		Tim Cole
-- Create date: 18 August 2011
-- Description:	
--	This function returns table of records ID matching a date, subject, title, or type ID (i.e., selected by user from browse list)
--	@browseID (REQUIRED) 
--  @queryType is column_name | (column_list) | *, following supported:
--		date
--		subject
--		type
--		title (default)
-- =============================================
CREATE FUNCTION [dbo].[collBTQWithPCOnly]
(	
	-- Add the parameters for the function here
	@browseID int = 1,
	@queryType nvarchar(255) = '*',
	@portalCode int = 1
 
)
RETURNS 
	@collBrowseTableQuery TABLE 
(
	-- Add the column definitions for the TABLE variable here
	collID int
)
AS
BEGIN
 IF (LEFT(@queryType, 1)='c') 
		BEGIN
		IF @queryType = 'citype'
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollInstType] bt
			join [dbo].[Collections] c on c.collid = bt.collID
			where bt.collInstTypeID = @browseID 
			and (c.portalCode & @portalCode) = @portalCode

		ELSE IF @queryType = 'ciname'
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollInstName] bt
			join [dbo].[Collections] c on c.collid = bt.collID
			where bt.collInstNameID = @browseID 
			and (c.portalCode & @portalCode) = @portalCode

		ELSE IF @queryType = 'cistate'
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollInstState] bt
			join [dbo].[Collections] c on c.collid = bt.collID
			where bt.collInstStateID = @browseID 
			and (c.portalCode & @portalCode) = @portalCode
    
		ELSE    
			INSERT INTO @collBrowseTableQuery(collID) 
			select distinct bt.collID  
			from [dbo].[CollectionsToCollTitle] bt
			join [dbo].[Collections] c on c.collid = bt.collID
			where bt.collTitleID = @browseID 
			and (c.portalCode & @portalCode) = @portalCode
		
		END
  ELSE

	BEGIN
		IF ( @queryType = 'date')   
			INSERT INTO @collBrowseTableQuery(collID)			
			(select r.cid as collID
			from [dbo].[RecordsToDateBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.dateID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  group by r.cid)
				
		ELSE IF ( @queryType = 'type')
			INSERT INTO @collBrowseTableQuery(collID)
			(select r.cid as collID
			from [dbo].[RecordsToTypes] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.typeID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  group by r.cid)

		ELSE IF ( @queryType = 'subject')  
			INSERT INTO @collBrowseTableQuery(collID)
			(select r.cid as collID
			from [dbo].[RecordsToSubjects] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.subjectID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  group by r.cid)

		ELSE   
			INSERT INTO @collBrowseTableQuery(collID)
			(select r.cid as collID
			from [dbo].[RecordsToTitleBrowse] bt
			join [dbo].[Records] r on bt.recordID = r.recordID
			  where bt.titleID = @browseID
			  and (r.portalCode & @portalCode) = @portalCode
			  group by r.cid)
	END
	
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
    ,@p            int    = CAST(@portalCode AS int)

    -- ItemCount
    SELECT @items = COUNT(1) from dbo.Records
     WHERE (portalCode & @p > 0);
    
    -- CollectionCount
    SELECT @colls = COUNT(1) from dbo.Collections
     WHERE (portalCode & @p > 0);
    
    -- InstitutionCount
    --SELECT @repos = COUNT(1) from dbo.Repositories
    select @repos = COUNT( distinct cin.CollInstNameID) 
    from dbo.CollInstNameBrowse cin
    join dbo.CollectionsToCollInstName c2cin on cin.CollInstNameID = c2cin.CollInstNameID
    join dbo.Collections c on c.collID = c2cin.collid
     WHERE (c.portalCode & @p > 0);
    
	-- Prevent extra result sets from interfering with SELECT statements
	SET NOCOUNT ON;

	SELECT @items AS ItemCount, @colls AS CollectionCount, @repos AS InstitutionCount;

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
	@portalCode int = 0
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

		SELECT q2.searchRank, q2.RecordID, q2.CollID, c.title collectionTitle, 
		c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, 
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
			
			SELECT 1 searchRank, r.recordid RecordID, rmc.collid CollID, c.title collectionTitle, 
			c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, 
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
				SELECT rbp.searchRank, rbp.RecordID, rbp.CollID, c.title collectionTitle, 
				c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, 
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
	@portalCode int = 0
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
	@portalCode int = 0
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
CREATE PROCEDURE [dbo].[setupdb_4_Grants]
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
