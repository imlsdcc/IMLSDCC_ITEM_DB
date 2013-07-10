USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[onetime_LoadFacets]    Script Date: 07/12/2011 14:32:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Winston Jansz
-- Create date: Oct 13, 2010
-- Description:	Populate Facets table with preset data.
-- =============================================
ALTER PROCEDURE [dbo].[onetime_LoadFacets] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('artifact', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('paintings', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('photograph', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('plans', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('postcard', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('stereograph', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('text', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('portrait', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('seascapes', NULL, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('abstract paintings', 2, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('negative', 3, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('photographic print', 3, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('slides', 3, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('floor plans', 4, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('bibliography', 7, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('book', 7, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('periodical', 7, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('film negative', 11, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('glass negative', 11, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [parentFacet], [facetType]) VALUES ('lantern slide', 13, 'Type')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Pre-1800', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1800-1809', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1810-1819', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1820-1829', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1830-1839', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1840-1849', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1850-1859', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1860-1869', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1870-1879', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1880-1889', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1890-1899', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1900-1909', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1910-1919', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1920-1929', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1930-1939', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1940-1949', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1950-1959', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1960-1969', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1970-1979', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1980-1989', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('1990-1999', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('2000-Present', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Early 19th century', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Late 19th century', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('19th century', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Early 20th century', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Late 20th century', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('20th century', 'Date')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Alabama', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Alaska', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Arizona', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Arkansas', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('California', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Colorado', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Connecticut', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Delaware', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Florida', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Georgia', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Hawaii', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Idaho', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Illinois', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Indiana', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Iowa', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Kansas', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Kentucky', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Louisiana', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Maine', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Maryland', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Massachusett', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Michigan', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Minnesota', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Mississippi', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Missouri', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Montana', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Nebraska', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Nevada', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('New Hampshire', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('New Jersey', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('New Mexico', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('New York', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('North Carolina', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('North Dakota', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Ohio', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Oklahoma', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Oregon', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Pennsylvania', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Rhode Island', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('South Carolina', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('South Dakota', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Tennessee', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Texas', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Utah', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Vermont', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Virginia', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Washington', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('West Virginia', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Wisconsin', 'Place')
    INSERT INTO [dbo].[Facets] ([facetValue], [facetType]) VALUES ('Wyoming', 'Place')
END

GO

