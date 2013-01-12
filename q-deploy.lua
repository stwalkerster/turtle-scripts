local stage = "Deploying to quarry"

while not turtle.forward() do end  tl.updateLocation(stage)
while not turtle.forward() do end  tl.updateLocation(stage)

while not turtle.compare() do if turtle.down() == false then break end tl.updateLocation(stage) end
turtle.down();  tl.updateLocation(stage)
turtle.down();  tl.updateLocation(stage)
