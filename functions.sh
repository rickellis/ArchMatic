#!/usr/bin/env bash

# TEXT COLORS ----------------------------------------------------------------------

RED="\033[91m" # Red
GRN="\033[92m" # Green
BLU="\033[94m" # Blue
YEL="\033[93m" # Yellow
ORG="\033[38;5;202m" # Orange
MAG="\033[95m" # Magenta
CYN="\033[96m" # Cyan
RST="\033[0m"  # Color Reset



# HEADING FUNCTION -----------------------------------------------------------------

# Shell Heading Generator, from my script library
# https://github.com/rickellis/Shell-Scripts/blob/master/sheading.sh
function sheading() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo 'Usage: heading <color> "Heading Text"'
        exit 1
    fi

    _color=${1,,} # lowercase
    _heading=${2}
    _h_length=${#_heading} # heading length
    _t_width=$(tput cols)  # terminal width

    # Set the minimum width the length of the header string
    if [ ! $_t_width -gt $_h_length ]; then
        _t_width=$_h_length
    fi

    # Calculate the padding necessary on either side of the heading
    l=$(( _t_width - _h_length )) 
    d=$(( l / 2 ))

    _padding=""
    for i in $(seq 1 ${d}); do 
        _padding+=" "
    done

    # Depending on the length of the terminal relative to the
    # length of the heading we might end up one character off.
    # To compensate we add one space to the right side
    _padextra=""
    _padlenth=${#_padding}
    _totlenth=$(( _padlenth * 2 + _h_length ))

    if [ $_t_width -ne $_totlenth ]; then
        _padextra=" ";
    fi

    if [ "$_color" == 'rnd' ] || [ "$_color" == "rand" ] || [ "$_color" == "random" ]; then
        _colors=( "gry" "chr" "red" "grn" "lim" "aqm" "olv" "blu" "sky" "cyn" "aqa" "gdr" "yel" "crl" "org" "pnk" "lav" "mag" "pur" )
        _color=${_colors[$RANDOM % ${#_colors[@]}]}
    fi

    # White text \e[97m
    # Black text: \e[38;5;232m

    case "$_color" in
        grey | gry)         _color="\e[48;5;240m\e[97m"            ;;
        charcoal | chr)     _color="\e[48;5;237m\e[97m"            ;;
        red)                _color="\e[48;5;1m\e[97m"              ;;
        green | grn)        _color="\e[48;5;22m\e[97m"             ;;
        lime | lim)         _color="\e[48;5;40m\e[38;5;232m"       ;;
        aquamarine | aqm)   _color="\e[48;5;120m\e[38;5;232m"      ;;
        olive | olv)        _color="\e[48;5;58m\e[97m"             ;;
        blue | blu)         _color="\e[44m\e[97m"                  ;;
        sky)                _color="\e[48;5;25m\e[97m"             ;;
        cyan | cyn)         _color="\e[46m\e[97m"                  ;;
        aqua | aqa)         _color="\e[48;5;87m\e[38;5;232m"       ;;
        goldenrod | gdr)    _color="\e[48;5;220m\e[38;5;232m"      ;;
        yellow | yel)       _color="\e[48;5;11m\e[38;5;232m"       ;;
        coral| crl)         _color="\e[48;5;3m\e[97m"              ;;
        orange | org)       _color="\e[48;5;202m\e[97m"            ;;
        pink | pnk)         _color="\e[48;5;200m\e[97m"            ;;
        lavender | lav)     _color="\e[48;5;141m\e[38;5;232m"      ;;
        magenta | mag)      _color="\e[45m\e[97m"                  ;;
        purple | pur)       _color="\e[48;5;53m\e[97m"             ;;
        *)                  _color="\e[48;5;237m\e[97m"            ;;
    esac

    echo
    echo -e "${_color}${_padding}${_heading}${_padding}${_padextra}\e[0m"
    echo
}

# # How to get a function to return a value
# function sometest() {
#     echo 0
# }

# result=$(sometest)
# if [ "$result" == 0 ]; then
#     echo 'success!'
# fi


# -------------------------------------------------------------------------


# foo="bar"
# setvar() {
#     #
#     # Delcare a variable and set its value, but
#     # only if the variable is empty or undefined.
#     # It uses indirect parameter expansion. The !
#     # means set the variable name, not just the value.
#     #
#     # Required arguments:
#     #   1. Variable name
#     #   2. Variable value
#     #
#     # Usage:
#     #
#     #   setvar foo bar
#     #
#     # In the above example, if a variable named foo
#     # exists and is not empty it will be set to bar.
#     # Otherwise its value will not be altered.
#     #
#     eval "${1}=\"${!1:-${2}}\"";
# }

# setvar foo baz
# echo "$foo"