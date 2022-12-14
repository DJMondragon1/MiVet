USE [MiVet]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Select_ByEntityId]    Script Date: 10/23/2022 5:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Donald Mondragon
-- Create date: 9/22/2022
-- Description:	Proc to select EntityType Ids
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Comments_Select_ByEntityId]
@Id int

as

/*
Declare @Id int = 1



Execute [dbo].[Comments_Select_ByEntityId] @Id
							



										   
*/

BEGIN



SELECT c.[Id]
		,et.[Name] as EntityType
      ,c.[Subject]
      ,c.[Text]
      ,c.[ParentId]
      ,c.[EntityTypeId]
      ,c.[EntityId]
	  ,c.[DateCreated]
      ,c.[DateModified]
      ,c.[IsDeleted]
	  ,TotalCount = COUNT(1)OVER()
  FROM [dbo].[Comments] as c 

						inner join dbo.EntityTypes as et
						on c.EntityTypeId = et.Id
						
	WHERE c.EntityTypeId = @Id

END