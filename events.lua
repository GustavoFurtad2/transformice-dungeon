function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:showHotbar()
end

function play(name, index)

    if not data[name].isPlaying then

        data[name].isPlaying = true

        players[index] = name
        ui.updateTextArea(index, string.format("<a href='event:play_%s'>%s</a>", index, name), nil)

        startTimer = os.time()

    elseif data[name].isPlaying and players[index] == name then

        data[name].isPlaying = false

        players[index] = nil
        ui.updateTextArea(index, string.format("<a href='event:play_%s'>enter</a>", index), nil)
        
    end
end

function eventTextAreaCallback(id, name, event)
    
    if event:sub(1, 5) == "play_" then

        play(name, event:sub(6))

        return
    end

    _G[event](name)
end

function eventLoop()

    if #players >= 2 then

        if os.time() >= startTimer + 10000 then

            currentGameState = gameStates.dungeon
        end
    
    else

        startTimer = os.time()
    end
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end
