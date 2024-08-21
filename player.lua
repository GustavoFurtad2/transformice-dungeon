local function Player(name)

    local instance = {
        
        health     = 100,
        maxHealth  = 100,

        speed      = 5,

        isDead     = false,

        inArena    = false,
        inDuelList = false,

        backpack   = {},

        hotbar     = {}
    }

    instance.hotbar[1] = instance.backpack[1] or {name = "error"}
    instance.hotbar[2] = instance.backpack[2] or {name = "error"}
    instance.hotbar[3] = instance.backpack[3] or {name = "error"}

    function instance:lobby()

        ui.addTextArea(1, "<a href='event:enterArena'><p align='center'>Arena</p></a>", name, 200, 31800, 80, 20, 0xf, 0xf, 1, false)
        ui.addTextArea(2, "<a href='event:enterDungeon'><p align='center'>Dungeon</p></a>", name, 540, 31800, 80, 20, 0xf, 0xf, 1, false)
    end

    function instance:showHotbar()

        ui.addTextArea(11, self.hotbar[1].name, name, 10, 345, 50, 50, nil, 0xf, 1, true)
        ui.addTextArea(12, self.hotbar[2].name, name, 75, 345, 50, 50, nil, 0xf, 1, true)
        ui.addTextArea(13, self.hotbar[3].name, name, 140, 345, 50, 50, nil, 0xf, 1, true)
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
