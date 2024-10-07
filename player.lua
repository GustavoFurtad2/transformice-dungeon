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

            hotbar = {},
            backpack = {items.sword},
        },
    Player)

    player.hotbar[1] = player.backpack[1]

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
        showPlayerList(name)
    end

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

function Player:showHotbar()

    ui.addTextArea(11, self.hotbar[1].name, name, 10, 345, 50, 50, nil, 0xf, 0.5, true)
        
    if self.hotbar[2] then
        ui.addTextArea(12, self.hotbar[2].name, name, 75, 345, 50, 50, nil, 0xf, 0.5, true)
    end
        
    if self.hotbar[3] then
        ui.addTextArea(13, self.hotbar[3].name, name, 140, 345, 50, 50, nil, 0xf, 0.5, true)
    end
end

function Player:keyboard(key, down, x, y)

end
