# -e min_merge_length

In `anacapa_QC_dada2.sh`, one option is:

```bash
-e file path to minimum overlap for user determined F and R primers
```

The file `metabarcode_loci_min_merge_length.txt` looks like this:

```
#####
# metabarcode sequence length - primers + 20 (minimum overlap require) for dada2
#####
LENGTH_16S="240"
LENGTH_18S="200"
LENGTH_12S="196"
LENGTH_CO1="333"
LENGTH_PITS="480"
LENGTH_FITS="350"
```

This variable will be ultimately passed to `dada2_unified_script.R`:
But it is ultimately used in `paired unmerged reads `

```R
barC_length = args[3] # expected seq length of the barcode.

# add seqeunce length for forwards and reversed to unmerged dereplicated data ------



pairedsum_unmerged_table$lengthF <- nchar(gsub("[a-z]","",pairedsum_unmerged_table$sequenceF))
pairedsum_unmerged_table$lengthR <- nchar(gsub("[a-z]","",pairedsum_unmerged_table$sequenceR))
pairedsum_unmerged_table$totalseq <- pairedsum_unmerged_table$lengthF + pairedsum_unmerged_table$lengthR

# add expected length of amplicon
pairedsum_unmerged_table$keep[pairedsum_unmerged_table$totalseq>=barC_length] <- FALSE
pairedsum_unmerged_table$keep[pairedsum_unmerged_table$totalseq<barC_length] <- TRUE

# Get the reverse complement of the R sequence
pairedsum_unmerged_table$sequenceRc <- sapply(sapply(sapply(pairedsum_unmerged_table$sequenceR, DNAString), reverseComplement), toString)

# pairedsum_unmerged_table$NNNNNN <- "AAAAAAAAAATTCTTAAAAAAAAAA"
pairedsum_unmerged_table$sequenceF_N_Rrc <- paste(pairedsum_unmerged_table$sequenceF,"AAAAAAAAAATTCTTAAAAAAAAAA",pairedsum_unmerged_table$sequenceRc,sep="")


pairedsum_unmerged_dada2 <- pairedsum_unmerged_table %>% filter(keep == TRUE) %>% select(sequenceF_N_Rrc, id, abundance)



if (nrow(pairedsum_unmerged_dada2) == 0) {
  cat("Done with analyzing your paired reads! None of the paired-but-unmerged reads were kept.\n\n")
  quit()
}

```

The idea is: for expected amplicon length 200 bp, the overlap is 20 bp. then for the two not overlapping reads (F & R), the total length is `amplicon + 20 bp` (noted as `pairedsum_unmerged_table$totalseq`). `barC_length == 220 bp`

```R
If (pairedsum_unmerged_table$totalseq >= barC_length) {
        "The reads should have merged, but didn't merge."
} else {
        "Maybe the reads were not reached to the middle. (Amplicon is very long.)"
        "paste the reads together using a dummy sequence"

        pairedsum_unmerged_table$sequenceF_N_Rrc <- paste(pairedsum_unmerged_table$sequenceF,"AAAAAAAAAATTCTTAAAAAAAAAA",pairedsum_unmerged_table$sequenceRc,sep="")

}
```

So in order to keep more `paired_unmerged reads`, `barC_length` should be smaller (require less overlap).

# -x -y additional trimming

This step occurred at cutadapt, not the same as the `dada2` filtering
This does not have al ot of problem, since the read gets bad greatly at the end.

```bash
  ${CUTADAPT} -e ${PCTADE:=$ERROR_PS} -f ${FILE_TYPE_PS} -g ${F_PRIM}  -u -${FETRIM:=$MS_F_TRIM} -o ${OUT}/QC/cutadapt_fastq/primer_sort/{name}_${j}_Paired_1.fastq  ${OUT}/QC/cutadapt_fastq/${j}_qcPaired_1.fastq >> ${OUT}/Run_info/cutadapt_out/cutadapt-report.txt
```

# -m minimum length after cutting

This is done by fastx_toolkit. Note this step is done after the first cutadapt but before the second, so the length is `minimum single read amplicon + primer length `

```bash
# stringent quality fileter to get rid of the junky reads. It mostly chops the lowquality reads off of the ends. See the documentation for details. The default average quality score for retained bases is 35 and the minimum length is 100.  Any reads that do not meet that criteria are removed
fastq_quality_trimmer -t ${QUALS:=$MIN_QUAL} -l ${MILEN:=$MIN_LEN}  -i ${OUT}/QC/cutadapt_fastq/untrimmed/${j}_Paired_1.fastq -o ${OUT}/QC/cutadapt_fastq/${j}_qcPaired_1.fastq -Q33 #trim pair one
```
