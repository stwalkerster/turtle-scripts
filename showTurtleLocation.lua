local tArgs = { ... }
if #tArgs < 2 then
	print( "Usage: showloc <turtlename> <monitorlocation>" )
	return
end
local turtleName = tArgs[1]

m=peripheral.wrap(tArgs[2])

local x,y,z,f,stage,running,task
x=""
y=""
z=""
f=""
stage="unknown"
task="unknown"
running=0

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

function updateScreen(ux,uy,uz,ufuel,e,e2)
	if ux == nil then ux = "?"  print("data x fail") end
	if uy == nil then uy = "?"  print("data y fail") end
	if uz == nil then uz = "?"  print("data z fail") end
	if ufuel == nil then 
		ufuel = "?" print("data f fail")
	end
	if task == nil then task = "" end
	if stage == nil then stage = "" end

	m.clear()
	m.setCursorPos(1,1)
	m.write( turtleName .. " - Current Position");
	m.setCursorPos(1,2)
	m.write("X: " .. ux);
	m.setCursorPos(1,3)
	m.write("Y: " .. uy);
	m.setCursorPos(1,4)
	m.write("Z: " .. uz);
	m.setCursorPos(1,6)
	m.write("Fuel: " .. ufuel);
	m.setCursorPos(1,8)
	m.write("Task: " .. task);
	m.setCursorPos(1,9)
	m.write("Stage: " .. stage);
	m.setCursorPos(1,11)
	m.write(e);	
	m.setCursorPos(1,12)
	m.write(e2);
	
	
	
end

while true do
	senderid, message, distance = rednet.receive(3);

	if senderid == nil then 
		if running == 1 then
			updateScreen(x.."?",y.."?",z.."?",f.."?","Turtle not broadcasting / " , "                 out of range")
		end
	else
		t = textutils.unserialize(message)
		if message == "PING" then
			-- gps locator ping
		else
			if t ~= nil then
				x = t[1]
				y = t[2]
				z = t[3]
				f = t[4]
				stage = t[5]
				task = t[6]
				
				if stage == "Ready." then
					running = 0
					updateScreen(x,y,z,f,"","Not running")
				else
					running = 1
					updateScreen(x,y,z,f,"","")
				end
			else
				updateScreen(x.."?",y.."?",z.."?",f.."?","Data decode failure.","")
				print("data is null: " .. message)
			end
		end
	end
end