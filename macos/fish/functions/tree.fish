function tree --description 'Emulate tree command with string-colored directories'
    # Grab the exact color your Fish theme uses for strings/quotes ($fish_color_quote)
    set -l dir_color (set_color $fish_color_quote)
    set -l reset_color (set_color normal)

    # Embedded Python script to handle the structural heavy lifting
    set -l py_script '
import os, sys

dir_color = sys.argv[1]
reset_color = sys.argv[2]

max_depth = -1
show_hidden = False
targets = []

# Basic flag parsing
it = iter(sys.argv[3:])
for arg in it:
    if arg == "-L":
        try:
            max_depth = int(next(it))
        except StopIteration:
            pass
    elif arg == "-a":
        show_hidden = True
    elif not arg.startswith("-"):
        targets.append(arg)

if not targets:
    targets = ["."]

dir_count = 0
file_count = 0

def print_tree(path, prefix="", depth=1):
    global dir_count, file_count
    if max_depth != -1 and depth > max_depth:
        return

    try:
        items = os.listdir(path)
    except OSError:
        return

    if not show_hidden:
        items = [i for i in items if not i.startswith(".")]
        
    items.sort(key=lambda s: s.lower())
    
    count = len(items)
    for i, item in enumerate(items):
        is_last = (i == count - 1)
        full_path = os.path.join(path, item)
        is_dir = os.path.isdir(full_path)
        
        # The stem connectors
        connector = "└── " if is_last else "├── "
        
        # Apply color ONLY to directories, leaving files and stems default
        display_name = f"{dir_color}{item}{reset_color}" if is_dir else item
        print(f"{prefix}{connector}{display_name}")
        
        if is_dir:
            dir_count += 1
            extension = "    " if is_last else "│   "
            print_tree(full_path, prefix + extension, depth + 1)
        else:
            file_count += 1

for target in targets:
    is_dir = os.path.isdir(target)
    display_name = f"{dir_color}{target}{reset_color}" if is_dir else target
    print(display_name)
    if is_dir:
        print_tree(target)

# Standard tree summary line
dirs_str = "directory" if dir_count == 1 else "directories"
files_str = "file" if file_count == 1 else "files"
print(f"\n{dir_count} {dirs_str}, {file_count} {files_str}")
'

    # Execute the script, passing the parsed Fish colors and standard arguments
    python3 -c "$py_script" "$dir_color" "$reset_color" $argv
end
