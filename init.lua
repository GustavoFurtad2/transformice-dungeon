for i, v in next, {"AutoNewGame", "AutoShaman", "AfkDeath", "PhysicalConsumables"} do
    tfm.exec["disable" .. v]()
end

tfm.exec.newGame "<C><P L='4800' H='32000' MEDATA=';;;;-0;0:::1-'/><Z><S><S T='6' X='402' Y='31972' L='800' H='54' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='-2' Y='31773' L='10' H='347' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='807' Y='31772' L='10' H='348' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='402' Y='31595' L='820' H='10' P='0,0,0.3,0.2,0,0,0,0'/><S T='7' X='3000' Y='373' L='800' H='54' P='0,0,0.3,0.2,0,0,0,0'/><S T='19' X='3000' Y='453' L='1800' H='108' P='0,0,0.3,0.2,0,0,0,0' m=''/><S T='14' X='2100' Y='200' L='10' H='401' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='3900' Y='200' L='10' H='401' P='0,0,0.3,0.2,0,0,0,0'/><S T='9' X='3000' Y='453' L='1800' H='108' P='0,0,0,0,0,0,0,0'/><S T='0' X='3000' Y='77' L='800' H='10' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='2596' Y='39' L='10' H='76' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='3397' Y='40' L='10' H='76' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='2994' Y='3' L='808' H='10' P='0,0,0.3,0.2,0,0,0,0'/></S><D><DS X='403' Y='31929'/></D><O/><L/></Z></C>"
ui.setMapName("#dungeon \n")

local data = {}

local images = {}