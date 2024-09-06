#!/bin/bash

#SBATCH -J Bowtie2
#SBATCH -p general
#SBATCH -o CREB1_cJun_S2_%j.txt
#SBATCH -e CREB1_cJun_S2_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=xuexiao@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=120:00:00


cd /N/slate/xuexiao/cJun_ChIP/Align
export PATH=$PATH:/N/slate/xuexiao/Bowtie2/bowtie2-2.4.2-linux-x86_64
source ~/.bashrc
bowtie2 --phred33 --end-to-end --very-sensitive --no-mixed --no-discordant -I 10 -X 700 --threads 6 -x /N/slate/xuexiao/Bowtie2/hg38_bowtie2_index -1 /N/slate/xuexiao/cJun_ChIP/clean/OV3_H3K9_S2_R1_trim_paired.fastq -2 /N/slate/xuexiao/cJun_ChIP/clean/OV3_H3K9_S2_R2_trim_paired.fastq -U /N/slate/xuexiao/cJun_ChIP/clean/OV3_H3K9_S2_R1_trim_unpaired.fastq,/N/slate/xuexiao/cJun_ChIP/clean/OV3_H3K9_S2_R2_trim_unpaired.fastq | samtools view -bS - > OV3_H3K9_S2_bowtie2.bam
samtools sort OV3_H3K9_S2_bowtie2.bam -o OV3_H3K9_S2_bowtie2_sorted.bam
samtools index OV3_H3K9_S2_bowtie2_sorted.bam OV3_H3K9_S2_bowtie2_sorted.bai

source deactivate
