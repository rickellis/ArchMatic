#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#          _ 
#   __ ___| |___ _ _ ___
#  / _/ _ \ / _ \ '_(_-<
#  \__\___/_\___/_| /__/
#
#-----------------------------------------------------------------------------------
# VERSION="1.2.2"
#-----------------------------------------------------------------------------------
#
# Headings and colored text for shell scripts
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/Shell-Scripts/colors
# License:  MIT
#-----------------------------------------------------------------------------------
#
# USAGE
#
# To give a text string a color use:
#
#    echo -e "${green}This is green text${reset}
#
#    echo -e "${bold}${magenta}This is bold magenta text${reset}
#  
#  Shorter syntax
#
#    echo -e "${pur}This is purple text${r}
#
#    echo -e "${b}${mag}This is bold magenta text${r}
#   
#    NOTE: Make sure to reset the color at the end of the string.
#
# AVAILABLE TEXT COLORS
#
#     COLOR       SHORTCUT
#     white       wht
#     black       blk
#     grey        gry
#     red         red
#     green       grn
#     blue        blu
#     cyan        cyn
#     yellow      yel
#     orange      org
#     magenta     mag
#     purple      pur
#
#     bold        b
#     reset       r
#
# To generate a heading with a colored background use:
#
#     heading <color> "Heading Text"
#
# For a heading with bold text use:
#
#     bheading <color> "Heading Text"
#
# For a heading with a randomly selected color use:
#
#     heading random "Heading Text"
#
# AVAILABLE HEADING COLORS
#
#     COLOR       SHORTCUT
#     random      rnd
#     grey        gry
#     charcoal    chr
#     red         red
#     green       grn
#     lime        lim
#     aquamarine  aqm
#     olive       olv
#     blue        blu
#     sky         sky
#     cyan        cyn
#     agua        aqa
#     goldenrod   gdr
#     yellow      yel
#     coral       crl
#     orange      org
#     pink        pnk
#     lavender    lav
#     magenta     mag
#     purple      pur
#
# The above colors can be used to generate your own colored strings.
# For background colors just prefix "bg" to the color.
#
#   echo -e "${bgred}${b}${wht}Red background with bold white text${r}"
#
#-----------------------------------------------------------------------------------

reset="\e[0m"                       # Reset all color values to default
bold="\e[1m"                        # Bold

# TEXT COLORS ----------------------------------------------------------------------

white="\e[97m"                      # White
black="\e[38;5;232m"                # Black
grey="\e[37m"                       # Grey
red="\e[91m"                        # Red
green="\e[92m"                      # Green
blue="\e[94m"                       # Blue
cyan="\e[96m"                       # Cyan
yellow="\e[93m"                     # Yellow
orange="\e[38;5;208m"               # Orange
magenta="\e[95m"                    # Magenta
purple="\e[38;5;53m"                # Purple

# BACKGROUND COLORS ----------------------------------------------------------------

bg_black="\e[40m"                   # Black
bg_grey="\e[48;5;240m"              # Grey
bg_charcoal="\e[48;5;237m"          # Charcoal
bg_red="\e[48;5;1m"                 # Red
bg_green="\e[48;5;22m"              # Green
bg_lime="\e[48;5;40m"               # Lime
bg_aquamarine="\e[48;5;120m"        # Aquamarine
bg_olive="\e[48;5;58m"              # Olive
bg_blue="\e[44m"                    # Blue
bg_sky="\e[48;5;25m"                # Sky
bg_cyan="\e[46m"                    # Cyan
bg_aqua="\e[48;5;87m"               # Aqua
bg_goldenrod="\e[48;5;220m"         # Goldenrod
bg_yellow="\e[42m"                  # Yellow
bg_coral="\e[48;5;208m"             # Coral
bg_orange="\e[48;5;202m"            # Orange
bg_pink="\e[48;5;207m"              # Pink
bg_lavender="\e[48;5;141m"          # Lavender
bg_magenta="\e[48;5;90m"            # Magenta
bg_purple="\e[48;5;53m"             # Purple
bg_white="\e[107m"                  # White

# COLOR SHORTCUTS ------------------------------------------------------------------

r=$reset
b=$bold
blk=$black
gry=$grey
grn=$green
yel=$yellow
org=$orange
mag=$magenta
pur=$purple
cyn=$cyan
wht=$white

bgblk=$bg_black
bggry=$bg_grey
bgchr=$bg_charcoal
bgred=$bg_red
bggrn=$bg_green
bglim=$bg_lime
bgaqm=$bg_aquamarine
bgolv=$bg_olive
bgblu=$bg_blue
bgsky=$bg_sky
bgcyn=$bg_cyan
bgaqa=$bg_aqua
bggdr=$bg_goldenrod
bgyel=$bg_yellow
bgcrl=$bg_coral
bgorg=$bg_orange
bgpnk=$bg_pink
bglav=$bg_lavender
bgmag=$bg_magenta
bgpur=$bg_purple
bgwht=$bg_white

