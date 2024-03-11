#! /run/current-system/sw/bin/bash
is_commit=false
is_verbose=false
for i in "$@" ; do
	if [[ $i == "-c" ]] ; then
		is_commit=true
	fi
	if [[ $i == "-vc" || $i == "-cv" ]] ; then
		is_commit=true
		is_verbose=true
	fi
done
# Verify valid arguments
if [[ "$is_commit" = true &&  "$#" -ne 2 ]] ; then
	echo "Invalid arguments for commit"
	exit 1
fi
# Rebuild and potentially commit
echo "Rebuilding..."
REBUILD=$(sudo nixos-rebuild switch  2>/dev/null)  #> /dev/null 2>&1 redirects output of rebuild to /dev/null
if [[ "$is_verbose" = true ]] ; then
	echo "$REBUILD"
fi
if [ "$is_commit" = true ] ; then
	echo "Commiting..."
	ADD=$(git add * 2>/dev/null)
	COMMIT=$(git commit -m "$2" 2>/dev/null)
	echo "Pushing..."
	PUSH=$(git push 2>/dev/null)
	if [[ "$is_verbose" = true ]] ; then
		echo "$ADD"
		echo "$COMMIT"
		echo "$PUSH"
	fi
fi
