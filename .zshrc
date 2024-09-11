########################
# zsh起動時にtmuxも自動起動
########################
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux a

########################
# Powerlevel10kにより自動生成
########################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################
# .zshrcの分割 (分割ファイルは~/.zsh/*.zsh)
# 参考元: https://original-game.com/how-to-manage-zshrc-separately/
########################
ZSH_DIR="${HOME}/.zsh"
# .zshがディレクトリで、読み取り、実行、が可能なとき
if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
    # zshディレクトリより下にある、.zshファイルの分、繰り返す
    for file in ${ZSH_DIR}/**/*.zsh; do
        # 読み取り可能ならば実行する
        [ -r $file ] && source $file
    done
fi

########################
# alias
########################
alias ll='ls -alF'
alias gitg='git log --graph --oneline --decorate=full --date=short --format="%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)" $args'
alias sail='[ -f sail  ] && sh sail || sh vendor/bin/sail'
alias pbcopy='xsel --clipboard --input'
alias here='cmd.exe /C "start `wslpath -w .`"'
alias home='cd /mnt/c/Users/shimoda'
alias py='python3'
alias python='python3'
alias speedtest='speedtest -s 48463'

# フォルダサイズを取得
function sz(){
    if [ $# -eq 0 ]; then
        # 参考: https://qiita.com/YKInoMT/items/f84f0037b9c6687f4f04
        du -shx . .[^.]* *
    else
        du -shx $1
    fi
}


########################
# PATH
########################
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/Downloads/nvim-linux64/bin:$PATH
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/bin/python3
# export DOCKER_CONTENT_TRUST=1 # Docker Content Trust(DCT)を有効にする (Dockerイメージのなりすまし等を防ぐ)

########################
# cd移動時に自動でllする
########################
chpwd() {
    if [[ $(pwd) != $HOME && $(pwd) != /mnt/c/Users/shimoda ]]; then
        ll
    fi
}

# cdを省略
setopt auto_cd

########################
# nvmインストール時に自動で追加されたもの
########################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########################
# Added by Zinit's installer (Zinitインストールで自動追加されたもの)
########################
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

##############
# Load Plugins
##############
### Load pure theme
# zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library thats bundled with it.
# zinit light sindresorhus/pure
# zstyle :prompt:pure:git:stash show yes # turn on git stash status

zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
zinit ice wait'!0'; zinit load zsh-users/zsh-completions # 補完
zinit ice wait'!0'; zinit load chrissicool/zsh-256color # 256色使えるようにする
zinit ice wait'!0'; zinit load zsh-users/zsh-autosuggestions # 過去の入力履歴を検索しサジェストを表示
zinit ice depth=1; zinit light romkatv/powerlevel10k # theme編集ソフト
zinit ice wait'!0'; zinit light Aloxaf/fzf-tab # 補完選択メニューをfzfに置き換え

##########
# autoload
##########
### 補完
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=1 # 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 小文字でも大文字ディレクトリ、ファイルを補完できるようにする

#######
# fzf
#######
# source /usr/share/doc/fzf/examples/key-bindings.zsh # Ctrl+tショートカットを使えるようにする設定だけどもう不要っぽい
# export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"' # --followはシンボリックを含める
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

########################
# Powerlevel10kにより自動生成
########################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
