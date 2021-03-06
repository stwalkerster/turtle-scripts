-- drop to next level
homex, homey, homez = gps.locate(2)

while turtle.getFuelLevel() > 1000 do
	nx, ny, nz = gps.locate(2)
	if nx ~= homex or ny ~= homey or nz ~= homez then
		print("Not at start, aborting.");
		break
	end

	shell.run("git/q-deploy.lua")

	shell.run("git/quarry.lua")
	x,y = term.getCursorPos()
	term.setCursorPos(1,y+5);

	shell.run("git/q-home.lua",  homex .. " " .. homey .. " " .. homez);

	shell.run("git/q-deploy.lua")
	turtle.down()

	shell.run("git/quarry.lua")
	x,y = term.getCursorPos()
	term.setCursorPos(1,y+5);


	print("Updating lighting...")
	-- update lighting
	shell.run("git/q-placetorch.lua")

	shell.run("git/q-home.lua",  homex .. " " .. homey .. " " .. homez);


end
