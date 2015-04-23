_dotfiles() {
  # init variables
  local curcontext="$curcontext" state line
  typeset -A opt_args

  # init state
   _arguments \
    '1: :->service'\
    '2: :->task'

  case $state in
  service)
    _arguments '1:service:(source update alias zshrc)'
  ;;
  *)
    case $words[2] in
    alias)
      compadd "$@" list add remove
      ;;
    *)
    esac
  esac
}

compdef _dotfiles dotfiles