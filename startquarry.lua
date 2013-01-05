-- drop to next level
shell.run("git/q-deploy.lua")

shell.run("git/quarry.lua")
x,y = term.getCursorPos()
term.setCursorPos(1,y+5);

shell.run("git/q-light-home.lua")
