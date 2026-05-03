#Author : Pedro Augusto (https://github.com/pedroasgDEV)

get_vpn_info() {
  local vpn_interface=$(ip addr show | grep -E 'tun|ppp' | awk -F': ' '{print $2}' | head -n 1)
  if [[ -n "$vpn_interface" ]]; then
    echo "%F{magenta} VPN:$vpn_interface%f"
  else
    echo "%F{red} No VPN%f"
  fi
}

get_ip_addresses() {
  local ips=$(ip -o -4 addr show | awk '{print $2": "$4}' | cut -d/ -f1 | grep -vE 'lo|docker0' | paste -sd " | " -)
  if [[ -z "$ips" ]]; then
    echo "%F{red}No IP%f"
  else
    echo "%F{green} $ips%f"
  fi
}

PROMPT='┌─[%F{blue} %~%f]
└─[%F{yellow}%n@%m%f] [$(get_ip_addresses)] [$(get_vpn_info)] $(git_prompt_info)
λ '
