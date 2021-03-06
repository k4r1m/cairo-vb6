SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_EncuestaPreguntaItemUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_EncuestaPreguntaItemUpdate]
GO

/*

*/

create Procedure sp_web_EncuestaPreguntaItemUpdate (
     @@ecp_id              int,
    @@ecpi_id             int,
     @@ecpi_texto           varchar(255),
     @@ecpi_llevainfo      tinyint,
    @@ecpi_orden          smallint
)
as

begin

  set nocount on

  if @@ecpi_orden < 0 set @@ecpi_orden = 0

  if @@ecpi_id = 0 begin

    exec SP_DBGetNewId 'EncuestaPreguntaItem', 'ecpi_id', @@ecpi_id out, 0

    insert into EncuestaPreguntaItem (
                              ecpi_id,
                              ecpi_texto,
                              ecpi_llevainfo,
                              ecp_id,
                              ecpi_orden
                            )
                    values  (
                              @@ecpi_id,
                              @@ecpi_texto,
                              @@ecpi_llevainfo,
                              @@ecp_id,
                              @@ecpi_orden
                            )
  end else begin

    update EncuestaPreguntaItem set
                            ecpi_texto        = @@ecpi_texto,
                            ecpi_llevainfo    = @@ecpi_llevainfo,
                            ecp_id             = @@ecp_id,
                            ecpi_orden        = @@ecpi_orden

    where ecpi_id = @@ecpi_id
  end

  select @@ecpi_id

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go