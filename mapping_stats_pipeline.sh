# dependencies: samtools/1.16 python/3.9.5 pysam/0.17.0-python3.9.5 biopython/1.80-py3.9.5 R/4.2.1 R_packages/4.2.1

for mapper in bwamem bwaaln verysensitive_bowtie sensitive_bowtie local_bowtie ; do

    path=...your parent directory here.../mapping_stats
    cp_path=...your parent directory here...

    # change directory to mapping_stats/
    mkdir -p ${path}
    cd ${path}
    
    # copy BAM and simulated fasta files

    mkdir -p bams/
    mkdir -p fastas/
    
    cp ${cp_path}/${mapper}_map/*.bam ./bams/
    cp ${cp_path}/sim_libraries/*.fa ./fastas/

done

echo
echo "Done copying BAM files"

echo
echo "Running mapping_stats.py"

# run mapping_stats.py in mapping_stats directory

python3 mapping_stats.py 

# change directory to new_tsvs which is created in mapping_stats.py

cd ${path}/new_tsvs/

echo
echo

# run mapping_stats_modify_tsv.R in new_tsv directory

echo
echo "Running mapping_stats_modify_tsv.R"
echo

Rscript mapping_stats_modify_tsv.R

# run mapping_stats_cat_tsv.sh 

echo
echo "Running mapping_stats_cat_tsv.sh"
echo

bash mapping_stats_cat_tsv.sh

#change directory back to mapping_stats

cd ${path}/

# run mapping_stats_plots.R 

echo
echo "Running mapping_stats_plots.R"
echo

mkdir -p ./mapping_stats_plots/
Rscript mapping_stats_plots.R

echo "Done!"
echo

# copy the final three panel plots that combine MQ into a single plot to the mapping_stats_final_plots subdirectory

mkdir -p ./mapping_stats_final_plots/
cp ./mapping_stats_plots/*byMQ* ./mapping_stats_final_plots/
