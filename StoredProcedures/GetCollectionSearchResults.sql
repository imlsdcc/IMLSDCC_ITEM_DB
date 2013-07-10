USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetCollectionSearchResults]    Script Date: 07/12/2011 14:26:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/25/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetCollectionSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL,
	@queryType nvarchar(255) = 'keyword', 
	@phraseType nvarchar(255) = 'keyword',
	@collectionID int = NULL,
	@browseID int = NULL,
	@facets FacetIDType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
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
						FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'collection', @browseID) rbp
						GROUP BY rbp.RecordID, rbp.CollID
					) q 
					INNER JOIN RecordsToFacets rf ON rf.recordID = q.RecordID
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
				FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'collection', @browseID) rbp
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
			FROM RecordsToMultipleCollections
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
						FROM RecordsToMultipleCollections rmc
						INNER JOIN RecordsToFacets rf ON rf.recordID = rmc.recordID
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
					FROM RecordsToMultipleCollections rmc
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
				FROM RecordsToMultipleCollections
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
					FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'collection', @browseID) rbp
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
					FROM RecordsToMultipleCollections
					GROUP BY collID
				) q4 ON c.collID = q4.collID
				LEFT JOIN dbo.CollectionsToThumbnails ct ON c.collID = ct.collID
				ORDER BY c.title
			END
		END
	END
	
END

GO

