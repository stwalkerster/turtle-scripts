term.clear()
term.setCursorPos(1,1)
print("This is a password server. There is no user interaction here.")
print("Please find a computer and login there.") 
local firstCycle = true
local validSender = false
local modemSide = "back" -- change to the side of the computer your modem is on
local valid = false
users = {"serverroomdoor", "workstation" } --make sure users and passwords line up
passwords = {"letmein", "stwalkerster" }
senders = { 0, 1, 2, 3, 9 } -- computer ID's of the computers you want to accept requests from
function bootUp()
 rednet.open(modemSide)
end
while true do 
 validSender = false
 if firstCycle then
  bootUp()
  firstCycle = false
 end
 senderId, message, distance = rednet.receive()
 for i,v in ipairs(senders) do
  if v == senderId then
   validSender = true
   break
  end
 end
 if validSender then
  for i,v in ipairs(users) do
   if message == v then
    valid = true
    password = passwords[i]
    break
   else
    valid = false
   end
  end
  if valid then
   rednet.send(senderId, password, true)
  else
   rednet.send(senderId, "Not Valid", true)
  end
 end
end
