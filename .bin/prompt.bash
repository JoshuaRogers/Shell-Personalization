#!/usr/bin/env bash

# Colors from https://github.com/juliendidier/home-scripts/blob/master/.bash/colors
BLACK="\[\033[0;30m\]"   # Black
DGREY="\[\033[1;30m\]"   # Dark Gray
RED="\[\033[0;31m\]"     # Red
LRED="\[\033[1;31m\]"    # Light Red
GREEN="\[\033[0;32m\]"   # Green
LGREEN="\[\033[1;32m\]"  # Light Green
BROWN="\[\033[0;33m\]"   # Brown
YELLOW="\[\033[1;33m\]"  # Yellow
BLUE="\[\033[0;34m\]"    # Blue
LBLUE="\[\033[1;34m\]"   # Light Blue
PURPLE="\[\033[0;35m\]"  # Purple
LPURPLE="\[\033[1;35m\]" # Light Purple
CYAN="\[\033[0;36m\]"    # Cyan
LCYAN="\[\033[1;36m\]"   # Light Cyan
LGREY="\[\033[0;37m\]"   # Light Gray
WHITE="\[\033[1;37m\]"   # White
RESET="\[\033[0m\]"      # Color reset
BOLD="\[\033[;1m\]"      # Bold

function escape_color {
  echo $1 | sed -e "s/\\\\/\\\\\\\\/g"
}

function format_stripe {
  local text=$1
  local color_1=$(escape_color $2)
  local color_2=$(escape_color $3)
  
  local striped_text=$(echo "${text}" | sed -e "s/\(.\)\(.\)/${color_1}\1${color_2}\2/g")
  local odd_character_count=$((${#text} % 2))
  if ((odd_character_count)); then
    striped_text=$(echo "${striped_text}" | sed -e "s/\(.\)$/${color_1}\1/g")
  fi
  echo ${striped_text}
}

function format_date {
  echo "${GREEN}$(date +"%b %d")"
}

function format_time {
  # Strip the leading 0 if present so that bash doesn't interpret it as a base identifier.
  local now=$(date +"%H%M" | sed -e "s/^0*//g")
  local time_color=${GREEN}

  if [ "$GUILT_CLOCK" == "false" ]; then
    time_color=$GREEN
  elif (( $now > ${PENCILS_DOWN_TIME} || $now < ${EARLIEST_TIME})); then
    time_color=$RED
  elif (( $now > ${WIND_DOWN_TIME} )); then
    time_color=$YELLOW
  fi
  
  echo "${time_color}$(date +"%I:%M %p")"
}

function format_current_directory {
  echo -n $PWD | sed -e "s:^$HOME: ~:" -e "s|:|/|g" -e "s:/: $(escape_color ${LGREY})»$(escape_color ${LCYAN}) :g"
}

function is_git_repository {
  if ($(git rev-parse -q &> /dev/null)); then
    return 0
  fi
  return 1
}

function git_cache_status {
  git_cached_status="$(git status --short)"
}

function git_count_staged {
  echo "${git_cached_status}" | grep -e '^\w' | wc -l | sed -e "s/ //g"
}

function git_count_modified {
  echo "${git_cached_status}" | grep -e '^ ' | wc -l | sed -e "s/ //g"
}

function git_count_untracked {
  echo "${git_cached_status}" | grep ?? | wc -l | sed -e "s/ //g"
}

function git_format_status {
  local staged=$(git_count_staged)
  local modified=$(git_count_modified)
  local untracked=$(git_count_untracked)
  
  if (($staged > 0)); then
    echo "${staged} Staged"
  fi
  if (($modified > 0)); then
    (($staged > 0)) && echo " / "
    echo "${modified} Modified"
  fi
  if (($untracked > 0)); then
    (($staged > 0 || $modified > 0)) && echo " / "
    echo "${untracked} Untracked"
  fi
  
  # If nothing has been changed, we still want to give some kind of feedback to the user
  if (($staged + $modified + $untracked == 0)); then
    echo "Clean"
  fi
}

function git_branch_name {
  git branch --color=never | sed -ne 's/* //p'
}

function format_user_host {
  local username=$(whoami)
  local username_color=${LCYAN}
  local hostname=${PRETTY_HOSTNAME}
  local hostname_color=${LCYAN}

  [ "${username}" == "root" ] && username_color=${LRED}
  [ -z "${hostname}" ] && hostname=$(hostname -s)
  [ "${SAFE_HOST}" == "false" ] && hostname_color=${LRED}
  echo "${username_color}${username} ${LGREY}@ ${hostname_color}${hostname}"
}

function fill_dashes {
  local unformatted_first_line=$(echo $PS1 | grep -o -e ".*┐" | sed -e "s:\\\\\[\\\\033\[.;..m\\\\\]::g")

  # The +2 accounts for the < and > placeholders which will be removed.
  local remaining_chars=$((${COLUMNS} - ${#unformatted_first_line} + 2))
  local left_dash_length=$((remaining_chars / 2))
  local right_dash_length=$((remaining_chars - left_dash_length))
  
  local left_dashes=$(printf "%${left_dash_length}s" | sed 's/ /─/g' )
  local right_dashes=$(printf "%${right_dash_length}s" | sed 's/ /─/g' )
  PS1=$(echo ${PS1} | sed -e "s:<:${left_dashes}:" -e "s:>:${right_dashes}:")
}

function set_prompt {
  # If the current folder is part of a git repository, show some extra stats.
  local git_stats=""
  if (is_git_repository); then
    git_cache_status
    git_stats="(${GREEN}$(git_branch_name)${LGREY}) [$(git_format_status)]"
  fi
  
  local line_1="${LGREY}┌──── [$(format_date)${LGREY}] < [$(format_user_host)${LGREY}] > [$(format_time)${LGREY}] ────┐"
  local line_2="  $(format_current_directory)"
  local line_3="${LGREY}└──── ${git_stats}"
  local line_4="${LGREY}# ${RESET}"
  PS1="${line_1}\n${line_2}\n${line_3}\n${line_4}"
  fill_dashes
}

PROMPT_COMMAND=set_prompt
