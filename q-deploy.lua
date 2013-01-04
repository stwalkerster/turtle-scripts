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
		rednet.send(8, textutils.serialize({x,y,z,f}));
	end
end

turtle.forward();  updateLocation()
turtle.forward();  updateLocation()
while not turtle.compare() do turtle.down()  updateLocation() end
turtle.down();  updateLocation()
turtle.down();  updateLocation()