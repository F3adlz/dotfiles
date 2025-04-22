# Git ======================================================================
function git_push_upstream() {
    git push --set-upstream ${1:-origin} $(git branch --show-current)
}
