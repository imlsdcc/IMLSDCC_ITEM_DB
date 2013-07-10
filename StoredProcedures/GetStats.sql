USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetStats]    Script Date: 07/12/2011 14:29:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 4/20/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetStats] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ItemCount, CollectionCount, InstitutionCount from dbo.Stats;
END

GO

