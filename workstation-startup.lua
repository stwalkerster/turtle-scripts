m=peripheral.wrap("top")
m.setCursorPos(1,1)
m.clear()
m.write("CraftOS running | locked")

local locker = true
local password_server = 3 -- change to the ID of your password server computer
rednet.open("back") -- change to the side your rednet modem is on
while locker do
	term.clear()
	term.setCursorPos(1,1)
	print("Protected system.")
	print("[1] Login")
	print("[2] Shutdown")
	write("> ")
	local input = read()
	if input == "2" then
		os.shutdown()
	elseif input == "1" then
		local username = "workstation"
		write("Password: ")
		local password = read("*")
		rednet.send(password_server, username, true)
		senderId, message, distance = rednet.receive(5)
		if password == message then
			locker=false
		else
			print("Invalid Username or Password.")
			sleep(3)
		end
	else
		print("Command not recognised...")
		sleep(2)
	end
end




m.clear()
m.setCursorPos(1,1)
m.write("CraftOS running | logged in")
term.clear();
term.setCursorPos(1,1)

