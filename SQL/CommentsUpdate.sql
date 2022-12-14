USE [MiVet]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Update]    Script Date: 10/23/2022 5:36:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Donald Mondragon
-- Create date: 9/22/2022
-- Description:	Update comment by Id
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Comments_Update] 
		@Subject nvarchar(50)
		,@Text nvarchar(3000)
		,@ParentId int
		,@EntityTypeId int
		,@EntityId int
		,@CreatedBy int
		,@IsDeleted int
		,@Id int OUTPUT


as


/*
Declare @Id int = 9

Declare @Subject nvarchar(50) = 'Subject Tester'
		,@Text nvarchar(3000) = 'Text Test'
		,@ParentId int = 1
		,@EntityTypeId int = 1
		,@EntityId int = 1
		,@CreatedBy int = 35
		,@IsDeleted int = 1

Select*
from dbo.Comments
Where Id = @Id


Execute [dbo].[Comments_Update] 
		@Subject
		,@Text
		,@ParentId
		,@EntityTypeId
		,@EntityId
		,@CreatedBy
		,@IsDeleted
		,@Id 

Select*
from dbo.Comments
Where Id = @Id




*/

BEGIN

DECLARE @dateNow datetime2 = getutcdate();

UPDATE [dbo].[Comments]
      SET  [Subject] = @Subject
           ,[Text] = @Text
           ,[ParentId] = @ParentId
           ,[EntityTypeId] = @EntityTypeId
           ,[EntityId] = @EntityId
		   ,[CreatedBy] = @CreatedBy
		   ,[IsDeleted] = @IsDeleted

	Where Id = @Id


END
