if [[ ! -v DISPLAY ]]; then
  # If our shell is not running in a graphical environment (i.e. it's a VT)
  # set a timeout that will exit and thus logout the shell automatically after
  # inactivity
  export TMOUT=300
fi
