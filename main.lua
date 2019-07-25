--[[
    Secret Century game prototype
    Author:  Stewart Charles
    Version: 2/14/2018
]]

-- Define locals
local cargo = require 'libs/cargo/cargo'
local delta = 0
local level = nil

-- Define globals
assets = cargo.init('assets')
game = cargo.init('game')
tiny = require('libs/tiny-ecs/tiny')
class = require('libs/30log/30log')
Entity = game.entities.entity
beholder = require('libs/beholder/beholder')
DIM = 16
SCALE = 5

local functional = game.utils.functional
Array = functional.Array
Option = functional.Optional

--[[
    Invokes the cleanup function on the current level
    and then switches to the leve supplied by the argument function
]]
function load_level(fn)
    if level then
        level:cleanup()
    end
    level = fn()
end

function love.load()
    defaultfont = assets.DawnLike.GUI.SDS_8x8
    love.window.setMode(1024, 768, { resizable = false, borderless = false })
    love.graphics.setFont(defaultfont(16))
    love.graphics.setDefaultFilter('linear', 'nearest')
    load_level(game.scenes.intro)
end

-- Create filters to categorize systems into either UpdateSystems or DrawSystems
local function drawSystem(_,s) return s.drawSystem end
local function updateSystem(_,s) return not s.drawSystem end

function love.draw()
    tiny.update(level.world, delta, drawSystem)
end

function love.update(dt)
    delta = dt
    tiny.update(level.world, delta, updateSystem)
end

function love.textedited(text, start, length)

end

function love.textinput(t)

end

function love.keypressed(key, scancode, is_repeated)
    beholder.trigger('keypressed', key, scancode, is_repeated)
end

function love.keyreleased(key)
    beholder.trigger('keyreleased', key)
end