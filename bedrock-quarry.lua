local length = 16;
local width = 16;

local steps = 0;
local stage = "Finalising around bedrock"

local _term_position=1;

if tl.version == nil then print("Out of date API, please reboot") return end
if tl.version() < 1 then print("Out of date API, please reboot") return end


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

function fuelConsumption(length, width, depth)
	return ((((length + 1)* ((width*2)+2)) + (width*2)+2) * (depth+1))
end

-- start the quarry.
term.clear();
term.setCursorPos(1,_term_position);
term.write("I will need about " .. fuelConsumption(length, width, depth) .. " units of fuel.")
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

term.write("Starting operation in " .. (length) .. "x" .. ((width)) .. " area")
_term_position=_term_position+1
term.setCursorPos(1,_term_position);
updateStats();

-- open rednet connection
tl.open()

totalcols = (width * length)+1
pos=1

function tlDigForward()
	tl.DigForward()
	tl.updateLocation(stage)
end

function doColumn()
	loop = true
	local x,origy,z = gps.locate(2,false)
	local y
	
	while loop do
		if turtle.detectDown() then
			if turtle.digDown() then
				while not turtle.down() tl.updateLocation("Column " .. pos .. " of " .. totalcols) do end
			else
				break
			end
		else
			while not turtle.down() tl.updateLocation("Column " .. pos .. " of " .. totalcols) do end
		end
		
		x,y,z=gps.locate(2,false);
		loop = (y > 0)
	end
	
	while y < origy do
		for orientation = 1, 4 do
			if turtle.detect() then
				turtle.dig()
			end
			turtle.turnRight()
		end
		turtle.up() tl.updateLocation("Column " .. pos .. " of " .. totalcols)
		y = y + 1
	end
	
	pos=pos+1
end

turtle.up() tl.updateLocation(stage)

for w = 1, (math.floor(width/2)-1) do
	
	for l = 1, (length-1) do
		doColumn() tlDigForward(); 
	end

	turtle.turnRight();
	doColumn() tlDigForward();
	turtle.turnRight();

	for l = (1, length-1) do
		doColumn() tlDigForward();
	end n

	turtle.turnLeft();
	doColumn() tlDigForward();
	turtle.turnLeft();
end

-- return to start

turtle.turnLeft();
for w = 1, (width-1) do
	tlDigForward();
end

turtle.turnRight();

tl.updateLocation("Ready.")