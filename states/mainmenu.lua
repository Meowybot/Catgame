--thisis the main menu state, it will have the following:
--title
--play button
--credits button
--exit button

if package.loaded["catsing/level"] then
    level = nil
    package.loaded["catsing/level"] = false --delete reference to level code
end