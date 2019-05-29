#!/bin/bash
inputfile=$1
outputfile=$2
minlength=$3


inputfilebasename=$(basename $inputfile)

if [[ ${inputfilebasename} == *".fastq" || $1 == *".fq" ]]; then
    cat ${inputfile} | awk -v minlength="$minlength" '{if(NR%4==1){seqid=$0;} else if  (NR%4==2){sequence=$0;} else if(NR%4==0){qual=$0; if(length(sequence) >= minlength){print seqid"\n"sequence"\n+\n"qual}}}' >  $outputfile


elif [[ ${inputfilebasename} == *".fastq.gz" || $1 == *".fq.gz" ]]; then
    zcat ${inputfile} | awk -v minlength="$minlength" '{if(NR%4==1){seqid=$0;} else if  (NR%4==2){sequence=$0;} else if(NR%4==0){qual=$0; if(length(sequence) >= minlength){print seqid"\n"sequence"\n+\n"qual}}}' > $outputfile

elif [[ ${inputfilebasename} == *".fasta" || ${inputfilebasename} == *".fa" ]]; then
    cat ${inputfile} | awk -v minlength="$minlength" '{if(NR%2==1){seqid=$0;} else if  (NR%2==0){sequence=$0; if(length(sequence)>=minlength){ print  seqid"\n"sequence}} }' >  $outputfile

elif [[ ${inputfilebasename} == *".fasta.gz" || $1 == *".fa.gz" ]]; then
    zcat ${inputfile} | awk -v minlength="$minlength" '{if(NR%2==1){seqid=$0;} else if  (NR%2==0){sequence=$0; if(length(sequence)>=minlength){ print  seqid"\n"sequence}} }' > $outputfile

fi
