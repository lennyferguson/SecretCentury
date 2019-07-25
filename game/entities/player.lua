--[[ Creates and returns a player entity ]]
return function(x, y, img_x, img_y)
    return Entity("player")
        :addComponent(game.components.position, x, y)
        :addComponent(game.components.velocity)
        :addComponent(game.components.controlled)
        :addComponent(game.components.sprite, img_x, img_y, DIM, { 
                assets.DawnLike.Characters.Player0, 
                assets.DawnLike.Characters.Player1 })
        :addComponent(game.components.animation)
end