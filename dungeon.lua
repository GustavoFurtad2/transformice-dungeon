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

    for i = -1, 10 do

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
