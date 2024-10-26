for i, v in next, {"AutoNewGame", "AutoShaman", "AfkDeath", "PhysicalConsumables"} do
    tfm.exec["disable" .. v]()
end

local lobbyMap = "<C><P MEDATA=';0,1;;;-0;0:::1-'/><Z><S><S T='6' X='400' Y='377' L='800' H='41' P='0,0,0.3,0.2,0,0,0,0'/></S><D><DS X='400' Y='342'/></D><O/><L/></Z></C>"

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

local texts = {

    br = {

        help = "Ajuda"
    },

    en = {

        help = "Help"
    }
}

local items = {

    sword = {

        name = "Sword",
        index = 1,

    }
}

local Xml = {}
Xml.__index = Xml

function Xml:new()

    local xml = setmetatable(
        {

            mapParameters = {

                width  = 800,
                height = 400 
            },

            gameElements = {},

            floors = {},
            decorations = {},
            shamanObjects = {},

            holes = {},
            cheeses = {},

            playerSpawnX = 400,
            playerSpawnY = 200,

            shamanSpawnX,
            shamanSpawnY,

            shaman2SpawnX,
            shaman2SpawnY
        },
    Xml)

    return xml
end

function Xml:addFloor(type, x, y, width, height, friction, restitution)

    table.insert(self.floors, {

        type = type,
        
        x = x,
        y = y,

        width = width,
        height = height,
        
        friction = friction,
        restitution = restitution

    })
end

function Xml:addDecoration(x, y, type, foreground, reverse, reverseRandom)

    table.insert(self.decorations, {
        
        type = type,
        
        x = x, 
        y = y,
    
        foreground = tostring(foreground == true and 1 or 0),
        reverse = tostring(reverseRandom or (reverse == true and 1 or 0)),
    
    })
end

function Xml:setMapSize(w, h)

    self.mapParameters.width, self.mapParameters.height = w, h
end

function Xml:setPlayerSpawn(x, y)

    self.playerSpawnX, self.playerSpawnY = x, y
end

function Xml:setHoles(...)

    local holes = {...}

    if #holes % 2 == 0 then

        for i = 1, #holes, 2 do

            table.insert(self.holes, {x = holes[i], y = holes[i + 1]})
        end

    end
end

function Xml:setCheeses(...)

    local cheeses = {...}

    if #cheeses % 2 == 0 then

        for i = 1, #cheeses, 2 do

            table.insert(self.cheeses, {x = cheeses[i], y = cheeses[i + 1]})
        end
        
    end
end

function Xml:build()

    local floors, holes, cheeses, decorations = "", "", "", ""

    for _, floor in next, self.floors do

        floors = floors .. string.format([[<S T="%s" X="%s" Y="%s" L="%s" H="%s" P="0,0,%s,%s,0,0,0,0"/>]], floor.type, floor.x, floor.x, floor.width, floor.height, floor.friction, floor.restitution)
    end

    for _, hole in next, self.holes do

        holes = holes .. string.format([[<T X="%s" Y="%s"/>]], hole.x, hole.y)
    end

    for _, cheese in next, self.cheeses do

        cheeses = cheeses .. string.format([[<F X="%s" Y="%s"/>]], cheese.x, cheese.y)
    end

    for _, decoration in next, self.decorations do

        decorations = decorations .. string.format([[<P X="%s" Y="%s" T="%s" P="%s,%s"/>]], decoration.x, decoration.y, decoration.type, decoration.foreground, decoration.reverse)
    end

    local shamanSpawn = self.shamanSpawnX and string.format([[<DC X="%s" Y="%s"/>]], self.shamanSpawnX, self.shamanSpawnY) or ""
    local shaman2Spawn = self.shaman2SpawnX and string.format([[<DC2 X="%s" Y="%s"/>]], self.shaman2SpawnX, self.shaman2SpawnY) or ""

    return string.format([[<C><P L="%s" H="%s"/><Z><S>%s</S><D><DS X="%s" Y="%s"/>%s%s%s%s%s</D><O></O></Z></C>]], self.mapParameters.width, self.mapParameters.height, floors, self.playerSpawnX, self.playerSpawnY, shamanSpawn, shaman2Spawn, holes, cheeses, decorations)
end

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

    local map = Xml:new()

    map:setMapSize(32000, 32000)
    
    map:addFloor(0, 300, 250, 400, 50, 0.3, 0.2)

    map:setPlayerSpawn(100, 10)

    tfm.exec.newGame(map:build())

    ui.setMapName("#dungeon")

    local index = 0

    for name in next, players do

        index = index + 1

        tfm.exec.movePlayer(name, spawnPoints[index].x, spawnPoints[index].y)
    end
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

function Player:setLangPath(name)

    self.langPath = texts[tfm.get.room.community] or texts.en
end

function Player:showHotbar(name)

    ui.addTextArea(11, self.hotbar[1].name, name, 10, 345, 50, 50, nil, 0xf, 0.5, true)
        
    if self.hotbar[2] then
        ui.addTextArea(12, self.hotbar[2].name, name, 75, 345, 50, 50, nil, 0xf, 0.5, true)
    end
        
    if self.hotbar[3] then
        ui.addTextArea(13, self.hotbar[3].name, name, 140, 345, 50, 50, nil, 0xf, 0.5, true)
    end

    ui.addTextArea(14, string.format("<a href='event:help'>%s</a>", self.langPath.help), name, 760, 375, 35, 20, nil, 0xf, 0.5, true)
end

function Player:keyboard(key, down, x, y)

end

function eventNewPlayer(name)

    data[name] = data[name] or Player:new(name)

    data[name]:setLangPath(name)
    data[name]:showHotbar(name)

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
    end
    
    ui.setMapName("#dungeon")
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

