#!/bin/bash

# usage: bash $0 FASTQ/FASTA_filename

inputfilebasename=$(basename $1)

if test ! -e ${inputfilebasename}.readlength.txt; then
    if [[ ${inputfilebasename} == *".fastq" || $1 == *".fq" ]]; then
        echo "This is FASTQ file"
    	cat ${inputfilebasename} | awk '{if(NR%4==1){seqid=$0; sub("@", "", $0); print $0} else if  (NR%4==2){print length($0)}}' | paste - - >  results/${inputfilebasename}_readlength.txt

    elif [[ ${inputfilebasename} == *".fastq.gz" || $1 == *".fq.gz" ]]; then
        echo "This is gzip FASTQ file";
    	zcat ${inputfilebasename} | awk '{if(NR%4==1){seqid=$0; sub("@", "", $0); print $0} else if  (NR%4==2){print length($0)}}' | paste - - > results/${inputfilebasename}_readlength.txt

    elif [[ ${inputfilebasename} == *".fasta" || ${inputfilebasename} == *".fa" ]]; then
        echo "This is FASTA file";
    	cat ${inputfilebasename} | awk '{if(NR%2==1){seqid=$0; sub(">", "", $0); print $0} else if  (NR%2==0){print length($0)}}' | paste - - >  results/${inputfilebasename}_readlength.txt

    elif [[ ${inputfilebasename} == *".fasta.gz" || $1 == *".fa.gz" ]]; then
        echo "This is gzip fasta file"
    	zcat ${inputfilebasename} | awk '{if(NR%2==1){seqid=$0; sub(">", "", $0); print $0} else if  (NR%2==0){print length($0)}}' | paste - - > results/${inputfilebasename}_readlength.txt

    fi

fi




if test ! -e results/${inputfilebasename}.readlength.txt; then
    Rscript scripts/plot_readlengths_histogram.R results/${inputfilebasename}_readlength.txt
fi

# The final plot will be generate in teh current working directory
