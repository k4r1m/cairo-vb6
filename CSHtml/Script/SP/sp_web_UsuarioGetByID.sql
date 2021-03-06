SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_UsuarioGetByID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_UsuarioGetByID]
GO

/*

sp_web_UsuarioGetByID 7

*/

create procedure sp_web_UsuarioGetByID
(
  @@us_id              int
)
as
begin

  select 
                us_id, 
                us_nombre, 
                us_clave

  from usuario
  where us_id = @@us_id

end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

