paddle1 = {x =   50, y = 225, w = 30, h = 150}
paddle2 = {x =  700, y = 225, w = 30, h = 150}
ball = {x = 400, y = 300, vx = 3, vy = 5, r = 15}
wall = {w = 800, h = 70}
wall1 = {x = 0, y = 0, w = 800, h = 70}
wall2 = {x = 0, y = 530, w = 800, h = 70}

function boxColliding(b1, b2)
	return ((b2.x > b1.x and b2.x < b1.x + b1.w) or
	        (b2.x < b1.x and b1.x < b2.x + b2.w)) and
	       ((b2.y > b1.y and b2.y < b1.y + b1.h) or
	        (b2.y < b1.y and b1.y < b2.y + b2.h))
end

function edgesIntersecting(b1, b2)
	local left   = false
	local right  = false
	local top    = false
	local bottom = false

	if b2.x > b1.x and b2.x < b1.x + b1.w then right = true
	if b2.x < b1.x and b1.x < b2.x + b2.w then left = true
	if b2.y > b1.y and b2.y < b1.y + b1.h then top = true
	if b2.y < b1.y and b1.y < b2.y + b2.h then bottom = true
	return left, right, up, down
end

function love.update(dt)
	ball.x = ball.x + ball.vx
	ball.y = ball.y + ball.vy
	if ball.y + ball.r > 530 or ball.y - ball.r < 70 then ball.vy = -ball.vy end
	if ball.x + ball.r > 800 or ball.x - ball.r <  0 then ball.vx = -ball.vx end

	local ballBoundingBox = {x = ball.x-ball.r, y = ball.y-ball.r, w = 2*ball.r, h = 2*ball.r}
	if boxColliding(paddle1, ballBoundingBox) then
		ball.vx = -ball.vx
	end
	if boxColliding(paddle2, ballBoundingBox) then
		ball.vx = -ball.vx
	end
end

function love.draw()
	love.graphics.rectangle("fill", paddle1.x, paddle1.y, paddle1.w, paddle1.h)
	love.graphics.rectangle("fill", paddle2.x, paddle2.y, paddle2.w, paddle2.h)
	love.graphics.rectangle("fill", wall1.x, wall1.y, wall1.w, wall1.h)
	love.graphics.rectangle("fill", wall2.x, wall2.y, wall2.w, wall2.h)
	love.graphics.circle("fill", ball.x, ball.y, ball.r, 120)
end
