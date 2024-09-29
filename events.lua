function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:showHotbar()
end

function play(name, index)

    if not data[name].isPlaying and not players[index] then

        data[name].index = index
        data[name].isPlaying = true

        players[index] = name

        numberOfPlayers = numberOfPlayers + 1

        ui.updateTextArea(index, string.format("<a href='event:play_%s'>%s</a>", index, name), nil)
        ui.updateTextArea(0, string.format("<p align='center'><font size='40'>%s / %s players</font></p>", numberOfPlayers, 10), nil)

    elseif data[name].isPlaying and index == data[name].index and players[index] == name then

        data[name].isPlaying = false
        
        players[index] = nil

        numberOfPlayers = numberOfPlayers - 1

        ui.updateTextArea(index, string.format("<a href='event:play_%s'>enter</a>", index), nil)
        ui.updateTextArea(0, string.format("<p align='center'><font size='40'>%s / %s players</font></p>", numberOfPlayers, 10), nil)
        
    end
end

function eventTextAreaCallback(id, name, event)
    
    if event:sub(1, 5) == "play_" then

        play(name, event:sub(6))

        return
    end

    _G[event](name)
end

function eventKeyboard(name, key, down, x, y)

    data[name]:keyboard(key)
end

function eventLoop()

    if currentGameState == gameStates.lobby then

        if numberOfPlayers >= 2 then

            if startTimer == 0 then

                currentGameState = gameStates.dungeon
            else

                startTimer = startTimer - 0.5
            end
        
        else

            startTimer = 10
        end

        ui.updateTextArea(-1, "<p align='center'><font size='40'>" .. math.floor(startTimer) .. "</font></p>", nil)
    end
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end
