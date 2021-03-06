if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_reporteInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_reporteInfo]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
select * from informe where inf_descrip <> ''
sp_reporteInfo 1
*/
create procedure sp_reporteInfo (
  @@rpt_id int
)
as
begin
  set nocount on

  select 
           'Informe:'        +char(9)+char(9)+ inf_nombre           + char(10) + char(13) +
          'Codigo:'          +char(9)+char(9)+'[' + inf_codigo +']' + char(10) + char(13) +
          'Reporte:'        +char(9)+char(9)+ inf_reporte           + char(10) + char(13) +
          'Sp:'              +char(9)+char(9)+ inf_storedprocedure   + char(10) + char(13) +
                            char(10) + char(13) +
          'Descripción: ' + inf_descrip

          as info

  from reporte rpt inner join informe inf on rpt.inf_id = inf.inf_id
  where rpt_id = @@rpt_id

end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

