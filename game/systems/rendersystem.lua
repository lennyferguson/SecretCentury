local RenderSystem = tiny.processingSystem(class 'RenderSystem')

function RenderSystem:init()
    self.drawSystem = true
    self.filter = tiny.requireAll('position', 'sprite')
end

function RenderSystem:process(entity, dt)
    local img, quad = unpack(entity.sprite.img)
    local x, y = unpack(entity.position)
    love.graphics.draw(img, quad, x, y, 0, SCALE)
end

return RenderSystem