#!/usr/bin/env bash
#

# Gits Churn -  "frequency of change to code base"
#
# $ ./git-churn.bash
# 30 src/multipass/actions.bash
# 38 test/test_integration.bats
# 97 .github/workflows/pipeline.yml
#
# This means that 
# actions.bash has changed 30 times.
# pipeline.yml has changed 97 times.
#
# Show churn for specific directories:
#   $ $ ./git-churn.bash src 
#
# Show churn for a time range:
#   $ $ ./git-churn.bash --since='1 month ago'
#
# All standard arguments to git log are applicable

set -e
git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort -n
