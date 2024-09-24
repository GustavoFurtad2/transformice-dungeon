local players = {}

local startTimer

local function showPlayerList(name)
    
    for i = 1, 10 do
        ui.addTextArea(i, players[i] and players[i] or string.format("<a href='event:play_%s'>enter</a>", i), name, 0 + (i - 1) * 80, 300, 60, 25, nil, nil, 1, true)
    end

end
