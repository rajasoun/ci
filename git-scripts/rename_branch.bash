#! /usr/bin/env bash

current_branch=$1
new_branch=$2

git branch -m $current_branch $new_branch       # Rename branch locally    
git push origin :$current_branch                # Delete the old branch    
git push --set-upstream origin $current_branch  # Push the new branch, set local branch to track the new remote