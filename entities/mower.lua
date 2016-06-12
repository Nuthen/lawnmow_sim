Mower = class('Mower')

function Mower:initialize()
	local width, height = love.graphics.getDimensions()
	self.position = vector(width/2, height/2)

    self.chopRadius = 50

    self.heading = 0
    self.turnSpeed = 100
    self.moveSpeed = 80
end

function Mower:update(dt)
    if love.keyboard.isDown('left') then  self.heading = self.heading - self.turnSpeed * dt end
    if love.keyboard.isDown('right') then self.heading = self.heading + self.turnSpeed * dt end

    local rad = math.rad(self.heading)
    local vel = vector(math.cos(rad), math.sin(rad)) * self.moveSpeed

    self.position = self.position + vel * dt

    return self.position
end

function Mower:draw()
    love.graphics.circle('fill', self.position.x, self.position.y, self.chopRadius)
end