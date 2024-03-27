# Run the fastp and mapping scripts to prepare and map the emperical data

# Dependencies: fastp/0.23.2 bwa/0.7.17 bowtie2/2.3.5.1 samtools/1.16 

path=...your parent directory.../emperical_mappings

mkdir -p ${path}

#Download all fastqs mentioned in the paper from ENA into the $path
#Download all of the reference genomes mentioned in the paper to the ...your parent directory.../ref_genomes/ directory
#index genomes horse, maize, and human for bwa (note that the elephant and rhino are done previously in the simulated workflow)
#This is doene as: 
    # echo
    # echo "Creating index"
    # echo
    # bwa index $reference_fasta
    # echo
    # echo "Index created"
    # echo



# Run emperical_fastp.sh

echo
echo "Running emperical_fastp.sh"
echo

bash emperical_fastp.sh

echo 
echo "Done!"
echo

# Run emperical_mapping.sh

echo
echo "Running emperical_mapping.sh"
echo

bash emperical_mapping.sh

echo 
echo "Done!"
echo
