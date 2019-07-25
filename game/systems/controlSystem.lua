local ControlSystem = tiny.processingSystem(class 'ControlSystem')

function ControlSystem:init()
    self.filter = tiny.requireAll('controlled', 'velocity')
end

function ControlSystem:process(e,dt)
    for k, _ in pairs(e.controlled.keys_released) do
        e.controlled.keys_pressed[k] = nil
    end
    
    for k, _ in pairs(e.controlled.keys_pressed) do 
        if k == 'left' then
            e.velocity[1] = -1.0
        elseif k == 'right' then
            e.velocity[1] = 1.0
        elseif k == 'up' then
            e.velocity[2] = -1.0
        elseif k == 'down' then
            e.velocity[2] = 1.0
        end
    end
    e.controlled.keys_released = {}
end

return ControlSystem