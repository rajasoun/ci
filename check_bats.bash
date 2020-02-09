#!/usr/bin/env bash

function run_all_tests(){
    exec test/test_*.bats
}

function run_unit_tests(){
   exec test/test_unit*.bats
}

function run_integration_tests(){
   exec test/test_integ*.bats
}

choice=$1
case $choice in
    all)
      exec time test/test_*.bats
      ;;
    unit)
      exec time test/test_unit*.bats
      ;;
    integ | integration)
      exec time test/test_integ*.bats
      ;;
    *)
      exec time test/test_*.bats
      ;;
esac
