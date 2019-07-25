return function(x, y, dim, sprites)
    local imgs = {}
    for i = 1, #sprites do 
        imgs[i] = {
            sprites[i],
            love.graphics.newQuad(
                x * dim, 
                y * dim, 
                dim, 
                dim, 
                sprites[i]:getDimensions())
        }
    end
    return "sprite", 
    {
        img = imgs[1],
        imgs = imgs
    }
end