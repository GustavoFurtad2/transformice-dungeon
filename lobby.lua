local players = {}

local function showPlayerList(name)
    
    for i = 1, 10 do
        ui.addTextArea(i, players[i] and players[i] or "<a href='event:play'>enter", name, 0 + (i - 1) * 80, 300, 120, 40, 0xf, 0xf, 1, true)
    end

end
