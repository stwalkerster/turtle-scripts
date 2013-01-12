local length = 18

turtle.up()

for d = 0, length do

	-- dig centre
	while turtle.detect() do
		turtle.dig();
	end
	
	while not turtle.forward() do end
	
	while turtle.detectUp() do
		turtle.digUp();
	end

	while turtle.detectDown() do
		turtle.digDown();
	end	
end

turtle.down();