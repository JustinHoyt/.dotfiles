function fish_surround_iW
    # Expects 1 argument: the "start" surrounding character.
    # We'll derive the matching "end" character if it's a bracket or parenthesis.

    set start_char $argv[1]
    set end_char   $start_char

    switch $start_char
        case '('
            set end_char ')'
        case '['
            set end_char ']'
        case '{'
            set end_char '}'
        case '<'
            set end_char '>'
        case '"'
            set end_char '"'
        case "'"
            set end_char "'"
        case '`'
            set end_char '`'
    end

    # Current command line and cursor position
    set line (commandline)
    set pos  (commandline -C)

    if test -z "$line"
        return
    end

    set length (string length -- "$line")

    # ------------------------------------------
    # 1. Find the left boundary
    #    We'll walk left until we find whitespace or reach the start.
    # ------------------------------------------
    set left (math $pos - 1)
    while test $left -ge 0
        # Fish substring is 1-based
        set c (string sub -s (math $left + 1) -l 1 -- "$line")

        # If c is whitespace, stop
        if string match -qr '^[ \t]$' -- "$c"
            break
        end
        set left (math $left - 1)
    end

    # ------------------------------------------
    # 2. Find the right boundary
    #    We'll walk right until we find whitespace or reach the end.
    # ------------------------------------------
    set right $pos
    while test $right -lt $length
        set c (string sub -s (math $right + 1) -l 1 -- "$line")
        if string match -qr '^[ \t]$' -- "$c"
            break
        end
        set right (math $right + 1)
    end

    # The region to wrap is [left+1 .. right].
    set before (string sub -s 1 -l $left -- "$line")
    set word (string sub -s (math $left + 1) -l (math $right - $left) -- "$line")
    set after (string sub -s (math $right + 1) -- "$line")

    # Surround that region
    set new_line "$before$start_char$word$end_char$after"
    commandline -r -- "$new_line"

    # Move cursor just after the newly inserted end_char
    set new_cursor (math (string length "$before") + 1 + (string length "$word"))
    commandline -C $new_cursor
end
