local SPMultiDict = require(game.ReplicatedStorage.Shared.SPMultiDict)
local SFXManager = {}

SFXManager.SFX_MISS = "rbxassetid://574838657"
SFXManager.SFX_BOO_1 = "rbxassetid://786602539"
SFXManager.SFX_BOO_1_VOLUME = 1

function SFXManager:new(game_element)
	local self = {}

	local _sfx_pooled_parent = Instance.new("Folder",game_element.Parent)
	_sfx_pooled_parent.Name = "SFXPooledParent"
	local _sfx_active_parent = Instance.new("Folder",game_element.Parent)
	_sfx_active_parent.Name = "SFXActiveParent"

	self._key_to_pooled_sound = SPMultiDict:new()
	self._key_to_active_sound = SPMultiDict:new()

	local function create_pooled(sfx_key, volume)
		if volume == nil then
			volume = 1
		end

		local rtv = Instance.new("Sound",_sfx_pooled_parent)
		rtv.SoundId = sfx_key
		rtv.Name = string.format("%s",sfx_key)
		rtv.Parent = _sfx_pooled_parent
		rtv.Playing = false
		if sfx_key == SFXManager.SFX_BOO_1 then
			rtv.Volume = SFXManager.SFX_BOO_1_VOLUME
		else
			rtv.Volume = volume
		end

		self._key_to_pooled_sound:push_back_to(sfx_key,rtv)
	end

	function self:cons()
		for i=0,3 do
			create_pooled(SFXManager.SFX_DRUM_OKAY,0.25)
			create_pooled(SFXManager.SFX_MISS)
		end
		for i=0,2 do
			create_pooled(SFXManager.SFX_COUNTDOWN_READY)
		end
		for i=0,1 do
			create_pooled(SFXManager.SFX_COUNTDOWN_GO)
		end

		create_pooled(SFXManager.SFX_COUNTDOWN_READY)
		create_pooled(SFXManager.SFX_COUNTDOWN_READY)
		create_pooled(SFXManager.SFX_COUNTDOWN_GO)

		create_pooled(SFXManager.SFX_WOOSH)
		create_pooled(SFXManager.SFX_BOO_1)
	end

	function self:preload(sfx_key, count, volume)
		for i=1,count do
			create_pooled(sfx_key,volume)
		end
	end

	function self:play_sfx(sfx_key,volume)
		if self._key_to_pooled_sound:count_of(sfx_key) == 0 then
			create_pooled(sfx_key)
		end

		local play_sfx = self._key_to_pooled_sound:pop_back_from(sfx_key)
		play_sfx.TimePosition = 0
		play_sfx.Looped = false
		play_sfx.Playing = false
		play_sfx.Parent = _sfx_active_parent
		if volume ~= nil then
			play_sfx.Volume = volume
		end

		self._key_to_active_sound:push_back_to(sfx_key,play_sfx)
		return play_sfx
	end

	function self:update(dt_scale)
		for itr_key,_ in self._key_to_active_sound:key_itr() do
			local itr_list = self._key_to_active_sound:list_of(itr_key)
			for i=itr_list:count(),1,-1 do
				local itr_sound = itr_list:get(i)
				if itr_sound.Looped == false and itr_sound.Playing == false then
					if _sfx_pooled_parent ~= nil then
						itr_sound.Parent = _sfx_pooled_parent
					end
					self._key_to_pooled_sound:push_back_to(itr_key,itr_sound)
					itr_list:remove_at(i)
				end
			end
		end
	end

	self:cons()
	return self;
end

return SFXManager
