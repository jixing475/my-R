#String Manipulation
#Bash has a number of (underappreciated) ways to manipulate strings.

#Basics
f="path1/path2/file.ext"  
len="${#f}" # = 20 (string length) 
# slicing: ${<var>:<start>} or ${<var>:<start>:<length>}
slice1="${f:6}" # = "path2/file.ext"
slice2="${f:6:5}" # = "path2"
slice3="${f: -8}" # = "file.ext"(Note: space before "-")
pos=6
len=5
slice4="${f:${pos}:${len}}" # = "path2"

#Substitution (with globbing)
f="path1/path2/file.ext"  
single_subst="${f/path?/x}"   # = "x/path2/file.ext"
global_subst="${f//path?/x}"  # = "x/x/file.ext" greedy Substitution
# string splitting
readonly DIR_SEP="/"
array=(${f//${DIR_SEP}/ })
second_dir="${array[1]}"     # = path2

#Deletion at beginning/end (with globbing)
f="path1/path2/file.ext" 
# deletion at string beginning extension="${f#*.}"  # = "ext" 
# greedy deletion at string beginning
filename="${f##*/}"  # = "file.ext" 
# deletion at string end
dirname="${f%/*}"    # = "path1/path2" 
# greedy deletion at end
root="${f%%/*}"      # = "path1"