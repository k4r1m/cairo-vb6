GO
/****** Object:  UserDefinedFunction [dbo].[DateOnly]    Script Date: 03/09/2012 07:55:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateOnly]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[DateOnly]
GO
/****** Object:  UserDefinedFunction [dbo].[Date]    Script Date: 03/09/2012 07:55:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Date]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Date]
GO
/****** Object:  UserDefinedFunction [dbo].[Time]    Script Date: 03/09/2012 07:55:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Time]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Time]
GO
/****** Object:  UserDefinedFunction [dbo].[TimeOnly]    Script Date: 03/09/2012 07:55:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TimeOnly]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[TimeOnly]
GO
/****** Object:  UserDefinedFunction [dbo].[DateTime]    Script Date: 03/09/2012 07:55:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTime]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[DateTime]

GO
/****** Object:  UserDefinedFunction [dbo].[DateOnly]    Script Date: 03/09/2012 07:54:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  function [dbo].[DateOnly](@DateTime DateTime)
-- Returns @DateTime at midnight; i.e., it removes the time portion of a DateTime value.
returns datetime
as
    begin
    return dateadd(dd,0, datediff(dd,0,@DateTime))
    end

GO
/****** Object:  UserDefinedFunction [dbo].[Date]    Script Date: 03/09/2012 07:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Date](@Year int, @Month int, @Day int)
-- returns a datetime value for the specified year, month and day
-- Thank you to Michael Valentine Jones for this formula (see comments).
returns datetime
as
    begin
    return dateadd(month,((@Year-1900)*12)+@Month-1,@Day-1)
    end

GO
/****** Object:  UserDefinedFunction [dbo].[Time]    Script Date: 03/09/2012 07:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Time](@Hour int, @Minute int, @Second int)
-- Returns a datetime value for the specified time at the "base" date (1/1/1900)
-- Many thanks to MVJ for providing this formula (see comments).
returns datetime
as
    begin
    return dateadd(ss,(@Hour*3600)+(@Minute*60)+@Second,0)
    end

GO
/****** Object:  UserDefinedFunction [dbo].[TimeOnly]    Script Date: 03/09/2012 07:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[TimeOnly](@DateTime DateTime)
-- returns only the time portion of a DateTime, at the "base" date (1/1/1900)
-- Thanks, Peso!
returns datetime
as
    begin
    return dateadd(day, -datediff(day, 0, @datetime), @datetime)
    end

GO
/****** Object:  UserDefinedFunction [dbo].[DateTime]    Script Date: 03/09/2012 07:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[DateTime](@Year int, @Month int, @Day int, @Hour int, @Minute int, @Second int)
-- returns a dateTime value for the date and time specified.
returns datetime
as
    begin
    return dbo.Date(@Year,@Month,@Day) + dbo.Time(@Hour, @Minute,@Second)
    end
