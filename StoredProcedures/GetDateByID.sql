USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetDateByID]    Script Date: 07/12/2011 14:27:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/3/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetDateByID] 
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

