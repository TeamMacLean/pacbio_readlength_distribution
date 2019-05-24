## README

This is a Rscript to generate FASTQ/FASTA read length distribution. The input file must be tab delimited with read names/sequenceIds in first column and its length in the second column. No header or column name as the script has set column names to False.

## Requirements

1) R
2) readr library
3) ggplot library

## usage:

bash scripts/plot_readlength.sh fastq_or_fasta_filename


This command gets sequence read lengths, saves in a file and then uses the read length file to plot using the R script. 
