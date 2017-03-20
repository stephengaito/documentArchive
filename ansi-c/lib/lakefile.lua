-- A Lua Lakefile

local joyLoLshared = c.shared{'joyLoL', src='*', needs='lua'}

default{joyLoLshared}
