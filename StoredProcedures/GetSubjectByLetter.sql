USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetSubjectsByLetter]    Script Date: 07/12/2011 14:29:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetSubjectsByLetter] 
	-- Add the parameters for the stored procedure here
	@startsWith nvarchar(75) = 'R'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @Lsw as int 
	set @Lsw = (select LEN(@startsWith));

	With xmlnamespaces('http://purl.org/dc/elements/1.1/' as "dc")
	SELECT distinct (left( CONVERT(nvarchar(4000), [subject].query('/dc:subject/text()[substring(.,1, sql:variable("@Lsw"))=sql:variable("@startsWith")]') ), 75) ) as subjectsByAlpha
	FROM [IMLShhTR_rebuild_copy].[dbo].[Records]
	where
	[subject].exist('/dc:subject/text()[substring(.,1, sql:variable("@Lsw"))=sql:variable("@startsWith")]')=1  
	order by subjectsByAlpha
END

GO

