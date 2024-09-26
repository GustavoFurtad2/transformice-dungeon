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
