USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetRandomCollection]    Script Date: 07/12/2011 14:29:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetRandomCollection] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 c.collID FROM Collections c
	ORDER BY NEWID();
END

GO

