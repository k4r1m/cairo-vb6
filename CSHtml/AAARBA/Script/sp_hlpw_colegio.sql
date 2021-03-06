if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_hlpw_colegio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_hlpw_colegio]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

        select cli_id,
               cli_nombre   as Nombre,
               cli_codigo   as Codigo
        from cliente 
  
        where (exists (select * from EmpresaCliente where cli_id = cliente.cli_id) or 1 = 1)

  update usuario set us_empxdpto = 1
  select * from usuario where us_nombre like 'ayanelli'

 sp_hlpw_colegio 1,1,'',0

*/

create procedure sp_hlpw_colegio (
  @@us_id           int,
  @@emp_id          int,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0
)
as
begin
  set nocount on

  if @@check <> 0 begin
  
    select   colg_id, 
            colg_codigo         as codigo,
            colg_nombre         as nombre

    from aaarbaweb..colegio

    where (colg_nombre = @@filter or colg_codigo = @@filter)

  end else begin

    select top 50 colg_id, 
                  Codigo=colg_codigo, 
                  Nombre=colg_nombre, 
                  Partidos=colg_descrip 
    from aaarbaweb..colegio 

    where (      colg_nombre  like   '%'+@@filter+'%' 
            or   colg_codigo  like   '%'+@@filter+'%' 
            or  colg_descrip like   '%'+@@filter+'%' 
            or @@filter = '')

    
  end
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

