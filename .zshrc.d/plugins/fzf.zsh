export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

FZF_DEFAULT_OPTS+='--color=dark'
FZF_DEFAULT_OPTS+=' --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1'
FZF_DEFAULT_OPTS+=' --color=info:4,prompt:0,pointer:12,marker:4,spinner:11,header:-1'
FZF_DEFAULT_OPTS+=' --layout=reverse'
export FZF_DEFAULT_OPTS

safe-source $HOME/.fzf.zsh
