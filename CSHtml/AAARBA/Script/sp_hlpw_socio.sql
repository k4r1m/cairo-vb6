if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_hlpw_socio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_hlpw_socio]
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

 sp_hlpw_socio 1,1,'64',1

sp_web_PadronGet 64,0
sp_web_PadronGet 64,0
*/

create procedure sp_hlpw_socio (
  @@us_id           int,
  @@emp_id          int,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0
)
as
begin
  set nocount on

  if @@check <> 0 begin
  
    select   aabasoc_id, 
            aabasoc_codigo       as codigo,
            aabasoc_apellido + ',' 
            + aabasoc_nombre     as nombre

    from aaba_socio

    where (aabasoc_nombre = @@filter or aabasoc_codigo = @@filter)
          and aabasoc_fechabaja = '19000101'

  end else begin

    select top 50
            aabasoc_id, 
            aabasoc_codigo       as codigo, 
            aabasoc_apellido + ',' 
            + aabasoc_nombre     as nombre, 
            aabasoc_documento   as documento

    from aaba_socio 

    where (      aabasoc_codigo    like   '%'+@@filter+'%' 
            or   aabasoc_nombre    like   '%'+@@filter+'%' 
            or   aabasoc_apellido  like   '%'+@@filter+'%' 
            or  aabasoc_documento like  '%'+@@filter+'%' 
            or @@filter = '')
          and aabasoc_fechabaja = '19000101'

    
  end
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

