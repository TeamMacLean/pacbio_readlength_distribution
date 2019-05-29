#!/bin/bash
inputfile=$1
minlength=$2


inputfilebasename=$(basename $inputfile)

if [[ ${inputfilebasename} == *".fastq" || $1 == *".fq" ]]; then
    output=$(echo $(echo ${inputfilebasename} | sed 's/.fastq$//')_readlength_filtered.fastq )
    cat ${inputfile} | awk -v minlength="$minlength" '{if(NR%4==1){seqid=$0;} else if  (NR%4==2){sequence=$0;} else if(NR%4==0){qual=$0; if(length(sequence) >= minlength){print seqid"\n"sequence"\n+\n"qual}}}' >  $output


elif [[ ${inputfilebasename} == *".fastq.gz" || $1 == *".fq.gz" ]]; then
    output=$(echo $(echo ${inputfilebasename} | sed 's/.fastq.gz$//')_readlength_filtered.fastq )
    zcat ${inputfile} | awk -v minlength="$minlength" '{if(NR%4==1){seqid=$0;} else if  (NR%4==2){sequence=$0;} else if(NR%4==0){qual=$0; if(length(sequence) >= minlength){print seqid"\n"sequence"\n+\n"qual}}}' > $output

elif [[ ${inputfilebasename} == *".fasta" || ${inputfilebasename} == *".fa" ]]; then
    output=$(echo $(echo ${inputfilebasename} | sed 's/.fasta$//')_readlength_filtered.fasta )
    cat ${inputfile} | awk -v minlength="$minlength" '{if(NR%2==1){seqid=$0;} else if  (NR%2==0){sequence=$0; if(length(sequence)>=minlength){ print  seqid"\n"sequence}} }' >  $output

elif [[ ${inputfilebasename} == *".fasta.gz" || $1 == *".fa.gz" ]]; then
    output=$(echo $(echo ${inputfilebasename} | sed 's/.fasta.gz$//')_readlength_filtered.fasta )
    zcat ${inputfile} | awk -v minlength="$minlength" '{if(NR%2==1){seqid=$0;} else if  (NR%2==0){sequence=$0; if(length(sequence)>=minlength){ print  seqid"\n"sequence}} }' > $output

fi
