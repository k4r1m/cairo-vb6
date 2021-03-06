SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_EncuestaPreguntaItemDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_EncuestaPreguntaItemDelete]
GO

/*
select * from Encuesta
sp_web_EncuestaPreguntaItemDelete 1,10,0

*/

create Procedure sp_web_EncuestaPreguntaItemDelete
(
  @@ecpi_id   int
) 
as

  delete EncuestaRespuesta where ecpi_id = @@ecpi_id
  delete EncuestaPreguntaItem where ecpi_id = @@ecpi_id

go
set quoted_identifier off 
go
set ansi_nulls on 
go

