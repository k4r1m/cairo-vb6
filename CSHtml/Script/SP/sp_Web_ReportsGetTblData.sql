SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Web_ReportsGetTblData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Web_ReportsGetTblData]
GO

/*

select * from reporte

sp_Web_ReportsGetTblData 5

*/

create procedure sp_Web_ReportsGetTblData
(
  @@tbl_id           int
) 
as
begin

  select 
          tbl_nombrefisico, 
          tbl_campoid, 
          tbl_camponombre 
  
  from tabla 
  
  where tbl_id = @@tbl_id
  
end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

