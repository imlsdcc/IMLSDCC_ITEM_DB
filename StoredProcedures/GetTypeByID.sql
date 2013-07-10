USE [IMLSDCC_20110330_Aquifer]
GO

/****** Object:  StoredProcedure [dbo].[GetTypeByID]    Script Date: 07/12/2011 14:31:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jennifer Giordano
-- Create date: 6/3/2010
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[GetTypeByID] 
	-- Add the parameters for the stored procedure here
	@typeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t.typeText FROM [Types] t WHERE t.TypeID = @typeID
END

GO

