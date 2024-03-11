#! /run/current-system/sw/bin/bash
is_commit=false
for i in "$@" ; do
	if [[ $i == "-c" ]] ; then
		is_commit=true
		break
	fi
done
# Verify valid arguments
if [ "$is_commit" = true ] -a [ "$#" !+ 2 ] ; then
	echo "Invalid arguments for commit"
	exit 1
fi
# Rebuild and potentially commit
sudo nixos-rebuild switch
if [ "$is_commit" = true ] ; then
	git add *
	git commit -m "$2"
	git push
fi
