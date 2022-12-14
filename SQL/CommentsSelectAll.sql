USE [MiVet]
GO
/****** Object:  StoredProcedure [dbo].[Comments_SelectAll]    Script Date: 10/23/2022 5:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Donald Mondragon
-- Create date: 9/22/2022
-- Description:	Comments select all 
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Comments_SelectAll]
@PageSize int
,@PageIndex int


as

/*
Declare @PageSize int = 10
,@PageIndex int = 0

EXECUTE dbo.Comments_SelectAll 
@PageSize 
,@PageIndex 

							  select* 
							  from dbo.Comments
							
							  

					

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
	   ,TotalCount = COUNT(1) OVER()


  FROM [dbo].[Comments] as c 
  inner join [dbo].[Users] u on u.Id = c.CreatedBy

	inner join dbo.EntityTypes as et on c.EntityTypeId = et.Id

	ORDER By c.Id

	OFFSET @Offset ROWS 
	FETCH NEXT 10 ROWS ONLY
						

END


