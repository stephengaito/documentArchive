-- A Lua file

local cuTest = {
  ext     = '.specs',
  obj_ext = '.c',
  compile = '../cuTest/specs2c.lua $(INPUT)'
}

lake.add_group(cuTest)

function cuTest.program(args)
  local argC    = args[1]..'.c'
  local cuTestR = cuTest.group{src='*'}
  target(
    argC,
    cuTestR:get_targets(),
    '../cuTest/specs2all.lua $(TARGET) $(DEPENDS)'
  )
  args.src = cuTestR:get_targets()
  table.insert(args.src, 1, '../cuTest/CuTest.c')
  table.insert(args.src, 1, argC)
  args.incdir = { '../cuTest' }
  return c.program(args)
end

return cuTest