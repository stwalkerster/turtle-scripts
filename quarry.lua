local length = 16;
local width = 16;
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

function tlDigForward()
	while not turtle.forward() do
		tlDig();
	end
end

	
-- lets' move the turtle to the first square

tlDigForward();

for l = 0, length do
	tlDigForward();
end