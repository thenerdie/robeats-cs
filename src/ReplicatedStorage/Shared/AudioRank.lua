local AudioRank = {}
AudioRank.APlus = "A+"
AudioRank.A = "A"
AudioRank.B = "B"
AudioRank.C = "C"
AudioRank.F = "F"

function AudioRank:score_to_rank(score,audio_data)
	if score >= audio_data.AudioRanks.APlus then
		return AudioRank.APlus
	elseif score >= audio_data.AudioRanks.A then
		return AudioRank.A
	elseif score >= audio_data.AudioRanks.B then
		return AudioRank.B
	elseif score >= audio_data.AudioRanks.C then		
		return AudioRank.C
	else
		return AudioRank.F
	end
end

function AudioRank:rank_to_value(rank)
	if rank == AudioRank.APlus then
		return 4
	elseif rank == AudioRank.A then
		return 3
	elseif rank == AudioRank.B then
		return 2
	elseif rank == AudioRank.C then
		return 1
	else
		return 0
	end
end

function AudioRank:rank_to_icon(rank)
	if rank == AudioRank.APlus then
		return "rbxgameasset://Images/TCUI_complete_rank_A+"
	elseif rank == AudioRank.A then
		return "rbxgameasset://Images/TCUI_complete_rank_A"
	elseif rank == AudioRank.B then
		return "rbxgameasset://Images/TCUI_complete_rank_B"
	elseif rank == AudioRank.C then
		return "rbxgameasset://Images/TCUI_complete_rank_C"
	else
		return "rbxgameasset://Images/TCUI_complete_rank_F"
	end
end

return AudioRank

