USE [MiVet]
GO
/****** Object:  StoredProcedure [dbo].[Comments_DeleteById]    Script Date: 10/23/2022 5:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Donald Mondragon
-- Create date: 9/22/2022
-- Description:	Update record IsDeleted from 1 -> 0 in comments table
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER proc [dbo].[Comments_DeleteById]
			@Id int

as

/*
Declare @Id int = 12

Select*
from dbo.Comments
Where Id = @Id

Execute [dbo].[Comments_DeleteById]
@Id 

Select*
from dbo.Comments
Where Id = @Id



*/

BEGIN

DELETE FROM [dbo].[Comments]
		Where Id = @Id;

END
