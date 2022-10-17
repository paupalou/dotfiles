#!/usr/bin/env bash
# shellcheck disable=SC2086

__dots_folder=$(dirname "$(readlink "$(which dots)")")

source "${__dots_folder}/system.sh"
source "${__dots_folder}/config.sh"
source "${__dots_folder}/printer.sh"
source "${__dots_folder}/box.sh"

function _name_not_match {
  local result
  for i in "${@}"; do
    result+=" ! -name $i"
  done

  echo "$result"
}

function _path_not_match {
  local result
  for i in "${@}"; do
    result+=" ! -path */${i}"
  done

  echo "$result"
}

function _print_topic {
  local topic=$1
  local sync_topic_icon_char
  local message
  sync_topic_icon_char=$(_dots_setting "sync_topic_icon_char")

  _box_line_start
  _print_colored "$sync_topic_icon_char" "$(_dots_color "sync_topic_icon_style")"
  _space
  _print_colored "$topic" "$(_dots_color "sync_topic_style")"
  _box_line_end $((${#topic} + 1 + $(wc -w <<< $sync_topic_icon_char)))
  _newline
}

function _print_skipped_files {
  local file_count=$1
  local success_icon_char
  local message

  if [[ "$file_count" -eq 0 ]]; then
    return
  fi

  success_icon_char=$(_dots_setting "success_icon_char")
  message="$success_icon_char $file_count files"

  _box_line_start
  _space
  _space
  _success_icon
  _space
  _print "$file_count"
  _space
  _print_colored "files" "$lgray"
  _box_line_end $(( 2 + ${#message} ))
  _newline
}

function _sync_dotfiles {
  _box_start dotfiles
  _disable_input

  local verbose=$1
  local overwrite_all=false backup_all=false skip_all=false
  local excluded_files excluded_paths dotfiles files

  _disable_globbing
  excluded_files=$(_name_not_match "path.fish")
  excluded_paths=$(_path_not_match ".git")
  dotfiles=$(_dots_setting "dotfiles_path")

  # TODO Check if fd is available then find as fallback
  # for topic in $(fd --base-directory $dotfiles --type d | sort); do

  for topic in $(find -H "$dotfiles" -mindepth 1 -maxdepth 1 -type d $excluded_paths $excluded_files -exec basename {} \; | sort); do
    _disable_globbing
    excluded_paths=$(_path_not_match "*/.git/*")
    files=$(find -H "$dotfiles/$topic" -type f $excluded_paths $excluded_files ! -name '*:*')
    # files=$(fd . ${dotfiles}/${topic} --type f --hidden --exclude '*:*' --exclude path.fish --exclude '.git')
    local skipped_files_counter=0

    if [[ ${#files} -gt 0 ]]; then
      _print_topic $topic
    fi
    _enable_globbing
    for file_full_path in $files; do
      file_name=$(basename "$file_full_path")
      src_dirname=$(dirname "$file_full_path")
      file_depth=$(echo "$src_dirname" | grep -o / | wc -l)
      if [[ $file_depth -lt 5 ]]; then
        destiny=$HOME/$file_name
      else
        destiny=$HOME/$(echo "$src_dirname" | cut -d'/' -f6-)/$file_name
      fi
      matching_file=$(_grab_file "$src_dirname/$file_name")

      _link_file "$matching_file" "$destiny" "$verbose"
    done

    if [[ -z "$verbose" ]] || [[ "$verbose" == false ]]; then
      _print_skipped_files "$skipped_files_counter"
    fi

  done

  _enable_input
  _box_end
}

function _link_file {
  # local src=$1 dst=$2 print_each_skipped_file=$4
  local src=$1 dst=$2 verbose=$3
  local overwrite backup skip action

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
      local currentSrc
      currentSrc="$(readlink "$dst")"
      if [ "$currentSrc" == "$src" ]; then
        if [[ "$verbose" == true ]]; then
          _file_synced "$src" "$dst"
        else
          ((skipped_files_counter += 1))
        fi
        return
      fi
    fi
  fi

  if [ "$skip" != "true" ]; then
    if [[ ! -d  $(dirname "$dst") ]]; then
      mkdir -p $dst
    fi

    ln -sfn "$src" "$dst"
    _file_linked "$src" "$dst" "$verbose"
    ((file_counter -= 1))
  fi
}

function _file_synced {
  local destiny=$2

  local src
  local item_length
  local file_name
  local file_path
  local file_full_path
  # src=$(basename "$1")
  file_name=$(basename "$1")
  file_path=\~/$(echo $destiny | cut -d'/' -f4-)
  file_full_path=$file_path/$file_name

  src_max_length=$(($(_box_line_max_length) - 4))
  item_length="  x ${file_full_path:0:src_max_length}"

  _box_line_start
  _space
  _space
  _success_icon
  _space
  _print_colored "${file_full_path:0:src_max_length}" "$lgray"
  _box_line_end ${#item_length}
  _newline
}


function _file_linked {
  local destiny=$2

  local src
  local item_length
  local destiny_max_length
  src=$(basename "$1")

  item_length="x $src"
  src_max_length=$(($(_box_line_max_length) - 2))
  destiny_max_length=$src_max_length

  _box_line_start
  _space
  _space
  _link_icon
  _space
  _print_colored "${src:0:src_max_length}" "$bold"
  _box_line_end $((${#item_length} + 2))
  _newline

  _box_line_start
  _repeat 4 " "

  item_length="└ ${destiny}"
  _print_colored "└" "$dgray"
  _space
  _print_colored "${destiny:0:$destiny_max_length}" "$lgray"
  if [[ ${#item_length} -gt $(_box_line_max_length) ]]; then
    item_length="└ ${destiny:0:destiny_max_length}"
  fi
  _box_line_end $((${#item_length} + 4))
  _newline
}
