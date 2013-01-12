print( "This is " .. os.getComputerLabel() )
print("Loading APIs...")
os.loadAPI("/git/apis/tl")
print("Connecting to WiFi: ScimonsHouse")
tl.open()
print("Checking turtle state...")
x,y,z = gps.locate(2,false)
if x == nil then
	print("Waiting for GPS servers...")
	sleep(5)
	x,y,z = gps.locate(10,false)
end
print("Location: " .. x .. "," .. y .. "," .. z .. ", Fuel:" .. turtle.getFuelLevel());
print("Updating control server...")
tl.updateLocation("Ready.")
print("")
print(os.getComputerLabel() .. " ready for orders.")
