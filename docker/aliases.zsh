alias dco='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcl='docker rmi $(docker images -a | grep "^<none>" | awk '\''{print $3}'\'') --force'
