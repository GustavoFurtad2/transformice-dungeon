function build(files, includes)

    local content = ""
    local build = io.open("builds/build.lua", "w")
    
    for k, v in next, includes do

        local file = io.open("include/" .. v .. ".lua")
        content = "-- include " .. v .. ".lua \n" .. content .. file:read("*a") .. "\n\n"
        file:close()
    end

    content = content .. "-- end includes\n\n"

    for k, v in next, files do

        local file = io.open(v .. ".lua")
        content = content .. file:read("*a") .. "\n\n"
        file:close()

    end

    build:write(content)
end

local includes = {"xml"}
local files = {"init", "items", "lobby", "dungeon", "player", "events"}

build(files, includes)

return
