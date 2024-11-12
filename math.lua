local function pythag(x1, y1, x2, y2)

    return math.sqrt(( (x2 - x1) ^ 2) + ( (y2 - y1) ^ 2))
end

local function checkDist(dist, player1, player2)

    return pythag(tfm.get.room.playerList[player1].x, tfm.get.room.playerList[player1].y, tfm.get.room.playerList[player2].x, tfm.get.room.playerList[player2].y) <= dist
end

local function checkPlayerNearby(dist, player1)

    for name, object in next, data do

        if name ~= player1 then

            if checkDist(dist, player1, name) then

                return name
            end
        end
    end

    return false
end
