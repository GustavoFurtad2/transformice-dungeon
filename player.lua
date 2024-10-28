local Player = {}
Player.__index = Player

function Player:new(name)

    local player = setmetatable(
        {

            index = 0,

            health = 100,
            maxHealth = 100,

            speed = 5,

            isDead = false,
            isPlaying = false,

            currentHotbar = 1,

            hotbar = {},
            backpack = {items.sword},
        },
    Player)

    player.hotbar[1] = player.backpack[1]
    player.hotbar[2] = player.backpack[1]

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
        showPlayerList(name)
    end

    tfm.exec.bindKeyboard(name, string.byte("1"), true, true)
    tfm.exec.bindKeyboard(name, string.byte("2"), true, true)

    return player
end

function Player:killPlayer()

    tfm.exec.killPlayer(name)
    self.isDead = true
end

function Player:setHealth(health)

    self.health = math.min(health, self.maxHealth)
end

function Player:addHealth(health)

    self.health = math.min(self.health + health, self.maxHealth)
end

function Player:subHealth(health)

    self.health = self.health - health

    if self.health <= 0 then
        self:killPlayer()
    end
end

function Player:setLangPath(name)

    self.langPath = texts[tfm.get.room.community] or texts.en
end

function Player:showHotbar(name)

    ui.addTextArea(11, "<A:ACTIVE>1</A:ACTIVE>", name, 10, 345, 50, 50, nil, 0xf, 0.5, true)
        
    if self.hotbar[2] then
        ui.addTextArea(12, "2", name, 75, 345, 50, 50, nil, 0xf, 0.5, true)
    end
        
    if self.hotbar[3] then
        ui.addTextArea(13, "3", name, 140, 345, 50, 50, nil, 0xf, 0.5, true)
    end

    ui.addTextArea(14, string.format("<a href='event:help'>%s</a>", self.langPath.help), name, 760, 375, 35, 20, nil, 0xf, 0.5, true)
end

function Player:updateHotbar(name, hotbarNumber)

    ui.updateTextArea(10 + self.currentHotbar, self.currentHotbar, name)
    ui.updateTextArea(10 + hotbarNumber, "<A:ACTIVE>" .. hotbarNumber .. "</A:ACTIVE>", name)

    self.currentHotbar = hotbarNumber
end

function Player:keyboard(key, down, x, y)

    if key == string.byte("1") then
        
        if "1" ~= self.currentHotbar then

            self:updateHotbar(name, 1)
        end

    elseif key == string.byte("2") then

        if "2" ~= self.currentHotbar then

            self:updateHotbar(name, 2)
        end

    elseif key == string.byte("3") then

        if "3" ~= self.currentHotbar then

            self:updateHotbar(name, 3)
        end
    end
end
