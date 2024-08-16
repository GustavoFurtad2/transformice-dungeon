local currentDuel
local arenaQueueList = {}

local function newDuel(player1, player2)

    table.insert(arenaQueueList, {
        player1 = player1,
        player2 = player2
    })

    data[player1].inDuelList = true
    data[player2].inDuelList = true
end

local function setDuel()

    table.remove(arenaQueueList, 1)

    currentDuel = arenaQueueList[1]

    tfm.exec.freezePlayer(currentDuel.player1, true, false)
    tfm.exec.freezePlayer(currentDuel.player2, true, false)

    tfm.exec.movePlayer(currentDuel.player1, 2700, 320)
    tfm.exec.movePlayer(currentDuel.player2, 3200, 320)
end
