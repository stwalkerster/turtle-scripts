tArgs = { ... }
print("Returning home...")
shell.run("git/goto.lua", tArgs[1]);
turtle.turnLeft()

for x = 1,15 do
	turtle.select(x)
	turtle.dropDown()
end
turtle.select(16)

print("Done! Type 'start' to run me again!")

tl.updateLocation("Ready.")