catsets = {}
catsets.language = "en"
catsets.controls = {}
catsets.controls[1] = "q"
catsets.controls[2] = "p"

function catsets.setlang(lang)
    catsets.language = lang or "en"
end

function catsets.setcontrol(first, second)
    catsets.controls[1] = first or "q"
    catsets.controls[2] = second or "p"
end

function catsets.getlang()
    return catsets.language
end

function catsets.getcontrol(num)
    return catsets.controls[num] or "q"
end

return catsets