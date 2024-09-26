for i, v in next, {"AutoNewGame", "AutoShaman", "AfkDeath", "PhysicalConsumables"} do
    tfm.exec["disable" .. v]()
end

tfm.exec.newGame "<C><P MEDATA=';0,1;;;-0;0:::1-'/><Z><S><S T='6' X='400' Y='377' L='800' H='41' P='0,0,0.3,0.2,0,0,0,0'/></S><D><DS X='400' Y='342'/></D><O/><L/></Z></C>"

ui.setMapName("#dungeon")

local data = {}

local images = {}

local gameStates = {

    lobby = 1,
    dungeon = 2,
}

local currentGameState = 1

local items = {

    sword = {

        name = "Sword",
        index = 1,

    }
}

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

local function Player(name)

    local instance = {
        
        health     = 100,
        maxHealth  = 100,

        speed      = 5,

        isDead     = false,
        isPlaying  = false,

        backpack   = {
            items.sword
        },

        hotbar     = {}
    }

    instance.hotbar[1] = instance.backpack[1]

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
        showPlayerList(name)
    end

    function instance:showHotbar()

        ui.addTextArea(11, self.hotbar[1].name, name, 10, 345, 50, 50, nil, 0xf, 0.5, true)
        
        if self.hotbar[2] then
            ui.addTextArea(12, self.hotbar[2].name, name, 75, 345, 50, 50, nil, 0xf, 0.5, true)
        end
        if self.hotbar[3] then
            ui.addTextArea(13, self.hotbar[3].name, name, 140, 345, 50, 50, nil, 0xf, 0.5, true)
        end
    end

    function instance:killPlayer()

        tfm.exec.killPlayer(name)
        self.isDead = true
    end

    function instance:setHealth(health)

        self.health = math.min(health, self.maxHealth)
    end

    function instance:addHealth(health)

        self.health = math.min(self.health + health, self.maxHealth)
    end

    function instance:subHealth(health)

        self.health = self.health - health
        if self.health <= 0 then
            self:killPlayer()
        end
    end

    function instance:keyboard(key, down, x, y)

    end

    return instance
end

function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:showHotbar()
end

function play(name, index)

    if not data[name].isPlaying then

        data[name].isPlaying = true

        players[index] = name
        numberOfPlayers = numberOfPlayers + 1

        ui.updateTextArea(index, string.format("<a href='event:play_%s'>%s</a>", index, name), nil)
        ui.updateTextArea(0, string.format("<p align='center'><font size='40'>%s / %s players</font></p>", numberOfPlayers, 10), nil)

    elseif data[name].isPlaying and players[index] == name then

        data[name].isPlaying = false

        table.remove(players, index)
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

