SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CursoGetItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CursoGetItems]
GO

/*

sp_CursoGetItems 2

*/

create procedure sp_CursoGetItems
(
  @@cur_id   int
)
as
begin

  select   curi.*,
          curia.*,
          curc_fecha,
          curc_desde,
          pprof.prs_apellido + ', ' + pprof.prs_nombre   as prof_nombre,
          palum.prs_apellido + ', ' + palum.prs_nombre   as alum_nombre

  from  CursoItem curi left  join Alumno alum           on curi.alum_id = alum.alum_id
                       left  join Persona palum         on alum.prs_id  = palum.prs_id
                       left  join Profesor prof         on curi.prof_id = prof.prof_id
                       left  join Persona pprof         on prof.prs_id  = pprof.prs_id

                       left  join CursoItemAsistencia curia on curi.curi_id = curia.curi_id
                       left  join CursoClase curc           on curia.curc_id = curc.curc_id

  where curi.cur_id = @@cur_id

  order by alum_nombre, curi.alum_id

end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

