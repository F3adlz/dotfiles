# resize image
# $1 - input file name
# $2 - size (f.e. WxH)
# $3 - output file name
# https://www.howtogeek.com/109369/how-to-quickly-resize-convert-modify-images-from-the-linux-terminal/
function resize_image() {
  convert $1 -resize $2 $3
}

# run shell in Docker container
function desh() {
  docker exec -it $1 ${2:-sh}
}

function docker_host_ip() {
    ip route | grep docker0 | cut -d ' ' -f 1
}

function kesh() {
  kubectl exec -it $1 ${2:-sh}
}

if is_macos; then
  brew-outdated() {
    emulate -L zsh
    setopt pipe_fail

    local -a args=()
    local arg

    for arg in "$@"; do
      case "$arg" in
        -g|--greedy)
          args+=(--greedy)
          ;;
        -h|--help)
          print "Usage: brew-outdated [-g|--greedy]"
          return 0
          ;;
        *)
          print -u2 "Unknown argument: $arg"
          return 2
          ;;
      esac
    done

    command brew outdated --json=v2 "${args[@]}" |
      jq -r '
        if ((.formulae | length) + (.casks | length)) == 0 then
          "All packages are up to date"
        else
          (
            ["TYPE", "PACKAGE", "INSTALLED", "AVAILABLE"],
            (.formulae[] |
              ["formula", .name, (.installed_versions | join(", ")), .current_version]),
            (.casks[] |
              ["cask", .name, (.installed_versions | join(", ")), .current_version])
          ) | @tsv
        end
      ' |
      column -t -s $'\t'
  }
fi
