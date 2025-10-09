function love.load()
    --make game variables
    catgame = {}
    catgame.level = 1
    catgame.score = 0
    catgame.misses = 0
    catgame.gameover = false
    catgame.version = "0.0.1"
    catgame.sfx = {}
    catgame.character = "Programmer"
    catgame.game = {}
    catgame.notes = {}
    catgame.notes.currentcolor = {1, 1, 1}
    catgame.notes.statecurr = "white"
    catgame.characterasset = love.graphics.newImage("assets/" .. catgame.character .. ".png")
end

function love.update(dt)

end

function love.draw()

end

function catgame.game:addMisses(miss)
    catgame.misses = catgame.misses + miss
end

function catgame.game:addScore(points)
    catgame.score = catgame.score + points
end

function catgame.game:loadLevel(lvl)
    catgame.level = lvl
    catgame.gameover = false
    catgame.misses = 0
    catgame.score = 0
end

function catgame.game:triggerGameOver()
    catgame.gameover = true
end

function catgame.game:onMiss()
    catgame.game:addMisses(1)
    if catgame.misses >= 3 then
        catgame.game:triggerGameOver()
    end
end

function catgame.game:onScore()
    catgame.game:addScore(1)
end

function catgame.game:lightnote(color, note)
    catgame.notes.statecurr = color
    if color == "red" then
        catgame.notes.currentcolor = {1, 0, 0}
    elseif color == "green" then
        catgame.notes.currentcolor = {0, 1, 0}
    elseif color == "blue" then
        catgame.notes.currentcolor = {0, 0, 1}
    elseif color == "yellow" then
        catgame.notes.currentcolor = {1, 1, 0}
    end
end