StartState = Class{__includes = BaseState}

function StartState:init()
	gSounds['intro-music']:play()

	self.sprite = POKEMON_DEFS[POKEMON_IDS[math.random(#POKEMON_IDS)]].battleSpriteFront
	self.spriteX = VIRTUAL_WIDTH / 2 - 32
	self.spriteY = VIRTUAL_HEIGHT / 2 - 16

	self.tween = Timer.every(3, function()
		Timer.tween(0.2, {
			[self] = {spriteX = -64}
		})
		:finish(function()
			self.sprite = POKEMON_DEFS[POKEMON_IDS[math.random(#POKEMON_IDS)]].battleSpriteFront
			self.spriteX = VIRTUAL_WIDTH
			self.spriteY = VIRTUAL_HEIGHT / 2 - 16

			Timer.tween(0.2, {
				[self] = {spriteX = VIRTUAL_WIDTH / 2 - 32}
			})
		end)
	end)
end

function StartState:update(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateStack:push(FadeInState({
			r = 1, g = 1, b = 1
		}, 1,
		function()
			gSounds['intro-music']:stop()
			self.tween:remove()

			gStateStack:pop()
			gStateStack:push(PlayState())
			--aS
			gStateStack:push(FadeOutState({
				r = 1, g = 1, b = 1
			}, 1,
			function() end))
		end))
	end
end

function StartState:render()
	love.graphics.clear(0.75, 0.75, 0.75, 1)

	love.graphics.setColor(0.1, 0.1, 0.1, 1)
	love.graphics.setFont(gFonts['large'])
	love.graphics.printf('50-Mon!', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(gFonts['medium'])
	love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(gFonts['small'])

	love.graphics.setColor(0.2, 0.75, 0.2, 0.5)
	love.graphics.ellipse('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + 32, 72, 24)

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(gTextures[self.sprite], self.spriteX, self.spriteY)
end