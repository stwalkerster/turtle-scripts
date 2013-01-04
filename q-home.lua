print("Returning home...")
shell.run("git/goto.lua", "209 58 323");
turtle.turnRight()

print("Done! Type 'start' to run me again!")


x, y, z = gps.locate(2,false)
f = turtle.getFuelLevel()

if x ~= nil then
	rednet.send(8, textutils.serialize({x,y,z,f,"Done"}));
end
