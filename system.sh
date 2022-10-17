#!/bin/bash

function _get_dots_folder {
  dirname "$(readlink "$(which dots)")"
}

function _disable_globbing {
  set -f
}

function _enable_globbing {
  set +f
}

function _disable_input {
  if [ -t 0 ]; then
     stty -echo -icanon time 0 min 0
  fi
}

function _enable_input {
  if [ -t 0 ]; then
    stty sane
  fi
}

function _get_os {
  if [ $(uname) == "Linux" ]; then
    cat /etc/*-release | grep '^ID=' | cut -d "=" -f 2
  elif [ $(uname) == "Darwin" ]; then
    echo "osx"
  fi
}

function _get_machine_hostname {
  echo $(hostname)
}

function _grab_file {
  local generic_file=$1
  local file_path
  local file_basename
  local file_extension

  file_path="$(dirname "$generic_file")"
  file_basename="$(basename "$generic_file" | cut -d "." -f 1)"
  file_extension="$(basename "$generic_file" | cut -d "." -f 2)"

  local expected_file
  expected_file="${file_path}/${file_basename}:$(_get_os):$(_get_machine_hostname).${file_extension}"

  if [ ! -f "$expected_file" ]; then
    expected_file="${file_path}/${file_basename}:$(_get_os).${file_extension}"
  fi

  if [ -f "$expected_file" ]; then
    echo "$expected_file"
  else
    echo "$generic_file"
  fi
}
