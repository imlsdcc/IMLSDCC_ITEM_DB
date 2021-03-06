USE [IMLSDCC_20110330_Aquifer]
GO
/****** Object:  StoredProcedure [dbo].[CollectionDetails]    Script Date: 07/12/2011 14:24:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/23/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[CollectionDetails] 
	-- Add the parameters for the stored procedure here
	@identifier integer = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.XMLBlob_Display, ct.oaiidentifier1, ct.oaiidentifier2, ct.oaiidentifier3, 
		ct.oaiidentifier4, q.recordCount, c.collID collectionID 
	FROM Collections c 
	LEFT JOIN CollectionsToThumbnails ct ON c.collID = ct.collID
	LEFT JOIN (
		SELECT rc.cid, Count(rc.cid) recordCount 
		FROM Records rc 
		GROUP BY rc.cid
	) q ON c.collID = q.cid
	WHERE c.collID = @identifier;
END
