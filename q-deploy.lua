local stage = "Deploying to quarry"

turtle.forward();  tl.updateLocation(stage)
turtle.forward();  tl.updateLocation(stage)

while not turtle.compare() do if turtle.down() == false then break end tl.updateLocation(stage) end
turtle.down();  tl.updateLocation(stage)
turtle.down();  tl.updateLocation(stage)