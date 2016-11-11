#!/bin/bash


PROJECT_DIR=/zzh_gpfs02/jixing/NTL
# annotation
GENE_REFERENCE=/zzh_gpfs/home/zzhgroup/jixing/NTL/reference/genes.gtf
REFERENCE_SEQ=/zzh_gpfs/home/zzhgroup/jixing/NTL/reference/genome.fa
BOWTIE_INDEX=/zzh_gpfs/home/zzhgroup/jixing/NTL/reference/genome
DATA_DIR=${DATA_DIR}
# software
SAMTOOLS=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/samtools-1.1/samtools
TOPHAT_BINARY=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/tophat-2.0.13.Linux_x86_64/tophat2
CUFFDIFF_BINARY=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/cufflinks-2.2.1.Linux_x86_64/cuffdiff
MEGA_HIT=/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/megahit/megahit
P=16 #use 16 threads

for SAMPLE_ID in 305L   305N    305T    317L    317N    317T    326L    326N    326T    335L    335N    335T    352L    352N    
do
cat > ${SAMPLE_ID}.sh <<EOF
#!/bin/bash
##### project ####
#BSUB -J project                 
#BSUB -n 16                            
#BSUB -o output_%J             
#BSUB -e errput_%J                 
#BSUB -q cpu  

mkdir ${PROJECT_DIR}/megaHit/${SAMPLE_ID}
cd ${PROJECT_DIR}/megaHit/${SAMPLE_ID}
$MEGA_HIT  -1 ${DATA_DIR}/${SAMPLE_ID}_1.fq -2 ${DATA_DIR}/${SAMPLE_ID}_2.fq -o megahit_asm

/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/bbmap/bbwrap.sh \
         ref=megahit_asm/final.contigs.fa in=${DATA_DIR}/${SAMPLE_ID}_1.fq in2=${DATA_DIR}/${SAMPLE_ID}_2.fq out=aln.sam.gz kfilter=22 subfilter=15 maxindel=80
/zzh_gpfs/home/zzhgroup/jixing/workspace/rnaseq/tools/bbmap/pileup.sh in=aln.sam.gz out=cov.txt
cp cov.txt ${PROJECT_DIR}/megaHit/${SAMPLE_ID}_cov.txt
cd -
EOF
bsub < ${SAMPLE_ID}.sh
rm ${SAMPLE_ID}.sh
done

#305L  317N  326T  352L   L1A    L5A    N40A   P574N  T215A 305L  317N  326T  352L   L1A    L5A    N40A   P574N  T215A 305N  317T  335L  352N   L215A  N193A  N4A    P574T  T40A 305N  317T  335L  352N   L215A  N193A  N4A    P574T  T40A 305T  326L  335N  352T   L40A   N1A    N5A    T193A  T4A 305T  326L  335N  352T   L40A   N1A    N5A    T193A  T4A 317L  326N  335T  L193A  L4A    N215A  P574L  T1A    T5A 317L  326N  335T  L193A  L4A    N215A  P574L  T1A    T5A
