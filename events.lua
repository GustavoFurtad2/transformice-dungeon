function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:showHotbar()
end

function eventTextAreaCallback(id, name, event)
    
    _G[event](name)
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end
