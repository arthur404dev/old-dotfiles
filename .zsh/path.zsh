# Bash
export PATH=$PATH:$(bash -ic 'echo $PATH')
# Golang
if [ -f $BREW_PREFIX/bin/go ]; then
    export PATH=$PATH:$(go env GOPATH)/bin
    export PATH=$PATH:$(go env GOROOT)/bin
fi
