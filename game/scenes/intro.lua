--[[]]
return function()
    local tbl = {}
    tbl.player = game.entities.player(100,100,4,0)
    
    local pressedObserver = beholder.observe('keypressed', function(k,s,i) 
        tbl.player.controlled.keys_pressed[k] = true
    end)

    local releasedObserver = beholder.observe('keyreleased', function(k) 
        tbl.player.controlled.keys_released[k] = true
    end)

    tbl.world = tiny.world(
        game.systems.animationSystem(),
        game.systems.rendersystem(),
        game.systems.controlSystem(),
        game.systems.movementSystem(),
        tbl.player)

    function tbl:cleanup()
        beholder.stopObserving(pressedObserver)
        beholder.stopObserving(releasedObserver)
    end

    return tbl
end