USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetTypeSearchResults]    Script Date: 07/12/2011 14:31:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/1/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetTypeSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @phrase = '[^a-z]%'
	BEGIN
		SELECT t.typeID, t.typeText 
		FROM [Types] t
		WHERE t.typeText LIKE '[^a-z]' + @phrase
		ORDER BY t.typeText
	END
	ELSE
	BEGIN
		SELECT t.typeID, t.typeText FROM [Types] t
		WHERE t.typeText LIKE @phrase or t.typeText LIKE '[^a-z0-9]' + @phrase
		ORDER BY t.typeText
	END
	
END

GO

