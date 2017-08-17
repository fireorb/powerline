sudo apt-get install python-pip git
sudo pip install --user git+git://github.com/Lokaltog/powerline
 $ nano /home/uzumaki/.profile
echo "   if [ -d "$HOME/.local/bin" ];
        then PATH="$HOME/.local/bin:$PATH"
        fi" >> .profile
su -c 'pip install git+git://github.com/Lokaltog/powerline'
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
git clone https://github.com/Lokaltog/powerline-fonts.git
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo mv powerline-fonts/ /usr/share/fonts/truetype
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
fc-cache -vf
git clone https://github.com/milkbikis/powerline-shell
cd powerline-shell
cp config.py.dist config.py
./install.py
sudo cp powerline-shell.py /root
cp powerline-shell.py $home
mv .bashrc .bashrc.backup
echo "    # .bashrc
     
    if [[ "$(uname)" != "Darwin" ]]; then # non mac os x
     
        # source global bashrc
        if [[ -f "/etc/bashrc" ]]; then
            . /etc/bashrc
        fi
     
        export TERM='xterm-256color' # probably shouldn't do this
    fi
     
    # bash prompt with colors
    # [ <user>@<hostname> <working directory> {current git branch (if you're in a repo)} ]
    # ==>
    PS1="\[\e[1;33m\][ \u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;33m\] \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\[\e[1;36m\]\1\[\e[1;33m\]}/') ]\[\e[0m\]\n==> "
     
    # execute only in Mac OS X
    if [[ "$(uname)" == 'Darwin' ]]; then
     
        # if OS X has a $HOME/bin folder, then add it to PATH
        if [[ -d "$HOME/bin" ]]; then
            export PATH="$PATH:$HOME/bin"
        fi
     
        alias ls='ls -G' # ls with colors
     
    fi
     
    alias ll='ls -lah' # long listing of all files with human readable file sizes
    alias tree='tree -C' # turns on coloring for tree command
    alias mkdir='mkdir -p' # create parent directories as needed
    alias vim='vim -p' # if more than one file, open files in tabs
     
    export EDITOR='vim'
    function _update_ps1()
    {
       export PS1="$(~/powerline-shell.py $?)"
    }
     
    export PROMPT_COMMAND="_update_ps1"

# aliases #############################################
 
# enable color support of ls and also add handy aliases
eval `dircolors -b`
alias ls='ls --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
 
# some more ls aliases
alias ll='ls -lhX'
alias la='ls -A'
alias ldir='ls -lhA |grep ^d'
alias lfiles='ls -lhA |grep ^-'
#alias l='ls -CF'
 
# To see something coming into ls output: lss
alias lss='ls -lrt | grep $1'
 
# To check a process is running in a box with a heavy load: pss
alias pss='ps -ef | grep $1'
 
# usefull alias to browse your filesystem for heavy usage quickly
alias ducks='ls -A | grep -v -e '\''^\.\.$'\'' |xargs -i du -ks {} |sort -rn |head -16 | awk '\''{print $2}'\'' | xargs -i du -hs {}'
 
# cool colors for manpages
alias man="TERMINFO=~/.terminfo TERM=mostlike LESS=C PAGER=less man"
 
##########################################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi
" > .bashrc
chmod +x $home/powerline-shell.py
