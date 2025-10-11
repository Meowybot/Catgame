catsing = {}
catsing.level = {}
catsing.level.hp = 50
catsing.level.miss = 0
catsing.level.loaded = "level00"
catsing.level.bpm = 120
catsing.level.bpsec = catsing.level.bpm / 60
catsing.level.spb = 4
catsing.level.secps = catsing.level.bpsec / catsing.level.spb
catsing.level.beatcounter = 0
catsing.level.counter = 0

function catsing.level:load(name)
    catsing.level.loaded = name or "level00"
    state.switch("assets/levels/" .. catsing.level.loaded .. "/chart")
end

function catsing.level.onstep(step)
    --empty function for levels
end

function catsing.level.onevent(name, type)
    --empty function for levels
end

function catsing.level.setsteps(dt)
    catsing.level.counter = catsing.level.counter + dt
    if catsing.level.counter >= catsing.level.secps then
        catsing.level.counter = 0
        catsing.level.beatcounter = catsing.level.beatcounter + 1
        catsing.level.onstep(catsing.level.beatcounter)
        --probably doesnt work on some devices
    end
end