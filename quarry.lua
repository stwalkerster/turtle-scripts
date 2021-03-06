local length = 14; -- how far back to go minus 2
local width = 7; -- how wide minus 2, div 2
local depth = 0; -- how many levels minus 1

local steps = 1;
local stage = "Quarrying"

local _term_position=1;

local x,y,z = gps.locate(2,false)

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
	x, y, z = gps.locate(2,false)
	f = turtle.getFuelLevel()
	
	if x ~= nil then
		rednet.send(tl.getControlServer(), textutils.serialize({x,y,z,f,stage}));
	else
		x="?"
		y="?"
		z="?"
	end

	term.write("x: " .. x)
	term.setCursorPos(1,_term_position+1);
	term.write("y: " .. y)
	term.setCursorPos(1,_term_position+2);
	term.write("z: " .. z)
	term.setCursorPos(1,_term_position+3);
	term.write("fuel: " .. f)
	term.setCursorPos(1,_term_position+4);
	term.write("steps: " .. steps)
	term.setCursorPos(1,_term_position);
end

function tlDig()
	local oldstage = stage
	while turtle.detect() do
		if tlAllowedDig() then
			stage = oldstage
			turtle.dig();
		else
			stage = "ERR: Not allowed to mine"
			updateStats()
		end
	end
end

function tlAllowedDig()
	
	if y < 32 then
		-- lapis
		turtle.select(2)
		if turtle.compare() then return false end

		if y < 16 then
			-- redstone
			turtle.select(1)
			if turtle.compare() then return false end
			-- diamond
			turtle.select(3)
			if turtle.compare() then return false end

		end
	end

	-- coal
	turtle.select(4)
	if turtle.compare() then return false end
	
	return true
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
	return ((((length + 1)* ((width*2)+2)) + (width*2)+2) * (depth+1))
end

-- start the quarry.
term.clear();
term.setCursorPos(1,_term_position);
term.write("I will need " .. fuelConsumption(length, width, depth) .. " units of fuel.")
_term_position=_term_position+1
term.setCursorPos(1,_term_position);
term.write("I currently have " .. turtle.getFuelLevel() .. " units of fuel.")
_term_position=_term_position+1
term.setCursorPos(1,_term_position);

if fuelConsumption(length, width, depth) > turtle.getFuelLevel() then
	turtle.refuel()	
	term.write("After refuelling, I have " .. turtle.getFuelLevel() .. " units of fuel.")
	_term_position=_term_position+1
	term.setCursorPos(1,_term_position);
end

term.write("Starting operation in " .. (length + 2) .. "x" .. (depth+1) .. "x" .. ((width*2)+2) .. " area")
_term_position=_term_position+1
term.setCursorPos(1,_term_position);
updateStats();

-- open rednet connection
tl.open()

for d = 0, depth do

	stage = "Quarrying (" .. (d+1) .. "/" .. (depth+1) .. ")"

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
tl.updateLocation("Ready.")
