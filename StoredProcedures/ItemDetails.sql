USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[ItemDetails]    Script Date: 07/12/2011 14:31:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Parga
-- Create date: 3/23/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[ItemDetails] 
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

