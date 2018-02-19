#!/usr/bin/env bash




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