# ==============================================================================
# Supporting functions

# Check if variable is set to true
#
# Usage:
#   is-arg-true $VARIABLE && echo yes || echo no
#
function is-arg-true() {

  if [[ "$1" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
    return 0
  else
    return 1
  fi
}
export -f is-arg-true > /dev/null

# Print header
#
# Usage:
#   print-header "This is a header"
#
function print-header() {

    printf -- "\n%s${*}%s\n\n" >&2 "$BOLD$BLUE" "$RESET"
}
export -f print-header > /dev/null

# Print error
#
# Usage:
#   print-error "This is an error"
#
function print-error() {

    printf -- "%sError: ${*}%s\n" >&2 "$RED" "$RESET"
}
export -f print-error > /dev/null

# ==============================================================================
# Private functions

function _setup_color() {

  # Only use colors if connected to a terminal
  if [ -t 1 ]; then
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    BOLD=$(printf '\033[1m')
    RESET=$(printf '\033[m')
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    RESET=""
  fi
}
_setup_color
