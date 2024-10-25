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
