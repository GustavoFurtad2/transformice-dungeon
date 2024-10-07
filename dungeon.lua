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
