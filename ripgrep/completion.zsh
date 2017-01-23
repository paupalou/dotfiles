completion='$(brew --prefix)/share/zsh/site-functions/_rg'

if test -f $completion
then
  source $completion
fi
