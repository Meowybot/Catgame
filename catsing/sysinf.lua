local sysinf = {}
sysinf.fps = 0
sysinf.os = love.system.getOS()
sysinf.process = love.system.getProcessorCount()
sysinf.avgdt = love.timer.getAverageDelta()

sysinf.getfps(dt)
    return 1 // dt
end

function sysinf.update(dt)
    sysinf.fps = sysinf.getfps(dt)
    sysinf.avgdt = love.timer.getAverageDelta()
end