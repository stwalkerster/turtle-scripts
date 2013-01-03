local length = 14; -- how far back to go minus 2
local width = 7; -- how wide minus 2, div 2
local depth = 3; -- how many levels (broken)

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
function writeline(data)
	term.write(data);
	term.scroll(1);
	oldx, oldy = term.getCursorPos()
	term.setCursorPos(1,oldy)
end
	
function tlDig()	
	while turtle.detect() do
		turtle.dig();
	end
end

function tlReallyDigDown()	
	while turtle.detectDown() do
		turtle.digDown();
	end
end

function tlDigForward()
	moved = turtle.forward();
	

	while not moved do
		if turtle.detect() then
			tlDig();
			moved = turtle.forward()
		elseif turtle.getFuelLevel() == 0 then
			turtle.select(1);
			turtle.refuel();
			if turtle.getFuelLevel() == 0 then
				writeline("Please refuel me!");
				while turtle.getFuelLevel() == 0 do
					turtle.refuel();
				end
			end
			
			moved = turtle.forward();
		else
			moved = turtle.forward();
		end
	end
end

function tlDigDown()
	while not turtle.down() do
		tlReallyDigDown();
	end
end

	
-- lets' move the turtle to the first square

-- tlDigForward();

-- start the quarry.

for d = 0, depth do

	for w = 0, width do
		writeline( "w = " .. w );
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
