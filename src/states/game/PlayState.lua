PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.level = Level()

	gSounds['field-music']:setLooping(true)
	gSounds['field-music']:play()

	-- self.dialogueOpened = false
end

function PlayState:update(dt)
end

function PlayState:render()
	self.level:render()
end