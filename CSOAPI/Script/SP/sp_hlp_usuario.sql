if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_hlp_usuario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_hlp_usuario]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

        select us_id,
               us_nombre   as Nombre
        from Usuario 
  
        where (exists (select * from EmpresaUsuario where us_id = Usuario.us_id) or 1 = 1)

  select * from usuario where us_nombre = 'mamoros'
  select count(*) from persona

 sp_hlp_usuario 557,1,'d'

,-1,1

sp_hlp_usuario 517


*/

create procedure sp_hlp_usuario (
  @@emp_id          int,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0,
  @@us_id_usuario   int = 0,
  @@us_id           int = 0
)
as
begin
  set nocount on

  if @@check <> 0 begin
  
    select   us_id,
            us_nombre        as [Nombre]

    from Usuario 

    where (us_nombre = @@filter)
      and activo <> 0
--      and (exists (select * from EmpresaUsuario where us_id = Usuario.us_id and emp_id = @@emp_id))

  end else begin


      select top 50
             us_id,
             us_nombre   as Nombre,
             IsNull(prs_apellido + ', ' + prs_nombre,' ') as Persona

      from Usuario left join persona on usuario.prs_id = persona.prs_id

      where (
                us_nombre like '%'+@@filter+'%' 
             or prs_apellido like '%'+@@filter+'%' 
             or prs_nombre like '%'+@@filter+'%'
             or @@filter = '' 
            )
--        and (exists (select emp_id from EmpresaUsuario where us_id = Usuario.us_id and emp_id = @@emp_id))
  end    

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

