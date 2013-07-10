USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetItemSearchResults]    Script Date: 07/12/2011 14:28:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/25/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetItemSearchResults] 
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
						FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'item', @browseID) rbp
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
				FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'item', @browseID) rbp
				GROUP BY rbp.RecordID, rbp.CollID
			)
		END

		SELECT q2.searchRank, q2.RecordID, q2.CollID, c.title collectionTitle, 
		c.institution collectionInstitution, c.isAvailableAt_URL collectionURL, 
		r.identifier, r.shortXML
		FROM dbo.Records r INNER JOIN @FacetedRecordCollRankTable q2 
			ON r.recordID = q2.RecordID AND r.cid = q2.CollID
		INNER JOIN Collections c ON q2.CollID = c.collID
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
						FROM RecordsToMultipleCollections rmc
						INNER JOIN RecordsToFacets rf ON rf.recordID = rmc.recordID
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
					FROM RecordsToMultipleCollections rmc
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
				FROM dbo.Records r INNER JOIN dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'item', @browseID) rbp
					ON r.recordID = rbp.RecordID AND r.cid = rbp.CollID		
				INNER JOIN Collections c ON rbp.CollID = c.collID
				ORDER BY rbp.SearchRank, rbp.RecordID
			END
		END
	END
	
END

GO

