function love.load()
    --set up initial variables
    catgame = {}
    catgame.game = {}
    catgame.game.hp = 50
    catgame.game.misses = 0
    catgame.game.note1 = {}
    catgame.game.note1.color = "white"
end

function love.update(dt)
end

function love.draw()
end

--custom functions:

function addhp(hp, maxhp)
    catgame.game.hp = catgame.game.hp + hp
    if catgame.game.hp > maxhp then
        catgame.game.hp = maxhp
    end
end