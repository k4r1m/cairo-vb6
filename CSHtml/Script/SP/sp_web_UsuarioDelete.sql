SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_UsuarioDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_UsuarioDelete]
GO

/*

sp_web_UsuarioDelete 7

*/

create Procedure sp_web_UsuarioDelete
(
  @@us_id     int,
  @@rtn       int out
) 
as

  delete usuario where us_id = @@us_id and us_externo <> 0

  set @@rtn = 1
go
set quoted_identifier off 
go
set ansi_nulls on 
go

