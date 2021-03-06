SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_EncuestaDepartamentoSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_EncuestaDepartamentoSave]
GO

/*
select * from encuestadepartamento
sp_web_EncuestaDepartamentoSave 

*/

create procedure sp_web_EncuestaDepartamentoSave (

  @@ec_id             int,
  @@strIds             varchar(5000)
)
as

begin

  declare @dpto_id    int
  declare @ecdpto_id  int
  declare @timeCode datetime

  set @timeCode = getdate()
  exec sp_strStringToTable @timeCode, @@strIds, ','

  declare c_departamento insensitive cursor for 

        select convert(int,tmpstr2tbl_campo)
        from TmpStringToTable
        where tmpstr2tbl_id = @timeCode

  open c_departamento

  begin transaction

  delete EncuestaDepartamento where ec_id = @@ec_id

  fetch next from c_departamento into @dpto_id
  while @@fetch_status = 0
  begin
    
    exec sp_dbgetnewid 'EncuestaDepartamento', 'ecdpto_id', @ecdpto_id out, 0

    insert into EncuestaDepartamento (ec_id, dpto_id, ecdpto_id) values(@@ec_id, @dpto_id, @ecdpto_id)
    if @@error <> 0 goto ControlError

    fetch next from c_departamento into @dpto_id
  end

  close c_departamento
  deallocate c_departamento

  commit transaction

  return
ControlError:

  raiserror ('Ha ocurrido un error al grabar la encuesta. sp_web_EncuestaDepartamentoSave.', 16, 1)

  if @@trancount > 0 begin
    rollback transaction  
  end

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

