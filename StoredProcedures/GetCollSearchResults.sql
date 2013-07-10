USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetCollSearchResults]    Script Date: 07/12/2011 14:26:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/1/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetCollSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @phrase = '[^a-z]%'
	BEGIN
		SELECT c.collID, c.title collText
		FROM Collections c
		WHERE c.title LIKE '[^a-z]' + @phrase
		ORDER BY c.title
	END
	ELSE
	BEGIN
		SELECT c.collID, c.title collText FROM Collections c
		WHERE c.title LIKE @phrase or c.title LIKE '[^a-z0-9]' + @phrase
		ORDER BY c.title
	END
	
END

GO

