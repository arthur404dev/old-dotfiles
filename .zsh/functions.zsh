# Colormap
function colormap() {
  for i in {0..255}; do 
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f "
    [ $((i % 6)) -eq 5 ] && echo
  done
}

# Function to check if a program exists
if_exists() {
    command -v $1 >/dev/null 2>&1
} 
