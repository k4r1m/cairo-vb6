SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Web_UsuarioLogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Web_UsuarioLogin]
GO

/*

sp_Web_UsuarioLogin 0,'administrador','ddd',0

*/

create procedure sp_Web_UsuarioLogin
(
  @@rtn              tinyint out,
  @@us_nombre        varchar(50),
  @@us_clave         varchar(16),
  @@us_id             int out
)
as

  if exists(select * from usuario where us_nombre = @@us_nombre and us_clave = @@us_clave) begin
        set @@rtn  = 1
        select @@us_id = us_id from usuario where us_nombre = @@us_nombre
  end else begin
        set @@rtn   = 0
        set @@us_id = 0
  end

  declare @us_id int
  select @us_id = us_id from usuario where us_nombre = @@us_nombre

  if @us_id is not null begin

    /* select tbl_id,tbl_nombrefisico from tabla where tbl_nombrefisico like '%%'*/
    exec sp_HistoriaUpdate 3, @us_id, @us_id, 3, @@rtn

  end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

