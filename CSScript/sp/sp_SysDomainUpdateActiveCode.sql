if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SysDomainUpdateActiveCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SysDomainUpdateActiveCode]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


-- sp_SysDomainUpdateActiveCode 7
create procedure sp_SysDomainUpdateActiveCode (
  @@pwd varchar(255)
)
as
begin
  set nocount on

  if exists(select * from sistema where si_clave = 'Codigo_Activacion') begin

    update sistema set si_valor = @@pwd where si_clave = 'Codigo_Activacion'

  end else begin

    insert sistema (si_clave,si_valor) values ('Codigo_Activacion',@@pwd)

  end

end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

