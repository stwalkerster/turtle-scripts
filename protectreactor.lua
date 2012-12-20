--[[

  OK, program to build the reactor shielding.
	
	Turtle can place in front, above or below.
	Turtle can move forward, back, up or down.
	
	We want to minimise time spent turning around.
	
	Lets do this by making the turtle do a wall at a time.
	
	]]

-- functions
function tlDig()	
	while turtle.detect() do
		turtle.dig();
	end
end

function tlDigBelow()	
	while turtle.detectDown() do
		turtle.digDown();
	end
end
function tlDigAbove()	
	while turtle.detectUp() do
		turtle.digUp();
	end
end

function tlDigForward()
	while not turtle.forward() do
		tlDig();
	end
end

function tlDigDown()
	while not turtle.down() do
		tlDigBelow();
	end
end
function tlDigUp()
	while not turtle.up() do
		tlDigAbove();
	end
end

function tlForward()
	while not turtle.forward() do end
end

function tlBack()
	while not turtle.back() do end
end

function tlUp()
	while not turtle.up() do end
end

function tlDown()
	while not turtle.down() do end
end

local currentSlot = 1;
turtle.select(currentSlot);
function tlSelectAny()
	if turtle.getItemCount(currentSlot) > 0 then
		return
	end

	for slot = 1, 9 do
		if turtle.getItemCount(slot) > 0 then
			turtle.select(slot);
			currentSlot = slot;
			return;
		end
	end

	term.write("Please refill me!");
	
	turtle.select(1);
	
	while turtle.getItemCount(slot) == 0 do
		sleep(5);
	end
	
	return;
end

function tlPlaceAny()
	
	tlSelectAny();
	
	turtle.place();
end

function fillBase()
	for z = 1, 4 do
		for y = 1, 11 do
			-- move to just in front of the back wall
			for x = 1, 9 do
				tlForward();
			end

			-- move backwards, plaing as we go
			for x = 1, 9 do
				if y == 6 and x == 6 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			end

			-- place the last couple
			tlPlaceAny();
			
			if y ~= 11 then
				turtle.turnLeft();
				tlBack();
				tlPlaceAny();
				turtle.turnRight();
			end
		end

		tlDigUp()
		tlSelectAny()
		turtle.placeDown();
		turtle.turnLeft();

		-- go back to the start
		for y = 1, 10 do tlDigForward() end

		turtle.turnRight();
	end
end

function fillReactorLevelOne()
	for y = 1, 11 do
		-- move to just in front of the back wall
		for x = 1, 9 do
			tlForward();
		end

		-- move backwards, plaing as we go
		for x = 1, 9 do
			if x == 5 then
				if y < 8 and y > 4 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			elseif x == 6 then
				if y < 8 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			elseif x == 7 then
				if y < 8 and y > 4 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			else
				tlPlaceAny();
				tlBack();
			end
		
		end

		-- place the last couple
		tlPlaceAny();
		
		if y ~= 11 then
			turtle.turnLeft();
			tlBack();
			tlPlaceAny();
			turtle.turnRight();
		end
	end

	tlUp()
	tlSelectAny()
	turtle.placeDown();
	turtle.turnLeft();

	-- go back to the start
	for y = 1, 10 do tlForward() end

	turtle.turnRight();
end

function fillReactorLevelTwo()
	for y = 1, 11 do
		if y ~= 6 then
		
			-- move to just in front of the back wall
			for x = 1, 9 do
				tlForward();
			end

			-- move backwards, plaing as we go
			for x = 1, 9 do
				if x == 5 then
					if y < 8 and y > 4 then
						tlBack();
					else
						tlPlaceAny();
						tlBack();
					end
				elseif x == 6 then
					tlBack();
				elseif x == 7 then
					if y < 8 and y > 4 then
						tlBack();
					else
						tlPlaceAny();
						tlBack();
					end
				else
					tlPlaceAny();
					tlBack();
				end
			
			end

			-- place the last couple
			tlPlaceAny();
			
			if y ~= 11 then
				turtle.turnLeft();
				tlBack();
				tlPlaceAny();
				turtle.turnRight();
			end
		else
			turtle.turnRight();
			tlForward();
			turtle.turnLeft();
		end
	end

	tlUp()
	tlSelectAny()
	turtle.placeDown();
	turtle.turnLeft();

	-- go back to the start
	for y = 1, 10 do tlForward() end

	turtle.turnRight();
end

function fillReactorLevelThree()
	for y = 1, 11 do
		-- move to just in front of the back wall
		for x = 1, 9 do
			tlForward();
		end

		-- move backwards, plaing as we go
		for x = 1, 9 do
			if x == 5 then
				if y < 8 and y > 4 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			elseif x == 6 then
				if y < 8 and y > 4 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			elseif x == 7 then
				if y < 8 and y > 4 then
					tlBack();
				else
					tlPlaceAny();
					tlBack();
				end
			else
				tlPlaceAny();
				tlBack();
			end
		
		end

		-- place the last couple
		tlPlaceAny();
		
		if y ~= 11 then
			turtle.turnLeft();
			tlBack();
			tlPlaceAny();
			turtle.turnRight();
		end
		
	end

	tlUp()
	tlSelectAny()
	turtle.placeDown();
	turtle.turnLeft();

	-- go back to the start
	for y = 1, 10 do tlForward() end

	turtle.turnRight();
end

-- do work!

fillBase()
