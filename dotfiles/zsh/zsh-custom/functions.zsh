# Git ======================================================================
function git_push_upstream() {
    git push --set-upstream ${1:-origin} $(git branch --show-current)
}

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
