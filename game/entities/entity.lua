--[[
    Constructs an entity table that supports a fluent interface for
    appending components to the entity with an argument function and
    a variable number of arguments that areturns a key, value pair
    of the components name and the components data as the value.
]]
return function(name) 
    local Entity = { name = name }

    function Entity:addComponent(fn, ...)
        local component, val = fn(unpack({...}))
        self[component] = val
        return self
    end

    return Entity
end