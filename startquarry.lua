
-- drop to next level
shell.run("git/q-deploy.lua")

shell.run("git/quarry.lua")
x,y = term.getCursorPos()
term.setCursorPos(1,y+5);

print("Updating lighting...")
-- update lighting
shell.run("git/q-placetorch.lua")

print("Returning home...")
shell.run("git/goto.lua", "209 58 323");
turtle.turnRight()

print("Done! Type 'start' to run me again!")