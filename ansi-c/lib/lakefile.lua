-- A Lua Lakefile for joyLoL/ansi-c/lib

-- fix annoying error message about the use of 'u'
-- the following line has been modified from lake
--
c.lib = '$(AR) rc $(TARGET) $(DEPENDS) && ranlib $(TARGET)'

local joyLoLstatic = c.library{'joyLoL', src='*'}

default{joyLoLstatic}
