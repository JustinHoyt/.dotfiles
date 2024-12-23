function fish_surround_line
    # This function expects 1 argument: the starting (left) character.
    # We derive the matching "end" character if needed.

    set start_char $argv[1]
    set end_char   $start_char

    # Handle matching pairs (parentheses, brackets, braces, angle brackets)
    switch $start_char
        case '('
            set end_char ')'
        case '['
            set end_char ']'
        case '{'
            set end_char '}'
        case '<'
            set end_char '>'
        # For quotes (double, single, backtick), the start and end are the same
        case '"'
            set end_char '"'
        case "'"
            set end_char "'"
        case '`'
            set end_char '`'
    end

    # Grab the entire command line
    set line (commandline)

    # If the line is empty, do nothing
    if test -z "$line"
        return
    end

    # Surround the entire line
    set new_line "$start_char$line$end_char"
    commandline -r -- "$new_line"

    # Optionally, move cursor to a sensible position
    # For example, just after the closing character
    set new_cursor (math 1 + (string length "$line"))
    commandline -C $new_cursor
end
