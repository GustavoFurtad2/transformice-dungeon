function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:lobby()
end

function enterArena(name)

    tfm.exec.movePlayer(name, 2980, 40)
end

function leaveArena(name)

    tfm.exec.movePlayer(name, 403, 31929)
end

function eventTextAreaCallback(id, name, event)
    
    -- _GLOBAL[event](name)
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end