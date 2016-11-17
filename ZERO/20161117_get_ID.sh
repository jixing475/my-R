ls  tophat_results/*/accept_hits.bam | while read id ; 
sampleID=` echo $id | cut -d"/" -f 2`
do 
nohup 
~/biosoft/Cufflinks/current/cufflinks -p 20 -o  cufflinks_results/$sampleID  $id 
done 


[jixing@log01 liuyouhua_20161029]$ 
ls alignment/*.bam | while read id; 
sampleID=` echo $id | cut -d "/" -f 2 | cut -d "." -f 1` | unique; 
do 
echo $sampleID;
done > ID.txt
