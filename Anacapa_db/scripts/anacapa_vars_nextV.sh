# Variables file for anacapa_release_V1		09-15-2017
# Developed and written by Emily Curd (eecurd@g.ucla.edu), Jesse Gomer (jessegomer@gmail.com), and Baochen Shi (biosbc@gmail.com), with contributions from Gaurav Kandlikar (gkandlikar@ucla.edu), Zack Gold (zack.j.gold@gmail.com), Rachel Turba (rturba@ucla.edu) and Rachel Meyer (rsmeyer@ucla.edu).
# Developed at UCLA for the University of California Conservation Consortium's CALeDNA Program
# Last Updated 9-15-2017

###########################
# Parameters
###########################

#####
# cutadapt
#####

# cutadapt primer + adapter trim step "QC: 1) Run cutadapt to removal primers + sequencing adapters, sort for length, and quality"
# a or A adapters are 3' adapters and g or G adapters are 5' adapters
# in this script they are anchored to the ends of the read and allow up to 30% mismatch including indels

#cutadapt vars
ERROR_QC1=".3"															## max percent errors allowed in between adapter or reverse complemented primer + adapter sequence and read sequence
FILE_TYPE_QC1="fastq"													# fasta or fastq. 
F_ADAPT="file:${OUT}/Run_info/cutadapt_primers_and_adapters/g_${ADPT}_Forward_adapter.txt"   # path to file with the forward primer + adapter "g"
Rrc_PRIM_ADAPT="file:${OUT}/Run_info/cutadapt_primers_and_adapters/a_Reverse_PrimAdapt_rc.txt"   # path to the reverse complemented Reverse_adapter "a" that matches the forward primer + adapter "g"
R_ADAPT="file:${OUT}/Run_info/cutadapt_primers_and_adapters/G_${ADPT}_Reverse_adapter.txt"   # path to G_Reverse_adapter.txt primer + adapter "G"
Frc_PRIM_ADAPT="file:${OUT}/Run_info/cutadapt_primers_and_adapters/A_Forward_PrimAdapt_rc.txt"   # path to the reverse complemented forward primer + adapter "A" that matches the reverse primer + adapter "G"
R_PRIM_RC="file:${OUT}/Run_info/cutadapt_primers_and_adapters/a_reverse_rc_primers.txt"   # path to file with the forward primer + adapter "g"

###Primer sort
ERROR_PS=".3"															# max percent errors allowed in between primer sequence and read sequence
FILE_TYPE_PS="fastq"													# fasta or fastq. 
F_PRIM="file:${OUT}/Run_info/cutadapt_primers_and_adapters/g_forward_primers.txt"   # path to file with the forward primer 
R_PRIM="file:${OUT}/Run_info/cutadapt_primers_and_adapters/G_reverse_primers.txt"	# path to file with the reverse primer 
MS_F_TRIM="20"	# amount to trim from the 3' end of the MiSeq F read
MS_R_TRIM="50"	# amount to trim from the 3' end of the MiSeq R read
HS_F_TRIM="10"	# amount to trim from the 3' end of the HiSeq F read
HS_R_TRIM="25"	# amount to trim from the 3' end of the HiSeq R read

#####
# FastX_toolkit
#####
# use to trim and filter reads by length 

MIN_LEN="100"   # minimum read length to pass filter
MIN_QUAL="35"   # minimum read quality to pass filter


#####
# metabarcode sequence length - primers + 20 (minimum overlap require) for dada2
#####
LENGTH_16S="240"
LENGTH_18S="200"
LENGTH_12S="130"
LENGTH_CO1="360"
LENGTH_PITS="480"
LENGTH_FITS="350"
LENGTH_PPM="500"
