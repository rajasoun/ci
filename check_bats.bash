#!/usr/bin/env bash

function run_host_pre_condition_tests(){
  exec test/pre_conditions/test_pre*.bats -t || return 1
}

function run_docker_pre_condition_tests(){
  exec test/pre_conditions/test_docker*.bats -t || return 1
}

function run_all_tests(){
  exec test/**/test_*.bats -t || return 1
}

function run_unit_tests(){
  exec test/unit/*.bats -t || return 1
}

function run_integration_tests(){
  exec test/integration/test_integration*.bats -t || return 1
}

function run_api_tests(){
  exec test/api/test_*.bats "$@" -t || return 1
}

function run_docker_tests(){
  exec test/integration/test_docker*.bats  -t || return 1
}
   
function run_tests_based_on_filter(){
  exec test/**/test_*.bats "$@" -t || return 1
}

function print_line(){
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

choice=$1
case $choice in
    all)
      echo "                                              Unit, Integration & API Tests                                      "
      print_line
      run_all_tests || return 1
      print_line
      ;;
    unit)
      echo "                                                     Unit Tests                                                 "
      print_line
      run_unit_tests || return 1
      print_line
      ;;
    integ | integration)
      echo "                                                   Integration Tests                                            "
      print_line
      run_integration_tests || return 1
      print_line
      ;;
    api)
      echo "                                                        API Tests                                               "
      print_line
      run_api_tests || return 1
      print_line
      ;;
    docker)
      echo "                                                Docker Integration Tests                                        "
      print_line
      run_docker_tests  || return 1
      print_line
      ;;
    host_precondition | *host_pre*)
      echo "                                                Host Pre Condition Tests                                        "
      print_line
      run_host_pre_condition_tests || return 1
      print_line
      ;;
    host_docker_precondition | *host_docker_*)
      echo "                                            Host Pre Condition Tests for Docker                                  "
      print_line
      run_docker_pre_condition_tests || return 1
      print_line
      ;;
    *)
      echo "                                                      Test Filters                                              "
      print_line
      run_tests_based_on_filter "$@" || return 1
      print_line
      ;;
esac
