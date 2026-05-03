get_network_status() {
  local output=""
  local networks=($(ip -o -4 addr show | awk '{print $2"|"$4}' | cut -d/ -f1 | grep -vE 'lo|docker'))

  for net in $networks; do
    local iface=$(echo $net | cut -d'|' -f1)
    local ip=$(echo $net | cut -d'|' -f2)
    local item=""

    if [[ $iface == wlan* ]]; then # wireless
      item="%F{green} %f%F{white}$iface: $ip%f"
    elif [[ $iface == tun* || $iface == ppp* ]]; then #VPN
      item="%F{magenta} %f%F{white}$iface: $ip%f"
    else # (Ethernet/etc)
      item="%F{blue}󰈀 %f%F{white}$iface: $ip%f"
    fi

    if [[ -z "$output" ]]; then
      output="$item"
    else
      output="$output %F{yellow}|%f $item"
    fi
  done

  if [[ -z "$output" ]]; then
    echo "%F{red}󱘖 No IP%f"
  else
    echo "$output"
  fi
}

# Definição do Prompt
PROMPT='┌─[%F{blue} %~%f]
└─[%F{yellow}%n@%m%f] [$(get_network_status)] $(git_prompt_info)
λ '
