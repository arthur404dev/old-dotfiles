# Add Bash paths
if command -v bash >/dev/null 2>&1
    set -l bash_path (bash -ic 'echo $PATH' 2>/dev/null)
    if test -n "$bash_path"
        for path_entry in (string split : $bash_path)
            fish_add_path $path_entry
        end
    end
end

# Golang
if test -f $BREW_PREFIX/bin/go
    fish_add_path (go env GOPATH)/bin
    fish_add_path (go env GOROOT)/bin
end
