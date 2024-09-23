function build(files)

    local content = ""
    local build = io.open("builds/build.lua", "w")
    
    for k, v in next, files do

        local file = io.open(v .. ".lua")
        content = content ..  file:read("*a") .. "\n\n"
        file:close()

    end

    build:write(content)
end

build({"init", "items", "lobby", "player", "events"})

return
