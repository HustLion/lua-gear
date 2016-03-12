#!/usr/bin/env lua

require 'Test.More'
local Gear = require "gear"

local declarator = function()
  local g = Gear.create()
  g:declare("chicken", {"egg"},
    function() return { class = "chicken" } end,
    function(g, instance) instance.egg = g:get('egg') end
  )
  g:declare("egg", {"chicken"},
    function() return { class = "egg" } end,
    function(g, instance) instance.chicken = g:get('chicken') end
  )
  return g
end
subtest("via chicken", function()
  local g = declarator()
  local chicken = g:get("chicken")
  ok(chicken)
  is(chicken.class, "chicken")
  ok(chicken.egg)
  is(chicken.egg.class, "egg")
  is(chicken.egg.chicken, chicken)
end)
subtest("via egg", function()
  local g = declarator()
  local egg = g:get("egg")
  ok(egg)
  is(egg.class, "egg")
  ok(egg.chicken)
  is(egg.chicken.class, "chicken")
  is(egg.chicken.egg, egg)
end)

done_testing()
