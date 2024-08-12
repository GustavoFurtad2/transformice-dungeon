for i, v in next, {"AutoNewGame", "AutoShaman", "AfkDeath", "PhysicalConsumables"} do
    tfm.exec["disable" .. v]()
end

tfm.exec.newGame "<C><P L='4800' H='32000' MEDATA=';;;;-0;0:::1-'/><Z><S><S T='6' X='402' Y='31972' L='800' H='54' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='-2' Y='31773' L='10' H='347' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='807' Y='31772' L='10' H='348' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='402' Y='31595' L='820' H='10' P='0,0,0.3,0.2,0,0,0,0'/><S T='7' X='3000' Y='373' L='800' H='54' P='0,0,0.3,0.2,0,0,0,0'/><S T='19' X='3000' Y='453' L='1800' H='108' P='0,0,0.3,0.2,0,0,0,0' m=''/><S T='14' X='2100' Y='200' L='10' H='401' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='3900' Y='200' L='10' H='401' P='0,0,0.3,0.2,0,0,0,0'/><S T='9' X='3000' Y='453' L='1800' H='108' P='0,0,0,0,0,0,0,0'/><S T='0' X='3000' Y='77' L='800' H='10' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='2596' Y='39' L='10' H='76' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='3397' Y='40' L='10' H='76' P='0,0,0.3,0.2,0,0,0,0'/><S T='14' X='2994' Y='3' L='808' H='10' P='0,0,0.3,0.2,0,0,0,0'/></S><D><DS X='403' Y='31929'/></D><O/><L/></Z></C>"
ui.setMapName("#dungeon \n")

local data = {}

local images = {}

local function Player(name)

    local instance = {
        
        health    = 100,
        maxHealth = 100,

        speed     = 5,

        isDead    = false,

        backpack  = {},

    }

    function instance:lobby()

        ui.addTextArea(1, "<a href='event:enterArena'><p align='center'>Arena</p></a>", name, 200, 31800, 80, 20, 0xf, 0xf, 1, false)
        ui.addTextArea(2, "<a href='event:enterDungeon'><p align='center'>Dungeon</p></a>", name, 540, 31800, 80, 20, 0xf, 0xf, 1, false)

        ui.addTextArea(3, "<a href='event:leaveArena'><p align='center'>Leave</p></a>", name, 2980, 30, 80, 20, 0xf, 0xf, 1, false)
    end

    function instance:killPlayer()

        tfm.exec.killPlayer(name)
        self.isDead = true
    end

    function instance:setHealth(health)

        self.health = math.min(health, self.maxHealth)
    end

    function instance:addHealth(health)

        self.health = math.min(self.health + health, self.maxHealth)
    end

    function instance:subHealth(health)

        self.health = self.health - health
        if self.health <= 0 then
            self:killPlayer()
        end
    end

    function instance:keyboard(key, down, x, y)

    end

    return instance
end

function eventNewPlayer(name)

    data[name] = data[name] or Player(name)
    data[name]:lobby()
end

function enterArena(name)

    tfm.exec.movePlayer(name, 2980, 40)
end

function leaveArena(name)

    tfm.exec.movePlayer(name, 403, 31929)
end

function eventTextAreaCallback(id, name, event)
    
    -- _GLOBAL[event](name)
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end
