# Here is the pipeline that will submit the scripts to simulated diverged reads, build simulated libraries, and map the simulated libraries to the appropriate reference genome using various alignment tools


# Dependencies: python/3.9.5 bowtie2/2.3.5.1 bbmap/38.61b samtools/1.16 bwa/0.7.17



path=...your parent directory...

mkdir -p ${path}/ref_genomes/

### Download asian elephant, black rhino, and human reference genomes (versions found in paper) in addition to the bacterial genomes found in kraken2 and concatenate those to form one bacterial reference ###



### Download gargammel from github, this will create a directory "gargammel" within your parent directory ###

path2=...your parent directory.../gargammel
cd ${path2}

# Create mismatch files to simulate 1, 2, 3, 4, 5, 6, 9, 12, and 15 divergence

echo
echo "Running simulated_mismatch.sh"
echo

bash simulated_mismatch.sh

echo
echo "Done!"
echo

# Generate simulated reads with and without divergence

echo
echo "Running simulated_simulations.sh"
echo

bash simulated_simulations.sh

echo
echo "Done!"
echo


# Create and change to sim_libraries directory 

path3=...your parent directory.../sim_libraries
mkdir -p ${path3}
cd ${path3}

# Construct simulated libraries (this uses the simulated_read_selection.py script)

echo
echo "simulated_building_libraries.sh"
echo

bash simulated_building_libraries.sh

echo
echo "Done!"
echo

# Change to parent directory

cd ${path}

# Map simulated libraries using bwa-aln, bwa-mem, sensitive end-to-end bowtie2, very-sensitive end-to-end bowtie2, and sensitive local bowtie2
# This is in the form of a for loop, but this will take a long time, it is recommended transforming this into an array (thread set to 8, but can be changed)

bash simulated_mapping.sh 



