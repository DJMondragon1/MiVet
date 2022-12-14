USE [MiVet]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Insert]    Script Date: 10/23/2022 5:37:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Donald Mondragon
-- Create date: 9/22/2022
-- Description: insert into comments table
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Comments_Insert] 
		@Subject nvarchar(50)
		,@Text nvarchar(3000)
		,@ParentId int
		,@EntityTypeId int
		,@EntityId int
		,@CreatedBy int
		,@IsDeleted bit
		,@Id int OUTPUT


as


/*
Declare @Id int = 0

Declare @Subject nvarchar(50) = 'Subject Test'
		,@Text nvarchar(3000) = 'Text Test'
		,@ParentId int = 1
		,@EntityTypeId int = 1
		,@EntityId int = 1
		,@CreatedBy int = 35
		,@IsDeleted bit = 1


Execute [dbo].[Comments_Insert] 
		@Subject
		,@Text
		,@ParentId
		,@EntityTypeId
		,@EntityId
		,@CreatedBy
		,@IsDeleted
		,@Id OUTPUT

Select*
from dbo.Comments




*/

BEGIN

INSERT INTO [dbo].[Comments]
           ([Subject]
           ,[Text]
           ,[ParentId]
           ,[EntityTypeId]
           ,[EntityId]
		   ,[CreatedBy]	
		   ,IsDeleted)
     VALUES
           (@Subject
           ,@Text
           ,@ParentId
           ,@EntityTypeId
           ,@EntityId
		   ,@CreatedBy
		   ,@IsDeleted)

		   Set @Id = SCOPE_IDENTITY();
END


