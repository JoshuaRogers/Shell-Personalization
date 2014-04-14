function format_date {
  local numeric_date=$(date +"%m%d")
  local display_date=$(date +"%b %d")
  
  if [[ "${numeric_date}" == "1225" ]]; then                                # Christmas is green/red
    display_date=$(format_stripe "${display_date}" ${GREEN} ${RED})
  elif [[ "${numeric_date}" == "0518" ]]; then                              # HAAA-PPPY Birthday to me...
    display_date=$(format_stripe "${display_date}" ${CYAN} ${RED})
  elif [[ $(special_date_sunday_of_advent "${numeric_date}") > 0 ]]; then   # Any of the 4 Advent Sundays
    display_date=${PURPLE}${display_date}
  else
    display_date=${GREEN}${display_date}
  fi

  echo ${display_date}
}

function special_date_sunday_of_advent {
  for i in `seq 0 3`; do
    if [[ "$(special_date_week_of_advent ${i})" == "$1" ]]; then
      echo $((${i} + 1))
      return
    fi
  done
  echo 0
}

function special_date_week_of_advent {
  # From 12/01, back into Nov. and find the last Thur, then go forward 3 days. 
  local week=$1
  if [ `uname` == 'Darwin' ]
  then
    echo $(date -v1d -v12m -v-1d -v-thu -v+3d -v+${week}w +"%m%d")
  else
    echo "0000"
  fi
}

