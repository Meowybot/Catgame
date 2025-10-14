catsets = {}
catsets.language = "en"
catsets.controls = {}
catsets.controls[1] = "q"
catsets.controls[2] = "p"
--initial settings

function catsets.setlang(lang)
    catsets.language = lang or "en"
    --changes the lanugage
end

function catsets.setcontrol(first, second)
    catsets.controls[1] = first or "q"
    catsets.controls[2] = second or "p"
    --changes the controls
end

function catsets.getlang()
    return catsets.language
    --returns the current language
end

function catsets.getcontrol(num)
    return catsets.controls[num] or "q"
    --returns the current control for the given number
end

return catsets
--returns the table