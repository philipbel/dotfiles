#!/bin/sh

self=`basename $0`

tu()
{
	echo "$@"
	eval "$@"
}

EXCEPTIONS="yasnippet"

for i in $(find . -name '*.el' -type f); do
	is_exception=0
	for j in $EXCEPTIONS; do
		if echo $i | grep "$j" > /dev/null; then
			echo "$self: Ignoring $i (exception $j)"
			is_exception=1
			break
		fi
	done
	if [ $is_exception = 0 ]; then
		tu emacs -q -no-site-file -batch -f batch-byte-compile "$i"
	fi
done
