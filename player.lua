local function Player(name)

    local instance = {
        
        health     = 100,
        maxHealth  = 100,

        speed      = 5,

        isDead     = false,

        inArena    = false,
        inDuelList = false,

        backpack   = {},

    }

    function instance:lobby()

        ui.addTextArea(1, "<a href='event:enterArena'><p align='center'>Arena</p></a>", name, 200, 31800, 80, 20, 0xf, 0xf, 1, false)
        ui.addTextArea(2, "<a href='event:enterDungeon'><p align='center'>Dungeon</p></a>", name, 540, 31800, 80, 20, 0xf, 0xf, 1, false)
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
