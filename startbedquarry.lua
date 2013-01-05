-- drop to next level
homex, homey, homez = gps.locate(2)

shell.run("git/q-deploy.lua")

shell.run("git/bedrock-quarry.lua")
x,y = term.getCursorPos()
term.setCursorPos(1,y+5);

shell.run("git/q-home.lua", homex .. " " .. homey .. " " .. homez)