# HEADING FUNCTION -----------------------------------------------------------------

heading() {

    if [ -z "$1" ] || [ -z "$2" ]; then
        echo 'Usage: heading <color> "Heading Text"'
        exit 1
    fi

    if [ -z "$3" ]; then
        weight=""
    else
        weight=$bold
    fi

    local color=${1,,}        # lowercase
    local hding=${2}          # capture heading
    local hdlen=${#hding}     # heading length
    local twidt=$(tput cols)  # terminal width

    # Set the minimum width to match length of the heading
    if [ ! $twidt -gt $hdlen ]; then
        twidt=$hdlen
    fi

    # Calculate the padding necessary on either side of the heading
    l=$(( twidt - hdlen )) 
    d=$(( l / 2 ))

    local padding=""
    for i in $(seq 1 ${d}); do 
        padding+=" "
    done

    # Thanks to Bash's auto-rounding, depending on the length of the
    # terminal relative to the length of the heading we might end up
    # one character off. To compensate we add one space if necessary
    local padextra=""
    local padlenth=${#padding}
    local totlenth=$(( padlenth * 2 + hdlen ))
    if [ $twidt -ne $totlenth ]; then
        padextra=" ";
    fi

    # Random color generator
    if [ "$color" == 'rnd' ] || [ "$color" == "rand" ] || [ "$color" == "random" ]; then
        colors=(   
                    "gry" 
                    "chr"
                    "red"
                    "grn"
                    "lim"
                    "aqm"
                    "olv"
                    "blu"
                    "sky"
                    "cyn"
                    "aqa"
                    "gdr"
                    "yel"
                    "crl"
                    "org"
                    "pnk"
                    "lav"
                    "mag" 
                    "pur"
                )

        color=${colors[$RANDOM % ${#colors[@]}]}
    fi

    # White text: \e[97m
    # Black text: \e[38;5;232m
    # Bold: \e[1m

    case "$color" in
        grey | gry)         color="${bggry}${white}"    ;;
        charcoal | chr)     color="${bgchr}${white}"    ;;
        red)                color="${bgred}${white}"    ;;
        green | grn)        color="${bggrn}${white}"    ;;
        lime | lim)         color="${bglim}${black}"    ;;
        aquamarine | aqm)   color="${bgaqm}${black}"    ;;
        olive | olv)        color="${bgolv}${white}"    ;;
        blue | blu)         color="${bgblu}${white}"    ;;
        sky)                color="${bgsky}${white}"    ;;
        cyan | cyn)         color="${bgcyn}${white}"    ;;
        aqua | aqa)         color="${bgaqa}${black}"    ;;
        goldenrod | gdr)    color="${bggdr}${black}"    ;;
        yellow | yel)       color="${bgyel}${black}"    ;;
        coral| crl)         color="${bgcrl}${white}"    ;;
        orange | org)       color="${bgorg}${white}"    ;;
        pink | pnk)         color="${bgpnk}${white}"    ;;
        lavender | lav)     color="${bglav}${black}"    ;;
        magenta | mag)      color="${bgmag}${white}"    ;;
        purple | pur)       color="${bgpur}${white}"    ;;
        *)                  color="${bggrn}${white}"    ;;
    esac

    echo
    echo -e "${color}${padding}${weight}${hding}${padding}${padextra}${reset}"
    echo
}

# BOLD HEADING FUNCTION ------------------------------------------------------------

function bheading() {
    heading "$1" "$2" "bold"
}


# TESTS ----------------------------------------------------------------------------

# echo -e "${gry}Grey text${r}"
# echo -e "${b}${gry}Bold Grey text${r}"
# echo -e "${grn}Green text${r}"
# echo -e "${b}${grn}Bold Green text${r}"
# echo -e "${yel}Yellow text${r}"
# echo -e "${b}${yel}Bold Yellow text${r}"
# echo -e "${org}Orange text${r}"
# echo -e "${b}${org}Bold Orange text${r}"
# echo -e "${mag}Magenta text${r}"
# echo -e "${b}${mag}Bold Magenta text${r}"
# echo -e "${pur}Purple text${r}"
# echo -e "${b}${pur}Bold Purple text${r}"
# echo -e "${cyn}Cyan text${r}"
# echo -e "${b}${cyn}Bold Cyan text${r}"
# echo -e "${wht}White text${r}"
# echo -e "${b}${wht}Bold White text${r}"


# heading rnd "Random" # Random color
# heading gry "Grey"
# heading chr "Charcoal"
# heading red "Red"
# heading grn "Green"
# heading lim "Lime"
# heading aqm "Aquamarine"
# heading olv "Olive"
# heading blu "Blue"
# heading sky "Sky"
# heading cyn "Cyan"
# heading aqa "Aqua"
# heading gdr "Goldenrod"
# heading yel "Yellow"
# heading crl "Coral"
# heading org "Orange"
# heading pnk "Pink"
# heading lav "Lavender"
# heading mag "Magenta"
# heading pur "Purple"
