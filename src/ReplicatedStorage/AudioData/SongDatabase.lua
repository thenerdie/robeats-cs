local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SongErrorParser = require(game.ReplicatedStorage.AudioData.SongErrorParser)

local SongDatabase = {}

SongDatabase.MOD_NORMAL = 0
SongDatabase.MOD_HARDMODE = 1

function SongDatabase:new()
	local self = {}

	local _all_keys = SPDict:new()
	local _key_list = SPList:new()
	local _name_to_key = SPDict:new()
	local _key_to_fusionresult = SPDict:new()

	local _song_names = game.ReplicatedStorage.LocalStorage.Songs:GetChildren()

	function self:cons()
		for i=1,#_song_names do
			local itr_name = _song_names[i].Name
			local audio_data = require(game.ReplicatedStorage.LocalStorage.Songs[itr_name])
			SongErrorParser:scan_audiodata_for_errors(audio_data)
			self:add_key_to_data(i,audio_data)
			_name_to_key:add(itr_name,i)
		end

		for i=1,#_song_names do
			local itr_name = _song_names[i].Name
			local itr_key = i
			local audio_data = require(game.ReplicatedStorage.LocalStorage.Songs[itr_name])
			if audio_data.FusionResult ~= nil then
				local itr_fusion_result_name = audio_data.FusionResult
				if _name_to_key:contains(itr_fusion_result_name) == false then
					error("Unknown fusion result",itr_fusion_result_name,"for",itr_name)
				end
				local itr_fusion_result_key = _name_to_key:get(itr_fusion_result_name)

				local itr_fusion_count = audio_data.FusionCount
				if itr_fusion_count == nil then
					itr_fusion_count = 5
				end

				_key_to_fusionresult:add(itr_key, {
					RequiredCount = itr_fusion_count;
					OutputKey = itr_fusion_result_key;
				})
			end
		end
	end

	function self:add_key_to_data(key,data)
		if _all_keys:contains(key) then
			error("SongDatabase:add_key_to_data duplicate",key)
		end
		_all_keys:add(key,data)
		data.__key = key
		_key_list:push_back(key)
	end

	function self:all_keys()
		return _key_list
	end

	function self:get_data_for_key(key)
		return _all_keys:get(key)
	end

	function self:contains_key(key)
		return _all_keys:contains(key)
	end

	function self:key_has_combineinfo(key)
		--return true, { RequiredCount = 2; OutputKey = 1; }
		if _key_to_fusionresult:contains(key) then
			return true, _key_to_fusionresult:get(key)
		end
		return false, nil
	end

	function self:key_is_debug(key)
		return key == 4
	end

	function self:key_get_audiomod(key)
		local data = self:get_data_for_key(key)
		if data.AudioMod == 1 then
			return SongDatabase.MOD_HARDMODE
		end
		return SongDatabase.MOD_NORMAL
	end

	function self:render_coverimage_for_key(cover_image, overlay_image, key)
		local songdata = self:get_data_for_key(key)
		cover_image.Image = songdata.AudioCoverImageAssetId

		local audiomod = self:key_get_audiomod(key)
		if audiomod == SongDatabase.MOD_HARDMODE then
			overlay_image.Image = "rbxgameasset://Images/COVER_hardmode_overlay"
			overlay_image.Visible = true
		else
			overlay_image.Image = "rbxgameasset://Images/COVER_hardmode_overlay"
			overlay_image.Visible = false
		end
	end

	function self:get_title_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioFilename
	end

	function self:get_artist_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioArtist
	end

	function self:get_difficulty_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioDifficulty
	end

	function self:get_description_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioDescription
	end

	function self:get_songdatabase_info()
		local rtv = {}
		for i=1,#_song_names do
			local audio_data = self:get_data_for_key(i)

			local audio_mod = audio_data.AudioMod
			if audio_mod == nil then
				audio_mod = SongDatabase.MOD_NORMAL
			end

			table.insert(rtv, i, {
				["songid"] = i;
				["songname"] = _song_names[i];
				["audiomod"] = audio_mod;
			})
		end
		return rtv
	end

	self:cons()
	return self
end

local _singleton = SongDatabase:new()
function SongDatabase:singleton()
	return _singleton
end

return SongDatabase
