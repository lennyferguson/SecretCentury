local functional = {}

--[[
    Optional type
]]
functional.Optional = function(val)
    local optional = {}
    optional.val = val
    
    function optional:ifPresent(fn)
        if self.val then
            fn(self.val)
        end
        return self
    end

    function optional:isPresent()
        return self.val ~= nil
    end

    function optional:map(fn)
        if self.val then
            return functional.Optional(fn(self.val))
        end
        return functional.Optional(nil)
    end

    function optional:orElse(val)
        if self.val then
            return self.val
        else 
            return val
        end
    end

    function optional:get()
        return self.val 
    end

    return optional
end

local function getargs(index, ...)
    local arr = {...}
    local ans = {}
    for i, v in ipairs(arr) do
        ans[i] = v[index]
    end
    return table.unpack(ans)
end

--[[
    Functional interface for an array
    Array is functionally immutable
]]
functional.Array = function(...)
    local array = {}
    array.data = {...}
    setmetatable(array, {__index = array.data})

    function array:map(fn, ...)
        local ans = {}
        for i, v in ipairs(self.data) do 
            ans[i] = fn(v, getargs(i, ...))
        end
        return functional.Array(table.unpack(ans))
    end

    function array:fold(fn, carry, ...)
        for i, v in ipairs(self.data) do
            carry = fn(carry, v, getargs(i, ...))
        end
        return carry
    end

    function array:filter(fn, ...)
        local ans = {}
        for i, v in ipairs(self.data) do 
            local test = fn(v, getargs(i, ...))
            if test then
                table.insert(ans, v)
            end
        end
        return functional.Array(table.unpack(ans))
    end


    function array:forEach(fn, ...)
        self:map(fn, ...)
    end

    function array:toTable()
        return self.data
    end

    function array:len()
        return #self.data
    end

    function array:first()
        return self[1]
    end

    function array:rest()
        return self:subArray(2, self:len()) 
    end

    function array:subArray(a,b)
        local ans = {}
        for i = a, b do 
            table.insert(ans, self.data[i])
        end
        return functional.Array(table.unpack(ans))
    end

    function array:toString()
        return self:fold(function(a,v) 
            if a ~= '' then
                a = a .. ' '
            end
            return a .. v .. ' ' end, 
            '')
    end

    function array:print()
        print(self:toString())
    end

    function array:unpack()
        return self:first(), self:rest()
    end

    function array:cons(val)
        return functional.Array(val, table.unpack(self.data))
    end

    return array
end

return functional