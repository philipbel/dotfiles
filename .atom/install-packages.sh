#!/bin/bash

self=$(basename $0)

PACKAGES_FILE="$(dirname $0)/packages.list"
RETRIES=3

# PACKAGES=$(cat "$PACKAGES_FILE")

msg() {
  echo "$self: $*"
}

do_install() {
  local pkg=$1
  for ((i=1; i<=3; ++i)); do
    msg "[$i/$RETRIES] $pkg"
    if apm install "$pkg"; then
      break;
    else
      local exit_code=$?
      msg "  $pkg: Failed to install with exit code $exit_code"
      sleep 3
    fi
  done
}


# for pkg in $PACKAGES; do
while IFS='' read -r line || [[ -n "$line" ]]; do
  do_install "$line"
done < "$PACKAGES_FILE"
