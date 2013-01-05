local stage = "Broadcast Test"

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

while true do 

	term.clear()
	term.setCursorPos(1,1)
 	
	x, y, z = gps.locate(2,false)
	f = turtle.getFuelLevel()
	
	print(x)
	print(y)
	print(z)
	print(f)
	print(stage)
	
	
	if x ~= nil then
		rednet.send(8, textutils.serialize({x,y,z,f,stage}));
	end
 
	sleep(1) 
 end