function fish_surround_iw
    # This function expects 1 argument: the 'start' surrounding character.
    # If the 'start' and 'end' are different (e.g. '(' -> ')'), we'll handle that via a small switch.

    set start_char $argv[1]
    set end_char   $start_char

    # If we want to handle matching pairs, do so here:
    switch $start_char
        case '('
            set end_char ')'
        case '['
            set end_char ']'
        case '{'
            set end_char '}'
        case '<'
            set end_char '>'
        # For quotes, single or double, the start and end are the same:
        case '"'
            set end_char '"'
        case "'"
            set end_char "'"
        case '`'
            set end_char '`'
    end

    # Grab the entire command line and current cursor position
    set line (commandline)
    set pos  (commandline -C)

    if test -z "$line"
        return
    end

    set length (string length -- "$line")

    # ------------------------------------------
    # 1. Find the start of the "inside word"
    #    We'll walk left as long as it's [[:alnum:]_].
    # ------------------------------------------
    set left (math $pos - 1)
    while test $left -ge 0
        # Fish substr is 1-based, so +1 for string sub
        set c (string sub -s (math $left + 1) -l 1 -- "$line")

        if not string match -qr '^[[:alnum:]_]$' -- "$c"
            break
        end
        set left (math $left - 1)
    end
    set left (math $left + 1)

    # After this loop, $left is at the index of the boundary character
    # or -1 if we hit the start of the line.
    # So the first character INSIDE the word is left+1.

    # ------------------------------------------
    # 2. Find the end of the "inside word"
    #    We'll walk right as long as it's [[:alnum:]_].
    # ------------------------------------------
    set right $pos
    while test $right -lt $length
        set c (string sub -s (math $right + 1) -l 1 -- "$line")
        if not string match -qr '^[[:alnum:]_]$' -- "$c"
            break
        end
        set right (math $right + 1)
    end

    # The region to wrap is [left+1 .. right].
    # We'll split the line into:
    #   before   = substring [1..left]
    #   word     = substring [left+1..right]
    #   after    = substring [right+1..end]

    set before (string sub -s 1 -l $left -- "$line")
    set word (string sub -s (math $left + 1) -l (math $right - $left) -- "$line")
    set after (string sub -s (math $right + 1) -- "$line")

    # Rebuild the line with surrounding characters
    set new_line "$before$start_char$word$end_char$after"
    commandline -r -- "$new_line"

    # Move the cursor just after the "end_char"
    set new_cursor (math (string length "$before") + 1 + (string length "$word"))
    commandline -C $new_cursor
end
