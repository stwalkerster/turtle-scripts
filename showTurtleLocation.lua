m=peripheral.wrap("top")

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

function updateScreen(x,y,z,fuel)
	m.clear()
	m.setCursorPos(1,1)
	m.write("X: " .. x);
	m.setCursorPos(1,2)
	m.write("Y: " .. y);
	m.setCursorPos(1,3)
	m.write("Z: " .. z);
	m.setCursorPos(1,5)
	m.write("Fuel: " .. fuel);
	
	
end

while true do
	senderid, message, distance = rednet.receive(3);

	if senderid == nil then 
		updateScreen("?","?","?","?")
	else
		t = textutils.unserialize(message)
		updateScreen(t[1],t[2],t[3],t[4])
	end
end