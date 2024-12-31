#!/bin/bash

# Display the banner
display_banner() {
    echo "##########################################"
    echo "#              CorsScan 🛡️               #"
    echo "#       https://github.com/yogsec        #"
    echo "##########################################"
    echo ""
}

# Display help section
show_help() {
    echo "Usage: ./cors.sh [OPTIONS]"
    echo "Options:"
    echo "  -h          Show help section."
    echo "  -w <file>   Execute the code with the specified Url list file."
    echo "  -v          Show script version."
    echo "  -s <file>   Save the output to the specified file."
    echo "  -c <n>      Number of concurrent threads (default: 10)."
}

# Script version
version="2.0"

# Variables
output_file=""
urls_file=""
threads=10
origin="https://target.com"

# Display banner at the start
display_banner

# Parse arguments
while getopts "hw:v:s:c:" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        w)
            urls_file=$OPTARG
            ;;
        v)
            echo "Script Version: $version"
            exit 0
            ;;
        s)
            output_file=$OPTARG
            ;;
        c)
            threads=$OPTARG
            ;;
        *)
            show_help
            exit 1
            ;;
    esac
done

# Validate inputs
if [ -z "$urls_file" ]; then
    echo "Error: No wordlist file provided. Use -w <file>."
    exit 1
fi

if [ ! -f "$urls_file" ]; then
    echo "Error: File $urls_file does not exist."
    exit 1
fi

# Function to process a single URL
process_url() {
    local url=$1
    response=$(curl -s -o /dev/null -D - -H "Origin: $origin" "$url")
    cors_header=$(echo "$response" | grep -i 'access-control-allow-origin')
    allow_methods=$(echo "$response" | grep -i 'access-control-allow-methods')
    allow_headers=$(echo "$response" | grep -i 'access-control-allow-headers')
    allow_credentials=$(echo "$response" | grep -i 'access-control-allow-credentials')

    output=""

    if [[ "$cors_header" =~ \* ]]; then
        output+="$url has CORS misconfiguration: wildcard (*) in Access-Control-Allow-Origin\n"
    elif [[ "$cors_header" =~ "$origin" ]]; then
        output+="$url reflects the origin in Access-Control-Allow-Origin\n"
    fi

    if [[ "$allow_methods" =~ "PUT" || "$allow_methods" =~ "DELETE" ]]; then
        output+="$url allows unsafe methods in Access-Control-Allow-Methods: $allow_methods\n"
    fi

    if [[ "$allow_headers" =~ \* ]]; then
        output+="$url allows all headers in Access-Control-Allow-Headers\n"
    fi

    if [[ "$allow_credentials" =~ "true" ]]; then
        output+="$url allows credentials with Access-Control-Allow-Credentials: true\n"
    fi

    if [ -n "$output" ]; then
        echo -e "$output"
        # Save to file if output_file is specified
        if [ -n "$output_file" ]; then
            echo -e "$output" >> "$output_file"
        fi
    fi
}

export -f process_url
export origin
export output_file

# Process URLs concurrently using xargs
cat "$urls_file" | xargs -P "$threads" -n 1 -I {} bash -c 'process_url "$@"' _ {}

echo "Processing completed."
