m=peripheral.wrap("top")

local x,y,z,f,stage
x=""
y=""
z=""
f=""
stage="unknown"

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

function updateScreen(ux,uy,uz,ufuel,e,ustage)
	e2 = ""
	if ux == nil then ux = "?" e[2]="Data x failure" end
	if uy == nil then uy = "?" e[2]="Data y failure"  end
	if uz == nil then uz = "?" e[2]="Data z failure"  end
	if ufuel == nil then ufuel = "?" e[2]="Data f failure"  end
	if ustage == nil then ustage = "?" e[2]="Data s failure"  end

	m.clear()
	m.setCursorPos(1,1)
	m.write("turtle01 - Current Position");
	m.setCursorPos(1,3)
	m.write("X: " .. ux);
	m.setCursorPos(1,4)
	m.write("Y: " .. uy);
	m.setCursorPos(1,5)
	m.write("Z: " .. uz);
	m.setCursorPos(1,7)
	m.write("Fuel: " .. ufuel);
	m.setCursorPos(1,9)
	m.write("Stage: " .. ustage);
	m.setCursorPos(1,11)
	m.write(e[1]);	
	m.setCursorPos(1,12)
	m.write(e[2]);
	
	
	
end

while true do
	senderid, message, distance = rednet.receive(3);

	if senderid == nil then 
		updateScreen(x.."?",y.."?",z.."?",f.."?",{"Turtle not broadcasting /","                 out of range"}, stage)
	else
		t = textutils.unserialize(message)
		if t ~= nil then
			x = t[1]
			y = t[2]
			z = t[3]
			f = t[4]
			stage = t[5]
			updateScreen(x,y,z,f,"", stage)
		else
			updateScreen(x.."?",y.."?",z.."?",f.."?",{"Data decode failure."}, stage)
		end
	end
end