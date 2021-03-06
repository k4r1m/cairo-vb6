if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EquipoDetalleGetItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EquipoDetalleGetItems]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

  sp_EquipoDetalleGetItems 1,1,1

*/

create procedure sp_EquipoDetalleGetItems (
  @@ed_id          int,
  @@os_id          int,
  @@prns_id        int
)
as
begin

  set nocount on

  select  edi.edi_id,
          edi_nombre,
          edi_orden,
          edi_tipo,
          edi_default,
          edi_sqlstmt,
          edi.ed_id,
          edi.tbl_id,
          oss_id,
          oss_valor,
          os_id,
          prns_id
 
  from EquipoDetalleItem edi left join OrdenServicioSerie oss on     edi.edi_id = oss.edi_id 
                                                              and (     oss.prns_id = @@prns_id 
                                                                    or oss.prns_id is null
                                                                  )
                                                              and (     oss.os_id  = @@os_id
                                                                    or  oss.os_id  is null
                                                                  )
  where 
        edi.ed_id = @@ed_id 
    
  order by edi_orden
  

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

