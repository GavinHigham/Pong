player1Score = 0
player2Score = 0
paddle1 = {x =   50, y = 225, w = 30, h = 150, s = 10} --x, y, width, height, speed.
paddle2 = {x =  700, y = 225, w = 30, h = 150, s = 10} --x, y, width, height, speed.
ball = {x = 400, y = 300, vx = 0, vy = 0, r = 15} --x, y, x-velocity, y-velocity, radius.
wall1 = {x = 0, y = 0, w = 800, h = 70} --x, y, width, height.
wall2 = {x = 0, y = 530, w = 800, h = 70} --x, y, width, height.

--Returns true if two bounding boxes are intersecting, else returns false.
function boxColliding(b1, b2)
	return ((b2.x > b1.x and b2.x < b1.x + b1.w) or
	        (b2.x < b1.x and b1.x < b2.x + b2.w)) and
	       ((b2.y > b1.y and b2.y < b1.y + b1.h) or
	        (b2.y < b1.y and b1.y < b2.y + b2.h))
end

--Checks keyboard input, and controls a few game things.
function playerInput()
	--Player 1 paddle up and down control. Stops at walls.
	if love.keyboard.isDown(";") and paddle1.y + paddle1.h < wall2.y then paddle1.y = paddle1.y + 10 end
	if love.keyboard.isDown("q") and paddle1.y > wall1.h then paddle1.y = paddle1.y - 10 end
	--Player 2 paddle up and down control. Stops at walls.
	if love.keyboard.isDown("down") and paddle2.y + paddle2.h < wall2.y then paddle2.y = paddle2.y + 10 end
	if love.keyboard.isDown("up") and paddle2.y > wall1.h then paddle2.y = paddle2.y - 10 end
	--Reset the ball with space key if it is immobile.
	if love.keyboard.isDown(" ") and ball.vx == 0 and ball.vy == 0 then
		ball.vx = math.random(-6, 6) --Give it random x velocity between -6 and 6.
		ball.vy = math.random(-6, 6) --Give it random y velocity between -6 and 6.
	end
end

--Update callback. Called 60 times a second, does game logic.
function love.update(dt)
	--Update the ball position.
	ball.x = ball.x + ball.vx
	ball.y = ball.y + ball.vy
	--Bounce the ball off of the walls.
	if ball.y + ball.r > wall2.y or ball.y - ball.r < wall1.h then ball.vy = -ball.vy end
	--If the ball hits the right edge, player 1 scores a point, reset the ball.
	if ball.x + ball.r > 800 then
		player1Score = player1Score + 1
		ball = {x = 400, y = 300, vx = 0, vy = 0, r = 15}
	end
	--If the ball hits the left edge, player 2 scores a point, reset the ball.
	if ball.x - ball.r <  0 then
		player2Score = player2Score + 1
		ball = {x = 400, y = 300, vx = 0, vy = 0, r = 15}
	end
	--Calculate a bounding box for the ball.
	local ballBoundingBox = {x = ball.x-ball.r, y = ball.y-ball.r, w = 2*ball.r, h = 2*ball.r}
	--Check collision between the ball and each paddle, and send the ball in the appropriate direction.
	--If you wanted to add velocity or spin to the ball when it hits a paddle, this is where you would do it.
	if boxColliding(paddle1, ballBoundingBox) then ball.vx = math.abs(ball.vx) end
	if boxColliding(paddle2, ballBoundingBox) then ball.vx = -math.abs(ball.vx) end
	--Call the player input function defined above.
	playerInput()
end

function love.draw()
	--Set the color to white, for the ball, paddles, and walls.
	love.graphics.setColor(255, 255, 255)
	--Draw the paddles.
	love.graphics.rectangle("fill", paddle1.x, paddle1.y, paddle1.w, paddle1.h)
	love.graphics.rectangle("fill", paddle2.x, paddle2.y, paddle2.w, paddle2.h)
	--Draw the walls.
	love.graphics.rectangle("fill", wall1.x, wall1.y, wall1.w, wall1.h)
	love.graphics.rectangle("fill", wall2.x, wall2.y, wall2.w, wall2.h)
	--Draw the ball.
	love.graphics.circle("fill", ball.x, ball.y, ball.r, 120)
	--Set the color to white, for the score display.
	love.graphics.setColor(0, 0, 0)
	love.graphics.printf("P1: " .. player1Score .. "  P2: " .. player2Score, 280, 15, 400, "left", 0, 3, 3, 0, 0, 0, 0)
end
