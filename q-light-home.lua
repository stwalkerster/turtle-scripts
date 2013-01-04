print("Updating lighting...")
-- update lighting
shell.run("git/q-placetorch.lua")

print("Returning home...")
shell.run("git/goto.lua", "209 58 323");
turtle.turnRight()

print("Done! Type 'start' to run me again!")