Lawn = class('Lawn')

function Lawn:initialize()
	self.width, self.height = love.graphics.getDimensions()
	self.imageData = love.image.newImageData(self.width, self.height)

	self.totalGrass = self.width * self.height
	self.chopCount = 0

    self.map = {}
    for iy = 1, self.height do
    	self.map[iy] = {}
    	for ix = 1, self.width do
    		self.map[iy][ix] = 1
    		self.imageData:setPixel(ix-1, iy-1, 0, 255, 0, 255)
    	end
    end

    self.lawnImage = love.graphics.newImage(self.imageData)
end

function Lawn:chop(position, radius)
	local x, y = position:unpack()
	x, y = math.floor(x), math.floor(y)
	for iy = math.max(1, y - radius), math.min(self.height, y + radius) do
		for ix = math.max(1, x - radius), math.min(self.width, x + radius) do
			local dist = math.sqrt((y-iy)^2 + (x-ix)^2)
			if dist <= radius then
				local r, g, b, a = self.imageData:getPixel(ix-1, iy-1)

				if r == 0 then
					self.imageData:setPixel(ix-1, iy-1, 255, 255, 0, 255)
					self.chopCount = self.chopCount + 1
				end
			end
		end
	end

	self.lawnImage:refresh()
end

function Lawn:draw()
	love.graphics.draw(self.lawnImage)

	local chopPercent = self.chopCount / self.totalGrass
	chopPercent = math.floor(chopPercent * 1000) / 10
	love.graphics.print(chopPercent.. '%', 5, 40)
end