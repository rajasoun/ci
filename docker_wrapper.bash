#!/usr/bin/env bash

# Workaround docker wrapper for git-bash/Msys/Cygwin quirks
# Copy this to ~/bin/docker or /usr/local/bin/docker

set -euo pipefail

## Usage:
## ./docker_wrapper.bash run --rm -it ubuntu bash #Interactive Shell
## ./docker_wrapper.bash run --rm  ubuntu date
export MSYS_NO_PATHCONV=1
export MSYS2_ARG_CONV_EXCL='*' 

case "$OSTYPE" in
    *msys*|*cygwin*) os="$(uname -o)" ;;
    *) os="$(uname)";;
esac

if [[ "$os" == "Msys" ]] || [[ "$os" == "Cygwin" ]]; then
    realdocker="$(which -a docker | grep -v "$(readlink -f "$0")" | head -1)"
    printf "%s\0" "$@" > /tmp/args.txt
    # --tty or -t requires winpty
    if grep -ZE '^--tty|^-[^-].*t|^-t.*' /tmp/args.txt; then
        exec winpty /bin/bash -c "xargs -0a /tmp/args.txt '$realdocker'"
    fi
fi
exec docker "$@"
