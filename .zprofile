if [[ -z $TMUX ]]; then
  # for cabal
  path=($HOME/.cabal/bin(N-/) $path)
fi

if [[ -z tmux ]] ; then
  tmux new
else
  tmux attach
fi
