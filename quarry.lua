local length = 16;
local width = 8;
local depth = 16;

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
	****************
	X
	
	place turtle on the X. ]]

-- various functions to be used	
function tlDig()	
	while turtle.detect() do
		turtle.dig();
	end
end

function tlDigDown()	
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
		tlDigDown();
	end
end

	
-- lets' move the turtle to the first square

-- tlDigForward();

-- start the quarry.

for d = 0, depth do

	for w = 0, width do

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