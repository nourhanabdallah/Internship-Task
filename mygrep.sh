#!/bin/bash

show_help() {
    echo "Usage: $0 [options] search_string filename"
    echo
    echo "Options:"
    echo "  -n     Show line numbers"
    echo "  -v     Invert match (show non-matching lines)"
    echo "  --help Show this help message"
}

# Initialize flags
show_line_numbers=false
invert_match=false

# Parse options
while [[ "$1" == -* ]]; do
    case "$1" in
        -n) show_line_numbers=true ;;
        -v) invert_match=true ;;
        --help) show_help; exit 0 ;;
        -*) 
            # Support combined options like -vn or -nv
            for ((i=1; i<${#1}; i++)); do
                opt="${1:i:1}"
                case "$opt" in
                    n) show_line_numbers=true ;;
                    v) invert_match=true ;;
                    *) echo "Unknown option: -$opt"; exit 1 ;;
                esac
            done
            ;;
    esac
    shift
done

# After options, expect search_string and filename
if [[ $# -lt 2 ]]; then
    echo "Error: Missing search string or filename."
    echo "Use --help for usage."
    exit 1
fi

search_string="$1"
file="$2"

# Check if file exists
if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Process the file
while IFS= read -r line; do
    ((line_number++))
    
    # Lowercase both for case-insensitive match
    if [[ "${line,,}" =~ ${search_string,,} ]]; then
        match=true
    else
        match=false
    fi

    # Here: check condition based on invert
    if { $match && ! $invert_match; } || { ! $match && $invert_match; }; then
        if $show_line_numbers; then
            echo "${line_number}:$line"
        else
            echo "$line"
        fi
    fi
done < "$file"

