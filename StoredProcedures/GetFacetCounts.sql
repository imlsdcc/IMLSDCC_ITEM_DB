USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetFacetCounts]    Script Date: 07/12/2011 14:27:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/30/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetFacetCounts] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL, 
	@queryType nvarchar(255) = 'keyword', 
	@phraseType nvarchar(255) = 'keyword',
	@collectionID int = NULL, 
	@facets FacetIDType READONLY
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
						FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'facet', NULL) rbp
						GROUP BY rbp.RecordID, rbp.CollID
					) q 
					INNER JOIN RecordsToFacets rf ON rf.recordID = q.RecordID
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
				FROM dbo.RankByPhrase(@phrase, @queryType, @phraseType, 'facet', NULL) rbp
				GROUP BY rbp.RecordID, rbp.CollID
			)
		END

		SELECT f.facetID, f.facetType, f.facetValue, 
			ISNULL(q2.collectionCount, 0) collectionCount, 
			ISNULL(q3.recordCount, 0) recordCount
		FROM Facets f 
		LEFT JOIN (
			SELECT q1.facetID, Count(q1.collID) collectionCount
			FROM (
				-- get all the facets that go with those records
				SELECT DISTINCT rf.facetID, q.collID 
				FROM @FacetedRecordCollTable q
				INNER JOIN RecordsToFacets rf ON rf.recordID = q.recordID
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
				INNER JOIN RecordsToFacets rf ON rf.recordID = q.recordID
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
						FROM RecordsToMultipleCollections rmc
						INNER JOIN RecordsToFacets rf ON rf.recordID = rmc.recordID
						INNER JOIN Facets f ON f.facetID = rf.facetID
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
					FROM RecordsToMultipleCollections rmc
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
				INNER JOIN RecordsToFacets rf ON rf.recordID = q.recordID
				INNER JOIN Facets f ON f.facetID = rf.facetID
			) q1	
			GROUP BY q1.facetID, q1.facetType, q1.facetValue
			ORDER BY facetType, recordCount DESC, collectionCount DESC
		END
	END

END

GO

