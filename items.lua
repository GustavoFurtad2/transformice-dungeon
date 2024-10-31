local itemType = {

    weapon = 1,
    consumable = 2
}

local items = {

    sword = {

        index = 1,

        name = "Sword",
        type = itemType.weapon,

        skills = {

            [1] = {

                name = "Quick Cut",

                key = "X",
                damage = 3,
                cooldownTime = 2,

            },

            [2] = {

                name = "Penetrate",

                key = "Z",
                damage = 7,
                cooldownTime = 6,
            }
        },
    },

    excalibur = {

        index = 2,

        name = "Excalibur",
        type = itemType.weapon,

        skills = {

            [1] = {

                name = "Light Speed Cut",

                key = "X",
                damage = 7,
                cooldownTime = 3,

                lastAttack,

                use = function()

                end

            },

            [2] = {

                name = "Sunrise",

                key = "Z",
                damage = 14,
                cooldownTime = 7,

                lastAttack,

                use = function()

                end
                
            }
        },
    }
}
