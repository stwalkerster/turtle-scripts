local length = 14; -- how far back to go minus 2
local width = 7; -- how wide minus 2, div 2
local depth = 1; -- how many levels

local steps = 0;

--[[ area to be mined:

	****************
	****************
	****************
	****************
	****************
	****************
	X****************
	
	place turtle on the X. ]]

-- various functions to be used
function writeline(data)
	term.write(data);
	term.scroll(1);
	oldx, oldy = term.getCursorPos()
	term.setCursorPos(1,oldy)
end

function updateStats()
	local oldx,oldy = term.getCursorPos()
	
	term.write("x: ?")
	term.setCursorPos(1,oldy+1);
	term.write("y: ?")
	term.setCursorPos(1,oldy+2);
	term.write("z: ?")
	term.setCursorPos(1,oldy+3);
	term.write("fuel: " .. turtle.getFuelLevel())
	term.setCursorPos(1,oldy+4);
	term.write("steps: " .. steps)
	term.setCursorPos(1,oldy);
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
			-- block in my way
			tlDig();
			moved = turtle.forward()
		elseif turtle.getFuelLevel() == 0 then
			-- out of fuel
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
			-- player / npc?
			moved = turtle.forward();
		end
	end
	
	steps = steps + 1
	
	updateStats();
end

function tlDigDown()
	while not turtle.down() do
		tlReallyDigDown();
	end
end

function fuelConsumption(length, width, depth)
	return ((((length + 1)* ((width*2)+2)) + width) * depth)
end

-- lets' move the turtle to the first square

-- tlDigForward();

-- start the quarry.
term.clear();
term.setCursorPos(1,1);

writeline("I will need " .. fuelConsumption(length, width, depth) .. " units of fuel.")
writeline("I currently have " .. turtle.getFuelLevel() .. " units of fuel.")
writeline("Starting operation in " .. (length + 2) .. "x" .. depth .. "x" .. ((width*2)+1) .. " area")

if fuelConsumption(length, width, depth) > turtle.getFuelLevel() then
	turtle.refuel()	
	writeline("After refuelling, I have " .. turtle.getFuelLevel() .. " units of fuel.")
end

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
