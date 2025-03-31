function silent_background
    fish -c "$argv" &
    disown
end
