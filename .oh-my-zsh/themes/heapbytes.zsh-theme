#Author : Pedro Augusto (https://github.com/pedroasgDEV)

PROMPT='┌─[%F{blue} %~%f]
└─[%F{yellow}%n@%m%f] [%F{green} $(get_ip_address)%f] [$(get_bit_rate)%f] $(git_prompt_info)
λ '

RPROMPT='[%F{red}%?%f]'

get_ip_address() {
  if [[ -n "$(ip addr show tun0 2>/dev/null)" ]]; then
    echo "%{$fg[green]%}$(ip addr show tun0 | awk '/inet / {print $2}' | cut -d/ -f1)%{$reset_color%}"
  elif [[ -n "$(ip addr show wlan0 2>/dev/null)" ]]; then
    echo "%{$fg[green]%}$(ip addr show wlan0 | awk '/inet / {print $2}' | cut -d/ -f1)%{$reset_color%}"
  else
    echo "%{$fg[red]%}No IP%{$reset_color%}"
  fi
}

get_bit_rate() {
  if [[ -n "$(ip addr show tun0 2>/dev/null)" ]]; then
    echo "%{$fg[cyan]%}$(iwconfig tun0 | awk '/Bit Rate/ {print $2, $3}' | sed 's/Rate=//')%{$reset_color%}"
  elif [[ -n "$(ip addr show wlan0 2>/dev/null)" ]]; then
    echo "%{$fg[cyan]%}$(iwconfig wlan0 | awk '/Bit Rate/ {print $2, $3}' | sed 's/Rate=//')%{$reset_color%}"
  else
    echo "%{$fg[red]%}No Netowork Connection%{$reset_color%}"
  fi
}
