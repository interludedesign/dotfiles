# This file is sourced for every new zsh session, whereas .zshrc is only sourced in interactive mode

# Choose which Gemfile to use based on the existence of either a Gemfile.devel or Gemfile
function detect_gemfile_mode() {
    if [[ -f Gemfile.devel ]]; then
        printf "Using Gemfile for development mode.\n"
        export BUNDLE_GEMFILE=Gemfile.devel
    elif [[ -f Gemfile ]]; then
        printf "Using Gemfile for production mode.\n"
        export BUNDLE_GEMFILE=Gemfile
    fi
}

# Override cd to also perform the gemfile mode detection
function cd () {
    builtin cd "$@"    # perform the actual cd
    detect_gemfile_mode
}
