local stage = "Updating Lighting"

turtle.up() tl.updateLocation(stage)
turtle.select(16)
for side = 1, 4 do
while not turtle.detect() do
	turtle.placeUp()
	turtle.forward() tl.updateLocation(stage)
	turtle.forward() tl.updateLocation(stage)
end
turtle.turnRight()
end

-- remove the one blocking the exit path
turtle.digUp();

-- place one in front of the exit path for later detection
turtle.up(); tl.updateLocation(stage)
turtle.place();

-- search for the old torch set
turtle.up(); tl.updateLocation(stage)
while not turtle.detect() do
turtle.up() tl.updateLocation(stage)
end

turtle.down() tl.updateLocation(stage)
for side = 1, 4 do
while not turtle.detect() do
	turtle.digUp()
	turtle.forward() tl.updateLocation(stage)
end
turtle.turnRight()
end