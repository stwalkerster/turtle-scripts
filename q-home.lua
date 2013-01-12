tArgs = { ... }

if tl.version == nil then print("Out of date API, please reboot") return end
if tl.version() < 2 then print("Out of date API, please reboot") return end

print("Returning home...")

if tl.goToLocation(tArgs[1],tArgs[2],tArgs[3]) then
	turtle.turnRight()

	for x = 5,15 do
		turtle.select(x)
		turtle.dropDown()
	end
	turtle.select(16)

	print("Done! Type 'start' to run me again!")

	tl.updateLocation("Ready.")
else
	print("Could not navigate home.")
	tl.updateLocation("ERR: Could not navigate home");
end
