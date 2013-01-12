local length = 12

for d = 0, length do

	-- dig bl block
	while turtle.detect() do
		turtle.dig();
	end
	
	-- attempt to move up
	while not turtle.up() do
		turtle.digUp();
	end
	
	-- dig cl block
	while turtle.detect() do
		turtle.dig();
	end
	
	-- attempt to move up
	while not turtle.up() do
		turtle.digUp();
	end
	
	-- dig tl block
	while turtle.detect() do
		turtle.dig();
	end
	
	-- move right
	turtle.turnRight();
	
	while not turtle.forward() do
		turtle.dig();
	end
	
	turtle.turnLeft();
	
	-- now dig the tr
	while turtle.detect() do
		turtle.dig();
	end
	
	-- attempt to move down
	while not turtle.down() do
		turtle.digDown();
	end
	
	-- dig cr
	while turtle.detect() do
		turtle.dig();
	end

	-- attempt to move down
	while not turtle.down() do
		turtle.digDown();
	end
	
	-- dig br
	while turtle.detect() do
		turtle.dig();
	end
	
	turtle.turnLeft()
	
	turtle.forward();
	
	turtle.turnRight();
	
	turtle.forward();
	
end