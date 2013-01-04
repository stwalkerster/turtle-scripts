local stage = "Updating Lighting"

local sOpenedSide = nil
local function open()
	local bOpen, sFreeSide = false, nil
	for n,sSide in pairs(rs.getSides()) do	
		if peripheral.getType( sSide ) == "modem" then
			sFreeSide = sSide
			if rednet.isOpen( sSide ) then
				bOpen = true
				break
			end
		end
	end
	
	if not bOpen then
		if sFreeSide then
			rednet.open( sFreeSide )
			sOpenedSide = sFreeSide
			return true
		else
			print( "No modem attached" )
			return false
		end
	end
	return true
end

open()

function updateLocation()
	x, y, z = gps.locate(2,false)
	f = turtle.getFuelLevel()
	
	if x ~= nil then
		rednet.send(8, textutils.serialize({x,y,z,f,stage}));
	end
end

turtle.up() updateLocation()
turtle.select(16)
for side = 1, 4 do
while not turtle.detect() do
	turtle.placeUp()
	turtle.forward() updateLocation()
	turtle.forward() updateLocation()
end
turtle.turnRight()
end

-- remove the one blocking the exit path
turtle.digUp();

-- place one in front of the exit path for later detection
turtle.up(); updateLocation()
turtle.place();

-- search for the old torch set
turtle.up(); updateLocation()
while not turtle.detect() do
turtle.up() updateLocation()
end

turtle.down() updateLocation()
for side = 1, 4 do
while not turtle.detect() do
	turtle.digUp()
	turtle.forward() updateLocation()
end
turtle.turnRight()
end