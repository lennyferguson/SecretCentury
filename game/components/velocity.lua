return function(dx, dy)
    return "velocity", { Option(dx):orElse(0), Option(dy):orElse(0) }
end