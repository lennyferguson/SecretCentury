local MovementSystem = tiny.processingSystem(class 'MovementSystem')
local MOVE_AMT = 250.0

function MovementSystem:init()
    self.filter = tiny.requireAll('position','velocity')
end

function MovementSystem:process(e,dt)
    local x, y = unpack(e.position)
    local dx, dy = unpack(e.velocity)
    local AMT = MOVE_AMT
    if love.keyboard.isDown('lshift') then 
        AMT =  MOVE_AMT * 2
    end
    e.position = { x + dx * AMT * dt , y + dy * AMT * dt }
    e.velocity = { 0 , 0 }
end

return MovementSystem