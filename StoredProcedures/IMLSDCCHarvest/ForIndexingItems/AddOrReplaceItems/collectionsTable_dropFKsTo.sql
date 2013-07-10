--USE [_IMLS_Items]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CollectionsToThumbnails_Collections]') AND parent_object_id = OBJECT_ID(N'[dbo].[CollectionsToThumbnails]'))
ALTER TABLE [dbo].[CollectionsToThumbnails] DROP CONSTRAINT [FK_CollectionsToThumbnails_Collections]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Records_Collections]') AND parent_object_id = OBJECT_ID(N'[dbo].[Records]'))
ALTER TABLE [dbo].[Records] DROP CONSTRAINT [FK_Records_Collections]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RecordsToCollections_Collections]') AND parent_object_id = OBJECT_ID(N'[dbo].[RecordsToCollections]'))
ALTER TABLE [dbo].[RecordsToCollections] DROP CONSTRAINT [FK_RecordsToCollections_Collections]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RecordsToMultipleCollections_Collections]') AND parent_object_id = OBJECT_ID(N'[dbo].[RecordsToMultipleCollections]'))
ALTER TABLE [dbo].[RecordsToMultipleCollections] DROP CONSTRAINT [FK_RecordsToMultipleCollections_Collections]

GO
