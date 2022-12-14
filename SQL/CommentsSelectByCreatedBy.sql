USE [MiVet]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Select_ByCreatedBy]    Script Date: 10/23/2022 5:37:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Donald Mondragon
-- Create date: 9/22/2022
-- Description:	Proc to select Id createdBy a user 
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Comments_Select_ByCreatedBy]
@PageSize int
,@PageIndex int
,@UserId int

as

/*
Declare @PageSize int = 10
,@PageIndex int = 0
,@UserId int = 35


Execute [dbo].[Comments_Select_ByCreatedBy] @PageSize
										   ,@PageIndex
										   ,@UserId
							



										   
*/

BEGIN

DECLARE @Offset int = @PageSize * @PageIndex


SELECT  c.[Id]
	    ,et.Id as [EntityTypeId]
		,et.[Name] as EntityType
		,c.[EntityId]
		,c.[Subject]
		,c.[Text]
		,c.[ParentId]
		,c.[DateCreated]
		,c.[DateModified]
		,c.[IsDeleted]
		,u.Id
		,u.FirstName
		,u.LastName
		,u.Mi
		,u.Email
		,u.AvatarUrl
	  ,TotalCount = COUNT(1)OVER()
  FROM [dbo].[Comments] as c inner join [dbo].[Users] as u
					      on c.CreatedBy = u.Id 

						inner join dbo.EntityTypes as et
						on c.EntityTypeId = et.Id
						
	WHERE [c].[CreatedBy] = @UserId
	ORDER BY EntityTypeId

	OFFSET @Offset ROWS 
	FETCH NEXT 10 ROWS ONLY

END


