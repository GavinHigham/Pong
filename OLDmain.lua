standardPaddle = {x =  50, y = 225, w = 30, h = 150}
standardBall = {x = 400, y = 300, r = 15}
--Score:
--Player 1, Player 2.
function newBall(ball)
	local body = love.physics.newBody(world, ball.x, ball.y, 'dynamic')
	body:applyLinearImpulse(love.math.random(-50, 50), love.math.random(-50, 50))
	local shape = love.physics.newCircleShape(ball.r)
	local density = 1
	local fixture = love.physics.newFixture(body, shape, density)
	return fixture
end

function newPaddle(paddle)
	local body = love.physics.newBody(world, paddle.x, paddle.y, 'dynamic')
	local shape = love.physics.newRectangleShape(paddle.w, paddle.h)
	local density = 1
	local fixture = love.physics.newFixture(body, shape, density)
	return fixture
end

function newWall(x, y, w, h)
	local body = love.physics.newBody(world, x, y, 'static')
	local shape = love.physics.newRectangleShape(w, h)
	local density = 1
	local fixture = love.physics.newFixture(body, shape, density)
	return fixture
end

function love.load()
	-- New world, no gravity.
	world = love.physics.newWorld()
	world:setGravity(0, 0)
	--Make paddles
	paddle1 = newPaddle(standardPaddle)
	paddle2 = newPaddle(standardPaddle)
	paddle2:getBody():setX(700)
	--Make first ball
	ball = newBall(standardBall)
	--Make walls.
	wall = {w = 800, h = 70}
	wall1 = newWall(0,            0, wall.w, wall.h)
	wall2 = newWall(0, 600 - wall.h, wall.w, wall.h)
end

function love.update(dt)
	world:update(dt)
	if love.keyboard.isDown(";") then paddle1:getBody():applyLinearImpulse(0, 50) end
	if love.keyboard.isDown("q") then paddle1:getBody():applyLinearImpulse(0,-50) end
end

function love.draw()
	--Draw paddles
	love.graphics.rectangle("fill", paddle1:getBody():getX(), paddle1:getBody():getY()-40, standardPaddle.w, standardPaddle.h)
	love.graphics.rectangle("fill", paddle2:getBody():getX(), paddle2:getBody():getY(), standardPaddle.w, standardPaddle.h)
	--Draw ball(s)
	love.graphics.circle("fill", ball:getBody():getX(), ball:getBody():getY(), standardBall.r, 36)
	--Draw walls
	love.graphics.rectangle("fill", wall1:getBody():getX(), wall1:getBody():getY(), wall.w, wall.h)
	love.graphics.rectangle("fill", wall2:getBody():getX(), wall2:getBody():getY(), wall.w, wall.h)
	--Draw score
	--TODO
end