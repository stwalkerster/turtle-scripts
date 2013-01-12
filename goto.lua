

local tArgs = { ... }
if #tArgs < 3 then
	print( "Usage: goto x y z" )
	return
end

if tl.version == nil then print("Out of date API, please reboot") return end
if tl.version() < 2 then print("Out of date API, please reboot") return end

local stage = "Going to Location"
local tx = tArgs[1]
local ty = tArgs[2]
local tz = tArgs[3]

tl.goToLocation(tx,ty,tz)