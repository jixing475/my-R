#!/bin/bash
HAI=/zzh_gpfs02/jixing/NTL/NTL-gene-fusion
#
SAMTOOLS=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/samtools-1.1/samtools
TOPHAT_BINARY=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/tophat-2.0.13.Linux_x86_64/tophat2
CUFFDIFF_BINARY=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/cufflinks-2.2.1.Linux_x86_64/cuffdiff
STAR_BINARY=/zzh_gpfs/apps/STAR-STAR_2.4.1a/source/STAR
#
GENE_REFERENCE=/zzh_gpfs/home/zzhgroup/jixing/NTL/reference/genes.gtf
BOWTIE_INDEX=/zzh_gpfs/home/zzhgroup/jixing/NTL/reference/genome
REFERENCE_SEQ=/zzh_gpfs/home/zzhgroup/jixing/NTL/reference/genome.fa

P=16 #use 16 threads/cores

for SAMPLE_ID in 305L	305N	305T	317L	317N	317T	326L	326N	326T	335L	335N	335T	352L	352N	352T	L193A	L1A	L215A	L40A	L4A	L5A	N193A	N1A	N215A	N40A	N4A	N5A	P574L	P574N	P574T	T193A	T1A	T215A	T40A	T4A	T5A
do
cat > ${SAMPLE_ID}.sh <<EOF
#!/bin/bash
##### project ####
#BSUB -J project-NTL                  
#BSUB -n 16         
#BSUB -R "span[ptile=16]"                   
#BSUB -o output_%J             
#BSUB -e errput_%J                 
#BSUB -q cpu  

mkdir ${HAI}/star_fusion_outdir_${SAMPLE_ID}
STAR-Fusion --genome_lib_dir /zzh_gpfs02/jixing/NTL/NTL-gene-fusion/Hg19_CTAT_resource_lib \
             --left_fq /zzh_gpfs02/jixing/data/${SAMPLE_ID}_1.fq \
             --right_fq /zzh_gpfs02/jixing/data/${SAMPLE_ID}_2.fq \
             --output_dir ${HAI}/star_fusion_outdir_${SAMPLE_ID}
cp ${HAI}/star_fusion_outdir_${SAMPLE_ID}/star-fusion.fusion_candidates.final.abridged ./${SAMPLE_ID}.fusion
EOF
bsub < ${SAMPLE_ID}.sh 
rm ${SAMPLE_ID}.sh 
done
    

#=========================================================================================
#305L	305N	305T	317L	317N	317T	326L	326N	326T	335L	335N	335T	352L	352N	352T	L193A	L1A	L215A	L40A	L4A	L5A	N193A	N1A	N215A	N40A	N4A	N5A	P574L	P574N	P574T	T193A	T1A	T215A	T40A	T4A	T5A
