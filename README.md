# lua-gear
Inversion of Control implementation in lua

If you know Java spring framework https://spring.io/ , this library is may be for you. The Inversion of Control https://en.wikipedia.org/wiki/Inversion_of_control approach allows you to get rid of Singleton https://en.wikipedia.org/wiki/Singleton_pattern anti-pattern, and more easily manage complex depencencies.

The `gear` library *does not* provide Dependecy Injection https://en.wikipedia.org/wiki/Dependency_injection as there is no reflection in lua.

# Synopsis

## Chicken / egg problem

```lua
local Gear = require "gear"
local gear = Gear.create()
gear:declare("chicken", {"egg"},
  function() return { class = "chicken" } end,
  function(gear, instance, egg) instance.egg = egg end
)
gear:declare("egg", {"chicken"},
  function() return { class = "egg" } end,
  function(gear, instance, chicken) instance.chicken = chicken end
)

local chicken = gear:get("chicken")
print(chiken.class)
print(chiken.egg.class)
local egg = gear:get("egg")
print(egg.class)
print(egg.chiken.class)

```
