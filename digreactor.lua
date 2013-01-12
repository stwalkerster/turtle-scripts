local length = 9; -- how far back to go minus 2
local width = 5; -- how wide minus 2, div 2
local depth = 10; -- how many levels minus 1

--[[ area to be mined:

	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	****************
	X***************
	
	place turtle on the X. ]]

-- various functions to be used	
function tlDig()	
	while turtle.detect() do
		turtle.dig();
	end
end

function tlDigBelow()	
	while turtle.detectDown() do
		turtle.digDown();
	end
end

function tlDigForward()
	while not turtle.forward() do
		tlDig();
	end
end

function tlDigDown()
	while not turtle.down() do
		tlDigBelow();
	end
end

	
-- lets' move the turtle to the first square

-- tlDigForward();

-- start the quarry.

for d = 0, depth do

	for w = 0, width do
		term.write( "w = " .. w );
		for l = 0, length do
			tlDigForward();
		end

		turtle.turnRight();
		tlDigForward();
		turtle.turnRight();

		for l = 0, length do
			tlDigForward();
		end

		turtle.turnLeft();
		tlDigForward();
		turtle.turnLeft();
	end

	turtle.turnLeft();
	for w = 0, width do
		tlDigForward();
		tlDigForward();
	end

	turtle.turnRight();
	
	tlDigDown();
	
end
