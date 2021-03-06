SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_AlumnoUnir]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_AlumnoUnir]
GO

/*

sp_AlumnoUnir 7

*/

create procedure sp_AlumnoUnir
(
  @@alum_id   int,

  @@alum_id1  int,
  @@alum_id2  int=0,
  @@alum_id3  int=0,
  @@alum_id4  int=0,
  @@alum_id5  int=0,
  @@alum_id6  int=0,
  @@alum_id7  int=0,
  @@alum_id8  int=0,
  @@alum_id9  int=0,
  @@alum_id10  int=0
)
as
begin

  declare @cli_id int

  select @cli_id = prs.cli_id
  from Persona prs inner join Alumno alum on prs.prs_id = alum.prs_id
  where alum_id = @@alum_id 

  if @cli_id is not null begin

    declare c_facturas insensitive cursor for 
      select fv_id 
      from FacturaVenta
      where cli_id in (
                          select prs.cli_id 
                          from Persona prs inner join Alumno alum on prs.prs_id = alum.prs_id
                          where alum_id in (@@alum_id1,
                                            @@alum_id2,
                                            @@alum_id3,
                                            @@alum_id4,
                                            @@alum_id5,
                                            @@alum_id6,
                                            @@alum_id7,
                                            @@alum_id8,
                                            @@alum_id9,
                                            @@alum_id10)
                        )

    open c_facturas

    declare @fv_id int

    fetch next from c_facturas into @fv_id
    while @@fetch_status = 0
    begin

      update FacturaVenta set cli_id = @cli_id where fv_id = @fv_id

      exec sp_DocFacturaVentaSetCredito @fv_id

      fetch next from c_facturas into @fv_id
    end
    close c_facturas
    deallocate c_facturas
  
  end

  update CursoItem set alum_id = @@alum_id 
  where alum_id in (@@alum_id1,
                    @@alum_id2,
                    @@alum_id3,
                    @@alum_id4,
                    @@alum_id5,
                    @@alum_id6,
                    @@alum_id7,
                    @@alum_id8,
                    @@alum_id9,
                    @@alum_id10)

  delete Persona 
  where prs_id in (select prs_id 
                   from Alumno 
                   where alum_id in ( @@alum_id1,
                                      @@alum_id2,
                                      @@alum_id3,
                                      @@alum_id4,
                                      @@alum_id5,
                                      @@alum_id6,
                                      @@alum_id7,
                                      @@alum_id8,
                                      @@alum_id9,
                                      @@alum_id10
                                    )
                  )
  
  delete Alumno 
  where alum_id in (  @@alum_id1,
                      @@alum_id2,
                      @@alum_id3,
                      @@alum_id4,
                      @@alum_id5,
                      @@alum_id6,
                      @@alum_id7,
                      @@alum_id8,
                      @@alum_id9,
                      @@alum_id10
                    )

end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

