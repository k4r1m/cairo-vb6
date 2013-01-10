SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_ArticuloEstadoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_ArticuloEstadoGet]
GO

/*

sp_web_ArticuloEstadoGet 

*/

create procedure sp_web_ArticuloEstadoGet

as
begin

  select 

        warte_id,
        warte_nombre          as Nombre 

  from webArticuloEstado

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

