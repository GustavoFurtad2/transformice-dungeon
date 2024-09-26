local players = {}
local numberOfPlayers = 0

local startTimer = 10

local function showPlayerList(name)
    
    ui.addTextArea(0, string.format("<p align='center'><font size='40'>%s / %s players</font></p>", numberOfPlayers, 10), name, 0, 50, 800, 50, nil, nil, 0.5, true)

    ui.addTextArea(-1, "<p align='center'><font size='40'>" .. startTimer.. "</font></p>", name, 0, 150, 800, 50, nil, nil, 2, true)

    for i = 1, 10 do
        ui.addTextArea(i, players[i] and players[i] or string.format("<a href='event:play_%s'>enter</a>", i), name, 0 + (i - 1) * 80, 300, 60, 25, nil, nil, 0.5, true)
    end

end
