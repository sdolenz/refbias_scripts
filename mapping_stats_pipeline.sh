for mapper in bwamem bwaaln verysensitive_bowtie sensitive_bowtie local_bowtie ; do

    path=...your parent directory here.../mapping_stats
    cp_path=...your parent directory here...

    # change directory to mapping_stats/
    cd ${path}
    
    # copy BAM files
    cp ${cp_path}/${mapper}_map/*.bam ./

done

# move BAM files to bams subdirectory within mapping_stats
mv ./*.bam ./bams/

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

# run modify_tsv.R in new_tsv directory

echo
echo "Running modify_tsv.R"
echo

Rscript modify_tsv.R

# run modify_tsv2.sh 

echo
echo "Running modify_tsv2.sh"
echo

bash modify_tsv2.sh

#change directory back to mapping_stats

cd ${path}/

# run panel_plots.R 

echo
echo "Running panel_plots.R"
echo

Rscript panel_plots.R

echo "Done!"
echo

# copy the final three panel plots that combine MQ into a single plot to the final_plots subdirectory

mkdir -p ./final_plots/
cp ./panel_plots/*byMQ* ./final_plots/
