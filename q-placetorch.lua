turtle.up()
turtle.select(16)
for side = 1, 4 do
while not turtle.detect() do
	turtle.placeUp()
	turtle.forward()
	turtle.forward()
end
turtle.turnRight()
end

-- remove the one blocking the exit path
turtle.digUp();

-- place one in front of the exit path for later detection
turtle.up(); 
turtle.place();

-- search for the old torch set
turtle.up();
while not turtle.detect() do
turtle.up()
end

turtle.down()
for side = 1, 4 do
while not turtle.detect() do
	turtle.digUp()
	turtle.forward()
end
turtle.turnRight()
end