-- include xml.lua 
local Xml = {}
Xml.__index = Xml

function Xml:new()

    local xml = setmetatable(
        {

            mapParameters = {},
            gameElements = {},

            floors = {},
            shamanObjects = {}
        },
    Xml)

    return xml
end

function Xml:build()

    local mapCode = ""

    return [[
        <C>
            <P/>
            <Z>
                <S>
                </S>
                <D>
                </D>
                <O>
                </O>
            </Z>
        </C>
    ]]
end

-- end includes

for i, v in next, {"AutoNewGame", "AutoShaman", "AfkDeath", "PhysicalConsumables"} do
    tfm.exec["disable" .. v]()
end

local lobbyMap = "<C><P MEDATA=';0,1;;;-0;0:::1-'/><Z><S><S T='6' X='400' Y='377' L='800' H='41' P='0,0,0.3,0.2,0,0,0,0'/></S><D><DS X='400' Y='342'/></D><O/><L/></Z></C>"
local dungeonMap = "<C><P L='7200' H='7200' MEDATA=';;;;-0;0:::1-'/><Z><S/><D/><O/><L/></Z></C>"

tfm.exec.newGame(lobbyMap)

ui.setMapName("#dungeon")

local data = {}

local images = {}

local gameStates = {

    lobby = 1,
    dungeon = 2,
}

local minPlayers = 1
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

    for i = 1, 9 do
        ui.addTextArea(i, players[i] and players[i] or string.format("<a href='event:play_%s'>enter</a>", i), name, 40 + (i - 1) * 80, 300, 60, 25, nil, nil, 0.5, true)
    end

end

local spawnPoints = {

    [1] = {x =  400, y =  200},
    [2] = {x = 4400, y =  200},
    [3] = {x = 6800, y =  200},
    [4] = {x =  400, y = 4000},
    [5] = {x = 4400, y = 4000},
    [6] = {x = 6800, y = 4000},
    [7] = {x =  400, y = 6800},
    [8] = {x = 4400, y = 6800},
    [9] = {x = 6800, y = 6800},

}

local function startGame()

    for i = -1, 13 do

        ui.removeTextArea(i, nil)
    end

    currentGameState = gameStates.dungeon

    tfm.exec.newGame(dungeonMap)

    local index = 0

    for name in next, players do

        index = index + 1

        tfm.exec.movePlayer(name, spawnPoints[index].x, spawnPoints[index].y)
    end
end

function genMap()

    
end

local Player = {}
Player.__index = Player

function Player:new(name)

    local player = setmetatable(
        {
            index = 0,

            health = 100,
            maxHealth = 100,

            speed = 5,

            isDead = false,
            isPlaying = false,

            hotbar = {},
            backpack = {items.sword},
        },
    Player)

    player.hotbar[1] = player.backpack[1]

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
        showPlayerList(name)
    end

    return player
end

function Player:killPlayer()

    tfm.exec.killPlayer(name)
    self.isDead = true
end

function Player:setHealth(health)

    self.health = math.min(health, self.maxHealth)
end

function Player:addHealth(health)

    self.health = math.min(self.health + health, self.maxHealth)
end

function Player:subHealth(health)

    self.health = self.health - health

    if self.health <= 0 then
        self:killPlayer()
    end
end

function Player:showHotbar()

    ui.addTextArea(11, self.hotbar[1].name, name, 10, 345, 50, 50, nil, 0xf, 0.5, true)
        
    if self.hotbar[2] then
        ui.addTextArea(12, self.hotbar[2].name, name, 75, 345, 50, 50, nil, 0xf, 0.5, true)
    end
        
    if self.hotbar[3] then
        ui.addTextArea(13, self.hotbar[3].name, name, 140, 345, 50, 50, nil, 0xf, 0.5, true)
    end
end

function Player:keyboard(key, down, x, y)

end

function eventNewPlayer(name)

    data[name] = data[name] or Player:new(name)
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

