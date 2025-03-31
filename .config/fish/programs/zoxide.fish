# If zoxide is not installed, install it
ensure_package zoxide -s

# Initialize zoxide
# In Fish, we use 'status --is-interactive' to check if shell is interactive
if status --is-interactive
    zoxide init fish | source
end
