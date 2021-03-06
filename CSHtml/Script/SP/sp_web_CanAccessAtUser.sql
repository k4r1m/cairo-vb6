SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_CanAccessAtUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_CanAccessAtUser]
GO

/*

select us_id from usuario where us_nombre = 'sparra'
sp_web_CanAccessAtUser 559,1

*/

create Procedure sp_web_CanAccessAtUser
(
  @@us_id int,
  @@us_id_login int
) 
as
begin

  if @@us_id = @@us_id_login 
    select 1
  else begin

    if exists(select u.us_id from UsuarioDepartamento u inner join Departamento d on u.dpto_id = d.dpto_id
                                                      inner join permiso p on pre_id_asignartareas = pre_id
              where u.us_id = @@us_id 
                and (
                     p.us_id = @@us_id_login
                     or exists (select us_id from UsuarioRol where us_id = @@us_id_login and rol_id = p.rol_id)
                     )
              )
       select 1
    else
      select 0
  end

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

