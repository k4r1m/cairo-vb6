SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ProfesorDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ProfesorDelete]
GO

/*

sp_ProfesorDelete 7

*/

create procedure sp_ProfesorDelete
(
  @@prof_id   int
)
as
begin
  set nocount on

  declare @prs_id int

  select @prs_id = prs_id from Profesor where prof_id = @@prof_id

  begin transaction

  delete Profesor where prof_id = @@prof_id
  if @@error <> 0 goto ControlError

  delete Persona where prs_id = @prs_id
  if @@error <> 0 goto ControlError

  commit transaction

  return
ControlError:

  raiserror ('Ha ocurrido un error al borrar el Profesor. sp_ProfesorDelete.', 16, 1)
  rollback transaction  


end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

