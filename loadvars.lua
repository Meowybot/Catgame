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
catsing.level.notecolor = "white"
catsing.level.lastnotehit = true
catsing.settings = {}
catsing.settings.language = "en"
catsing.settings.controls = {}
catsing.settings.controls[1] = "q"
catsing.settings.controls[2] = "p"

function catsing.level.load(name)
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
        catsing.level.counter = catsing.level.counter - catsing.level.secps
        catsing.level.beatcounter = catsing.level.beatcounter + 1
        catsing.level.onstep(catsing.level.beatcounter)
        -- Timer accuracy may vary on devices with inconsistent frame rates or low performance
    end
end

function catsing.level.getsteps()
    return catsing.level.beatcounter
end

function catsing.level.lightnote(number, color)
    if catsing.level.lastnotehit then
        catsing.level.hp = catsing.level.hp + 1
        if color == not "white" then
            catsing.level.lastnotehit = true
        else
            catsing.level.lastnotehit = false
        end
    else
        catsing.level.hp = catsing.level.hp - 1
        catsing.level.miss = catsing.level.miss + 1
    end
end

function catsing.settings.setlang(lang)
    catsing.settings.language = lang or "en"
end

function catsing.settings.setcontrol(first, second)
    catsing.settings.controls[1] = first or "q"
    catsing.settings.controls[2] = second or "p"
end

function catsing.settings.getlang()
    return catsing.settings.language
end

function catsing.settings.getcontrol(num)
    return catsing.settings.controls[num]
end

return catsing