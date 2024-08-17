function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:lobby()

end

function duelSelector(name)

    ui.removeTextArea(3, name)
    ui.removeTextArea(4, name)

    local links = "\n"

    for playerName, player in next, data do

        if player.inArena and not player.inDuelList then

            links = links .. "<a href='event:duel_" .. playerName .. "'>" .. playerName .. "</a>\n"
        end
    end

    ui.addTextArea(5, "<p align='center'>" .. links .. "</p></a>", name, 200, 50, 400, 300, 0xf, 0xf, 1, true)
    ui.addTextArea(6, "<a href='event:closeDuelSelector'><p align='center'>Close</p></a>", name, 520, 320, 80, 40, 0xf, 0xf, 2, true)

end

function closeDuelSelector(name)

    ui.removeTextArea(5, name)
    ui.removeTextArea(6, name)

    ui.addTextArea(3, "<a href='event:leaveArena'><p align='center'>Leave</p></a>", name, 360, 30, 80, 20, 0xf, 0xf, 1, true)
    ui.addTextArea(4, "<a href='event:duelSelector'><p align='center'>Duel</p></a>", name, 715, 30, 80, 20, 0xf, 0xf, 1, true)

end

function enterArena(name)

    data[name].inArena = true
    tfm.exec.movePlayer(name, 2980, 40)
    ui.addTextArea(3, "<a href='event:leaveArena'><p align='center'>Leave</p></a>", name, 360, 30, 80, 20, 0xf, 0xf, 1, true)

    ui.addTextArea(4, "<a href='event:duelSelector'><p align='center'>Duel</p></a>", name, 715, 30, 80, 20, 0xf, 0xf, 1, true)

end

function leaveArena(name)

    data[name].inArena = false
    tfm.exec.movePlayer(name, 403, 31929)

    ui.removeTextArea(3, name)
    ui.removeTextArea(4, name)

end

function duelRequest(player1, player2)

    if data[player2].inDuelList then

        ui.addTextArea(7, "<p align='center'><font size='24'>" .. player2 .. " is in waiting list\n <a href='event:closeDuelRequestError'>Close</a></font></p></a>", name, 200, 150, 400, 150, 0xf, 0xf, 1, true)
    end
end

function closeDuelRequestError(name)

    ui.removeTextArea(7, name)
end

function eventTextAreaCallback(id, name, event)
    
    if event:sub(1,5) ~= "duel_" then
        _G[event](name)
        return
    end

    closeDuelSelector(name)
    duelRequest(name, event:sub(6))
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end
