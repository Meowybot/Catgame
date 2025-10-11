catsing = {}
catsing.level = {}
catsing.level.hp = 50
catsing.level.miss = 0
catsing.level.loaded = "level01"

function catsing.level:load(name)
    catsing.level.loaded = name
    state.switch("assets/levels/" .. name)
    --todo add other stuff
end