local function Player(name)

    local instance = {
        
        health     = 100,
        maxHealth  = 100,

        speed      = 5,

        isDead     = false,

        backpack   = {
            items.sword
        },

        hotbar     = {}
    }

    instance.hotbar[1] = instance.backpack[1]

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
        showPlayerList(name)
    end

    function instance:showHotbar()

        ui.addTextArea(11, self.hotbar[1].name, name, 10, 345, 50, 50, nil, 0xf, 1, true)
        
        if self.hotbar[2] then
            ui.addTextArea(12, self.hotbar[2].name, name, 75, 345, 50, 50, nil, 0xf, 1, true)
        end
        if self.hotbar[3] then
            ui.addTextArea(13, self.hotbar[3].name, name, 140, 345, 50, 50, nil, 0xf, 1, true)
        end
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
