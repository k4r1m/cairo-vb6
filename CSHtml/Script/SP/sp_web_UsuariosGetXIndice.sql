SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_UsuariosGetXIndice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_UsuariosGetXIndice]
GO

/*

select * from departamento

sp_web_UsuariosGetXIndice '',1,0

*/

create procedure sp_web_UsuariosGetXIndice
(
  @@us_nombre            varchar(100),
  @@dpto_id              int,
  @@us_id                int
)
as
begin

  set nocount on

  /* select tbl_id,tbl_nombrefisico from tabla where tbl_nombrefisico like '%%'*/
  exec sp_HistoriaUpdate 3, 0, @@us_id, 2

  set @@dpto_id = IsNull(@@dpto_id,0)

  if @@us_nombre is null begin
    set @@us_nombre    = ''
  end

  create table #webDpto (
                          dpto_id      int,
                          dpto_nombre1 varchar(255),
                          dpto_nombre2 varchar(255),
                          dpto_nombre3 varchar(255),
                          dpto_nombre4 varchar(255),
                          dpto_nombre5 varchar(255),
                          dpto_nombre6 varchar(255),
                          dpto_nombre7 varchar(255),
                          dpto_nombre8 varchar(255),
                          dpto_nombre9 varchar(255),
                          dpto_nombre10 varchar(255),
                          dpto_nombre11 varchar(255),
                          dpto_nombre12 varchar(255),
                          dpto_nombre13 varchar(255),
                          dpto_nombre14 varchar(255),
                          dpto_nombre15 varchar(255)
                        )

  

  if @@dpto_id <> 0 begin
                       insert into #webDpto (dpto_id,dpto_nombre1) 
                                                                    select dpto_id, dpto_nombre 
                                                                    from Departamento 
                                                                    where dpto_id = @@dpto_id
                       exec  sp_web_createDpto @@dpto_id,2

                       update #webDpto set dpto_nombre1 = dpto_nombre from Departamento d where d.dpto_id = @@dpto_id
  end
  else                 exec  sp_web_createDpto null,1

  select 
                u.us_id, 
                dpto_nombre,
                dpto_nombre1,
                dpto_nombre2,
                dpto_nombre3,
                dpto_nombre4,
                dpto_nombre5,
                dpto_nombre6,
                dpto_nombre7,
                dpto_nombre8,
                dpto_nombre9,
                dpto_nombre10,
                dpto_nombre11,
                dpto_nombre12,
                dpto_nombre13,
                dpto_nombre14,
                dpto_nombre15,
                us_nombre,
                prs_apellido,
                prs_nombre,
                prs_interno,
                prs_telTrab,
                prs_telCasa,
                prs_celular,
                prs_email,
                prs_cargo


  from Usuario u inner join Persona p              on u.prs_id   = p.prs_id
                 inner join Departamento d         on p.dpto_id  = d.dpto_id
                 inner join #webDpto w             on p.dpto_id  = w.dpto_id
   where 
           (prs_apellido like @@us_nombre   or @@us_nombre = '' or (prs_nombre like @@us_nombre and len(@@us_nombre) > 3))
      and u.activo <> 0

  order by 
                dpto_nombre1,
                dpto_nombre2,
                dpto_nombre3,
                dpto_nombre4,
                dpto_nombre5,
                dpto_nombre6,
                dpto_nombre7,
                dpto_nombre8,
                dpto_nombre9,
                dpto_nombre10,
                dpto_nombre11,
                dpto_nombre12,
                dpto_nombre13,
                dpto_nombre14,
                dpto_nombre15,
                prs_apellido,prs_nombre
end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

