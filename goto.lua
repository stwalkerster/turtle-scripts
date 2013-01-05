

local tArgs = { ... }
if #tArgs < 3 then
	print( "Usage: goto x y z" )
	return
end

local stage = "Going to Location"
local targetx = tArgs[1]
local targety = tArgs[2]
local targetz = tArgs[3]

function getOrientation()
	p1x, p1y, p1z = gps.locate(2, false)
	
	if p1x == nil then
		return nil
	end
	
	reverse = false;
	orientation = nil;
	
	if not turtle.forward() then
--		turtle.back()
--		reverse = true
		return nil
	end
	
	p2x, p2y, p2z = gps.locate(2,false)
	
	if p2x == nil then
		return nil
	end
	
	if p1x==p2x then
		if p1z > p2z then
			orientation = 2;
		elseif p1z < p2z then
			orientation = 0;
		end
	elseif p1x > p2x then
		orientation = 1;
	elseif p1x < p2x then
		orientation = 3;
	end

	return orientation
end


if not tl.open() then return end
local myx, myy, myz = gps.locate(2, false)

local dy = targety - myy

-- sort out y
if dy > 0 then
	-- go up
	dy = dy
	for y = 1 , dy do turtle.up() tl.updateLocation(stage) end
elseif dy < 0 then
	-- go down
	dy = math.abs(dy)
	for y = 1 , dy do turtle.down() tl.updateLocation(stage) end
end


local orientation = getOrientation()
myx, myy, myz = gps.locate(2, false)
dx = targetx - myx
dz = targetz - myz



-- standardise our orientation
if orientation == 1 then
	-- we moved -x
	-- turn to face +x
	turtle.turnRight()
	turtle.turnRight()
elseif orientation == 2 then
	-- we moved -z
	-- turn to face +x
	turtle.turnRight()
elseif orientation == 3 then
	-- we moved +x
elseif orientation == 0 then
	-- we moved +z
	-- turn to face +x
	turtle.turnLeft()
end

-- moving forward will now inc x.

-- sort out x
if dx > 0 then
	-- go forward
	dx = dx
	for x = 1 , dx do turtle.forward() tl.updateLocation(stage) end
elseif dx < 0 then
	-- go back
	dx = math.abs(dx)
	for x = 1 , dx do turtle.back() tl.updateLocation(stage) end
end

-- turning right will inc z
turtle.turnRight()

-- sort out z
if dz > 0 then
	-- go forward
	dz = dz
	for z = 1 , dz do turtle.forward() tl.updateLocation(stage) end
elseif dz < 0 then
	-- go back
	dz = math.abs(dz)
	for z = 1 , dz do turtle.back() tl.updateLocation(stage) end
end


myx, myy, myz = gps.locate(2, false)
dx = targetx - myx
dz = targetz - myz
dy = targety - myy

if dx ~= 0 or dy ~= 0 or dz ~= 0 then

	print( "Could not move to location")
	
end
close()