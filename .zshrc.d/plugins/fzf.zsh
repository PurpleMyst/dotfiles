if [[ ${commands[fd]} ]]; then
    export FZF_DEFAULT_COMMAND='fd --type file'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

FZF_DEFAULT_OPTS+='--color=dark'
FZF_DEFAULT_OPTS+=" --color=fg:7,hl:8,fg+:15,bg+:${BASE16_HEX_COLORS[02]:-19}"
FZF_DEFAULT_OPTS+=" --color=info:0,prompt:7,pointer:${BASE16_HEX_COLORS[02]:-19},marker:4,spinner:11,header:-1,gutter:0"
FZF_DEFAULT_OPTS+=' --layout=reverse'
FZF_DEFAULT_OPTS+=' --info=hidden'
FZF_DEFAULT_OPTS+=' --prompt="fzf: "'
export FZF_DEFAULT_OPTS

safe-source $HOME/.fzf.zsh
