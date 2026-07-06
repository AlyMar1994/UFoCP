---@meta
---@diagnostic disable: lowercase-global, missing-return, duplicate-set-field

---Pauses or resumes weather audio
---@param pause boolean true for pausing, false for resuming
function Weather_Audio_Pause(pause)
end

---@deprecated
---Broken function, throws "preserved_volume != VOLUME_INVALID".
function Master_Volume_Restore()
end

---Turns on or off localized SFX.
---@param allow boolean
function Allow_Localized_SFX(allow)
end

---Removes screen texts.
function Remove_All_Text()
end

---Stops all speach events.
function Stop_All_Speech()
end

---Turns back on the music based on mode.
function Resume_Mode_Based_Music()
end

---Stops all music from playing.
function Stop_All_Music()
end

---Plays a music event from MusicEvents.xml
---@param music_event string
function Play_Music(music_event)
end

---Stops the displayed bink movie.
function Stop_Bink_Movie()
end

---Plays a movie event from Movies.xml.
---@param movie string
---@return CommandBlock
function Play_Bink_Movie(movie)
end