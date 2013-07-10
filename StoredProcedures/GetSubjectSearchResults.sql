USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetSubjectSearchResults]    Script Date: 07/12/2011 14:30:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/1/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetSubjectSearchResults] 
	-- Add the parameters for the stored procedure here
	@phrase nvarchar(255) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @phrase = '[^a-z]%'
	BEGIN
		SELECT s.subjectID, s.subjectText 
		FROM Subjects s
		WHERE s.subjectText LIKE '[^a-z]' + @phrase
		ORDER BY s.subjectText
	END
	ELSE
	BEGIN
		SELECT s.subjectID, s.subjectText FROM Subjects s
		WHERE s.subjectText LIKE @phrase or s.subjectText LIKE '[^a-z0-9]' + @phrase
		ORDER BY s.subjectText
	END
	
END

GO

