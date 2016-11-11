 find . -name *fq.gz | while read file_name; do echo ${file_name#./D8**-*/} ;done |while read file_name; do echo ${file_name%_rmrna_*.fq.gz} ;done | unique
 # #号是切头部
 # %号是切尾部