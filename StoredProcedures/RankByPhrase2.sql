USE [IMLSHarvest_History_TR_Rebuild]
GO
/****** Object:  UserDefinedFunction [dbo].[RankByPhrase2]    Script Date: 08/04/2011 12:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Jennifer Parga
-- Create date: 1/22/2010
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[RankByPhrase2]
(	
	-- Add the parameters for the function here
	@phrase nvarchar(256),
	@queryType nvarchar(256),
	@phraseType nvarchar(256)
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

	IF @phraseType = 'keyword' AND @queryType = 'title' GOTO keyword_title
	IF @phraseType = 'keyword' AND @queryType = 'creator' GOTO keyword_creator
	IF @phraseType = 'keyword' AND @queryType = 'subject' GOTO keyword_subject
	IF @phraseType = 'keyword' AND @queryType = 'keyword' GOTO keyword_keyword
	IF @phraseType = 'browse' AND @queryType = 'title' GOTO browse_title
	IF @phraseType = 'browse' AND @queryType = 'subject' GOTO browse_subject
	IF @phraseType = 'browse' AND @queryType = 'type' GOTO browse_type
	IF @phraseType = 'browse' AND @queryType = 'date' GOTO browse_date

	keyword_title:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [title], @phrase)
		)
		GOTO return_insert;

	keyword_creator:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [creator], @phrase)
		)
		GOTO return_insert;

	keyword_subject:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [subject], @phrase)
		)
		GOTO return_insert;

	keyword_keyword:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT [KEY], [RANK] FROM ContainsTable(dbo.Records, [searchXML], @phrase)
		)
		GOTO return_insert;

	browse_title:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() 
				OVER (ORDER BY CAST (r.title.query('string(/)') AS nvarchar(1000)) DESC) AS [RANK]
			FROM Records r
			WHERE CAST (r.title.query('string(/)') AS nvarchar(1000)) LIKE @phrase
		)
		GOTO return_insert;

	browse_subject:
		WITH xmlnamespaces('http://purl.org/dc/elements/1.1/' as "dc")
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT DISTINCT r.recordID [KEY], ROW_NUMBER()
				OVER (ORDER BY (LEFT( CONVERT(nvarchar(4000), r.[subject].query('/dc:subject/text()[substring(.,1, sql:variable("@phraseLength"))=sql:variable("@phrase")]') ), 75)) DESC) AS [RANK]
			FROM Records r
			WHERE r.[subject].exist('/dc:subject/text()[substring(.,1, sql:variable("@phraseLength"))=sql:variable("@phrase")]')=1
		)
		GOTO return_insert;

	browse_type:
		GOTO return_insert;
	browse_date:
		GOTO return_insert;

	return_insert:
		INSERT INTO @retRankByPhrase (RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN @rankTable rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID
		);

	RETURN;
END

