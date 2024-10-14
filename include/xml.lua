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

    return [[<C><P/><Z><S></S><D></D><O></O></Z></C>]]
end
