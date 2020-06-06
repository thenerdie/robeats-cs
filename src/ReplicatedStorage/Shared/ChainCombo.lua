local ChainCombo = {}

function ChainCombo:get_chain_target_scale(chain)
	if chain > 100 then
		return 1.35
	elseif chain > 60 then
		return 1.25
	elseif chain > 30 then
		return 1.15
	elseif chain > 10 then
		return 1.0
	elseif chain > 5 then
		return 0.925
	else
		return 0.85
	end
end

function ChainCombo:notif_index(chain)
	if chain > 60 then
		return 4
	elseif chain > 30 then
		return 3
	elseif chain > 10 then
		return 2
	else
		return 1
	end
end

return ChainCombo
