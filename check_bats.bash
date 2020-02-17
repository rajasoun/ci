#!/usr/bin/env bash

function run_all_tests(){
    exec test/**/test_*.bats -t
}

function run_unit_tests(){
   exec test/unit/*.bats -t
}

function run_integration_tests(){
   exec test/integration/test_integ*. -t
}

function run_docker_tests(){
   exec test/integration/test_docker*.bats  -t
}

function run_tests_based_on_filter(){
   exec test/**/test_*.bats "$@" -t
}


function print_line(){
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

choice=$1
case $choice in
    all)
      echo "                                              Unit & Integration Tests                                          "
      print_line
      run_all_tests
      print_line
      ;;
    unit)
      echo "                                                     Unit Tests                                                 "
      print_line
      run_unit_tests
      print_line
      ;;
    integ | integration)
      echo "                                                   Integration Tests                                            "
      print_line
      run_integration_tests
      print_line
      ;;
    docker)
      echo "                                                Docker Integration Tests                                        "
      print_line
      run_docker_tests
      print_line
      ;;
    *)
      echo "                                                      Test Filters                                              "
      print_line
      run_tests_based_on_filter
      print_line
      ;;
esac
