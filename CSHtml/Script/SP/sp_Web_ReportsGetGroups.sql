SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Web_ReportsGetGroups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Web_ReportsGetGroups]
GO

/*

select * from reporte

sp_Web_ReportsGetGroups 10

*/

create procedure sp_Web_ReportsGetGroups
(
  @@rpt_id           int
) 
as
begin

  declare @inf_id int

  select @inf_id = inf_id from Reporte where rpt_id = @@rpt_id

  select 
        winfg_nombre,
        winfg_pordefecto
  from 
        InformeGroups
  where 
        inf_id = @inf_id

  order by
        winfg_nombre

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

