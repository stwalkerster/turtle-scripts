local locker = true
local password_server = 3 -- change to the ID of your password server computer
rednet.open("back") -- change to the side your rednet modem is on
while locker do
	term.clear()
	term.setCursorPos(1,1)
	print("Server Room Access")
	print("What would you like to do?")
	print("[1] Open Door")
	print("[2] Close door")
	write("> ")
	local input = read()
	if input == "2" then
		redstone.setOutput("left", false)
	elseif input == "1" then
		local username = "serverroomdoor"
		write("Password: ")
		local password = read("*")
		rednet.send(password_server, username, true)
		senderId, message, distance = rednet.receive(5)
		if password == message then
			redstone.setOutput("left", true)
		else
			print("Invalid Username or Password.")
			sleep(3)
		end
	else
		print("Command not recognised...")
		sleep(2)
	end
end