USE [IMLSDCC_20110330_Aquifer]
GO
/****** Object:  UserDefinedFunction [dbo].[RankByPhrase]    Script Date: 07/12/2011 14:23:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 1/22/2010
-- Description:	
-- =============================================
ALTER FUNCTION [dbo].[RankByPhrase]
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
	DECLARE @phraseLength AS INT = (SELECT LEN(@phrase));	
	DECLARE @rankTable table ([KEY] int, [RANK] int);

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
		IF @phrase = '[^a-z]%'
			BEGIN
				INSERT INTO @rankTable ([KEY], [RANK]) (
					SELECT r.recordID [KEY], ROW_NUMBER() 
						OVER (ORDER BY r.titleText) AS [RANK]
					FROM Records r
					WHERE r.titleText LIKE '[^a-z]' + @phrase
				)
			END
		ELSE
			BEGIN
				INSERT INTO @rankTable ([KEY], [RANK]) (
					SELECT r.recordID [KEY], ROW_NUMBER() 
						OVER (ORDER BY r.titleText) AS [RANK]
					FROM Records r
					WHERE r.titleText LIKE @phrase or r.titleText LIKE '[^a-z0-9]' + @phrase
				)
			END
		GOTO return_insert;

	browse_subject:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM Records r INNER JOIN RecordsToSubjects rs ON r.recordID = rs.recordID
			WHERE rs.subjectID = @browseID
		)
		GOTO return_insert;

	browse_type:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM Records r INNER JOIN RecordsToTypes rt ON r.recordID = rt.recordID
			WHERE rt.typeID = @browseID
		)
		GOTO return_insert;

	browse_date:
		INSERT INTO @rankTable ([KEY], [RANK]) (
			SELECT r.recordID [KEY], ROW_NUMBER() OVER (ORDER BY r.titleText) AS [RANK]
			FROM Records r INNER JOIN RecordsToFacets rf ON r.recordID = rf.recordID
			WHERE rf.facetID = @browseID
		)
		GOTO return_insert;

	return_insert:
		INSERT INTO @retRankByPhrase (RecordID, CollID, SearchRank) (
			SELECT r.recordid RecordID, rmc.collid CollID, rt.[RANK] SearchRank
			FROM dbo.Records r INNER JOIN @rankTable rt ON r.recordID = rt.[KEY]
			INNER JOIN dbo.RecordsToMultipleCollections rmc ON rmc.recordID = r.recordID
		);
		GOTO return_statement;
		
	return_browse_title_collection_insert:
		INSERT INTO @retRankByPhrase(RecordID, CollID, SearchRank) (
			SELECT DISTINCT NULL RecordID, c.collID CollID, ROW_NUMBER()
				OVER (ORDER BY c.title) SearchRank
			FROM Collections c
			WHERE c.title LIKE @phrase + '%'
		);
		GOTO return_statement;

	return_statement:
		RETURN;
END
