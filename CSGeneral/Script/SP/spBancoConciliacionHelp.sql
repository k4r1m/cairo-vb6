if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_BancoConciliacionHelp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_BancoConciliacionHelp]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

  sp_BancoConciliacionHelp 1,1,1,'sp%',0,0

  sp_BancoConciliacionHelp 1,1,0, '',0,0,'(cuec_id = 4 or cuec_id = 19)and (emp_id = 1 or emp_id is null)'

  select * from usuario where us_nombre like '%ahidal%'

*/
create procedure sp_BancoConciliacionHelp (
  @@emp_id          int,
  @@us_id           int,
  @@bForAbm         tinyint,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0,
  @@bcoc_id          int,
  @@filter2          varchar(5000) = ''
)
as
begin

  set nocount on
  declare @sqlstmt varchar(8000)

  if @@check <> 0 begin

    set @sqlstmt =  'select  bcoc_id,
                            cue_nombre + '' - '' + convert(varchar,bcoc_numero) as Nombre,
                            bcoc_numero       as Codigo
                
                    from BancoConciliacion bcoc inner join Cuenta cue on bcoc.cue_id = cue.cue_id
                
                    where (cue_nombre + '' - '' + convert(varchar,bcoc_numero) = ''' + @@filter + ''' or convert(varchar,bcoc_numero) = ''' + @@filter + ''')
                      and (bcoc_id = '+ convert(varchar,@@bcoc_id) +' or '+ convert(varchar,@@bcoc_id) +'=0)'

  end else begin

    set @sqlstmt =  'select top 50
                            bcoc_id,
                            cue_nombre + '' - '' + convert(varchar,bcoc_numero) as Nombre,
                            bcoc_numero                    as Codigo
                
                      from BancoConciliacion bcoc inner join Cuenta cue on bcoc.cue_id = cue.cue_id
                
                      where (convert(varchar,bcoc_numero) like ''%'+@@filter+'%'' or cue_nombre like ''%'+@@filter+'%'')'

  end

  if @@filter2 <> '' set @sqlstmt = @sqlstmt + ' and ('+@@filter2+')'

  exec (@sqlstmt)

end

GO
