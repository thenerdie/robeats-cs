local NoteResult = {
	Miss = 1;
	Okay = 2;
	Good = 3;
	Great = 4;
	Perfect = 5;
	Marvelous = 6;
}

function NoteResult:timedelta_to_result(time_to_end, _game)
	time_to_end = time_to_end / _game._audio_manager.get_song_rate()
	if time_to_end >= _game._audio_manager.NOTE_OKAY_MIN and time_to_end <= _game._audio_manager.NOTE_OKAY_MAX then
		local note_result = nil			
		
		if time_to_end > _game._audio_manager.NOTE_OKAY_MIN and time_to_end <= _game._audio_manager.NOTE_GOOD_MIN then
			note_result = NoteResult.Okay	
		elseif time_to_end > _game._audio_manager.NOTE_GOOD_MIN and time_to_end <= _game._audio_manager.NOTE_GREAT_MIN then
			note_result = NoteResult.Good						
		elseif time_to_end > _game._audio_manager.NOTE_GREAT_MIN and time_to_end <= _game._audio_manager.NOTE_PERFECT_MIN then
			note_result = NoteResult.Great							
		elseif time_to_end > _game._audio_manager.NOTE_PERFECT_MIN and time_to_end <= _game._audio_manager.NOTE_MARVELOUS_MIN then
			note_result = NoteResult.Perfect	
		elseif time_to_end > _game._audio_manager.NOTE_MARVELOUS_MIN and time_to_end <= _game._audio_manager.NOTE_MARVELOUS_MAX then
			note_result = NoteResult.Marvelous						
		elseif time_to_end > _game._audio_manager.NOTE_MARVELOUS_MAX and time_to_end <= _game._audio_manager.NOTE_PERFECT_MAX then
			note_result = NoteResult.Perfect		
		elseif time_to_end > _game._audio_manager.NOTE_PERFECT_MAX and time_to_end <= _game._audio_manager.NOTE_GREAT_MAX then
			note_result = NoteResult.Great			
		elseif time_to_end > _game._audio_manager.NOTE_GREAT_MAX and time_to_end <= _game._audio_manager.NOTE_GOOD_MAX then
			note_result = NoteResult.Good				
		elseif time_to_end > _game._audio_manager.NOTE_OKAY_MAX and time_to_end <= _game._audio_manager.NOTE_OKAY_MAX then
			note_result = NoteResult.Okay
		else
			note_result = NoteResult.Miss
		end
		
		return true, note_result
	end	
	
	return false, NoteResult.Miss
end

function NoteResult:release_timedelta_to_result(time_to_end, _game)
	time_to_end = time_to_end / _game._audio_manager.get_song_rate()
	if time_to_end >= _game._audio_manager.NOTE_OKAY_MIN * 2.0 and time_to_end <= _game._audio_manager.NOTE_OKAY_MAX * 2.0 then
		local note_result = nil			
		
		if time_to_end > _game._audio_manager.NOTE_OKAY_MIN * 2.0 and time_to_end <= _game._audio_manager.NOTE_GOOD_MIN * 2.0 then
			note_result = NoteResult.Okay	
		elseif time_to_end > _game._audio_manager.NOTE_GOOD_MIN * 2.0 and time_to_end <= _game._audio_manager.NOTE_GREAT_MIN * 2.0 then
			note_result = NoteResult.Good						
		elseif time_to_end > _game._audio_manager.NOTE_GREAT_MIN * 2.0 and time_to_end <= _game._audio_manager.NOTE_PERFECT_MIN * 2.0 then
			note_result = NoteResult.Great							
		elseif time_to_end > _game._audio_manager.NOTE_PERFECT_MIN * 2.0 and time_to_end <= _game._audio_manager.NOTE_MARVELOUS_MIN * 2.0 then
			note_result = NoteResult.Perfect	
		elseif time_to_end > _game._audio_manager.NOTE_MARVELOUS_MIN * 2.0 and time_to_end <= _game._audio_manager.NOTE_MARVELOUS_MAX * 2.0 then
			note_result = NoteResult.Marvelous						
		elseif time_to_end > _game._audio_manager.NOTE_MARVELOUS_MAX * 2.0 and time_to_end <= _game._audio_manager.NOTE_PERFECT_MAX * 2.0 then
			note_result = NoteResult.Perfect		
		elseif time_to_end > _game._audio_manager.NOTE_PERFECT_MAX * 2.0 and time_to_end <= _game._audio_manager.NOTE_GREAT_MAX * 2.0 then
			note_result = NoteResult.Great			
		elseif time_to_end > _game._audio_manager.NOTE_GREAT_MAX * 2.0 and time_to_end <= _game._audio_manager.NOTE_GOOD_MAX * 2.0 then
			note_result = NoteResult.Good				
		else
			note_result = NoteResult.Okay
		end
		
		return true, note_result
	end	
	
	return false, NoteResult.Miss
end

return NoteResult
