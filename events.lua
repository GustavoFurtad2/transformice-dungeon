function eventNewPlayer(name)

    data[name] = data[name] or Player:new(name)

    data[name]:setLangPath()
    data[name]:showHotbar()

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
    end
    
    ui.setMapName("#dungeon")
end

function eventPlayerLeft(name)

    if currentGameState == gameStates.lobby and data[name].isPlaying then

        data[name].isPlaying = false
        
        players[data[name].index] = nil

        numberOfPlayers = numberOfPlayers - 1

        ui.updateTextArea(data[name].index, string.format("<a href='event:play_%s'>enter</a>", data[name].index), nil)
        ui.updateTextArea(0, string.format("<p align='center'><font size='40'>%s / %s players</font></p>", numberOfPlayers, 10), nil)
                
    end
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

function help(name)

    ui.addTextArea(20, data[name].langPath.helpText, name, 200, 50, 400, 250, nil, 0xf, 0.5, true)
    ui.addTextArea(21, "<a href='event:closeHelp'><R>X</R>", name, 615, 50, 20, 20, nil, 0xf, 0.5, true)

end

function closeHelp(name)
    
    ui.removeTextArea(21, name)

    ui.addTextArea(20, string.format("<a href='event:help'>%s</a>", data[name].langPath.help), name, 760, 120, 35, 20, nil, 0xf, 0.5, true)

end

function eventTextAreaCallback(id, name, event)
    
    if _G[event] then

        _G[event](name)
        return
    end

    play(name, event:sub(6))

end

function eventKeyboard(name, key, x, y)

    data[name]:keyboard(key, false, x, y)
end

function eventLoop()

    if currentGameState == gameStates.lobby then

        if numberOfPlayers >= minPlayers then

            if startTimer == 0 then

                startGame()
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
