if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ProductoVentaHelp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ProductoVentaHelp]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

sp_productoventahelp 1,73,0, 'cart',0,0,'',2

select * from producto where rubti_id7 = 168

*/
create procedure sp_ProductoVentaHelp (
  @@emp_id          int,
  @@us_id           int,
  @@bForAbm         tinyint,
  @@bFilterType     tinyint,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0,
  @@pr_id           int,
  @@filter2          varchar(5000)  = '',
  @@prhc_id         int = 0
)
as
begin

  set nocount on

--/////////////////////////////////////////////////////////////////////////////////////

  declare @filter varchar(255)
  set @filter = @@filter
  exec sp_HelpGetFilter @@bFilterType, @filter out

--/////////////////////////////////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////////////
--
-- CHECK
--
--//////////////////////////////////////////////////////////////////

  if @@check <> 0 begin
  
    select   pr_id,
            pr_nombreventa  as [Nombre],
            pr_codigo       as [Codigo]

    from Producto

    where (pr_nombreventa = @@filter or pr_codigo = @@filter)
      and (activo <> 0 or @@bForAbm <> 0)
      and (pr_id = @@pr_id or @@pr_id=0)
      and pr_sevende <> 0

  end else begin

    if @@prhc_id <> 0 begin

--//////////////////////////////////////////////////////////////////
--
-- SELECT CON FILTRO POR RUBRO
--
--//////////////////////////////////////////////////////////////////
  
      declare @prhc_atributo   tinyint
      declare @prhc_codigo    varchar(255)
    
      select   @prhc_codigo     = prhc_valor_codigo, 
              @prhc_atributo   = prhc_atributo_indice 
  
      from productohelpconfig
      where prhc_id = @@prhc_id

      declare @timeCode datetime
      set @timeCode = getdate()
      exec sp_strStringToTable @timeCode, @prhc_codigo, ','
  
      create table #t_help_rubro (rubti_id int)

      ---------------------------------------------------------------

        if @prhc_atributo = 1
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id1
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  

        else
        if @prhc_atributo = 2
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id2
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 3
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id3
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 4
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id4
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 5
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id5
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 6
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id6
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 7
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id7
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 8
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id8
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 9
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id9
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
        else
        if @prhc_atributo = 10
  
          insert into #t_help_rubro 
  
          select rubti_id
          from RubroTablaItem rubti inner join Rubro rub         on rubti.rubt_id = rub.rubt_id10
                                    inner join TmpStringToTable  on rubti_codigo  = TmpStringToTable.tmpstr2tbl_campo
          where tmpstr2tbl_id =  @timeCode  
  
      ---------------------------------------------------------------

      select top 50
             pr_id,
             pr_nombreventa   as Nombre,
             pr_descripcompra as [Observaciones],
             pr_codigo        as Codigo
      from Producto 
  
      where (pr_codigo like @filter or pr_nombreventa like @filter
              or pr_descripcompra like @filter
              or @@filter = '')
        and (activo <> 0 or @@bForAbm <> 0)
        and pr_sevende <> 0
        and (
                (@prhc_atributo = 1  and rubti_id1  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 2  and rubti_id2  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 3  and rubti_id3  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 4  and rubti_id4  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 5  and rubti_id5  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 6  and rubti_id6  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 7  and rubti_id7  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 8  and rubti_id8  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 9  and rubti_id9  in (select rubti_id from #t_help_rubro))
             or (@prhc_atributo = 10 and rubti_id10 in (select rubti_id from #t_help_rubro))
            )
    
    end else begin

--//////////////////////////////////////////////////////////////////
--
-- SELECT COMUN
--
--//////////////////////////////////////////////////////////////////

      select top 50
             pr_id,
             pr_nombreventa   as Nombre,
             pr_descripcompra as [Observaciones],
             pr_codigo        as Codigo
      from Producto 
  
      where (pr_codigo like @filter or pr_nombreventa like @filter
              or pr_descripcompra like @filter
              or @@filter = '')
        and (activo <> 0 or @@bForAbm <> 0)
        and pr_sevende <> 0

    end

  end    

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

