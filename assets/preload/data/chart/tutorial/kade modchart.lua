function onUpdate(elapsed)
    if difficulty == 2 and curStep > 400 then
        local currentBeat = ((getSongPosition()) / 1000) * (bpm/60)
        for i=0,7 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") + math.sin(currentBeat + i * 32) * 0.25 * math.pi)
            setPropertyFromGroup("strumLineNotes", i, "y", getPropertyFromGroup("strumLineNotes", i, "y") + math.cos(currentBeat + i * 32) * 0.25 * math.pi)
        end
    end
end