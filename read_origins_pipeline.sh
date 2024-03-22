# dependencies: samtools/1.16 python/3.9.5 pysam/0.17.0-python3.9.5 R/4.2.1 R_packages/4.2.1

path=...your parent directory here.../read_origins

# change directory to read_origins/
mkdir -p ${path}
cd ${path}
    

echo 
echo "running read_origins_bam_to_tsv.py"
echo


for species in elephant rhino ; do

    for div in 0 1 2 3 4 5 6 9 12 15 ; do 

        for quality in 100end 50end 10end 1end ; do 
        
            for MQ in 1 20 25 30 ; do

                for mapper in bwaaln bwamem verysensitive_bowtie sensitive_bowtie local_bowtie ; do 

                    cp_path=...your parent directory here.../${mapper}_map
                    bam_file=${path}/${mapper}_bams/${mapper}_${species}_div${div}_${quality}_MQ${MQ}.bam
                    output_file=${path}/${mapper}_tsvs/${mapper}_${species}_div${div}_${quality}_MQ${MQ}.tsv

                    # mkdir -p ${path}/${mapper}_bams
                    # mkdir -p ${path}/${mapper}_tsvs
                    # mkdir -p ${path}/${mapper}_proportion_tsvs
                    # mkdir -p ${path}/prop_plots/${mapper}_plots

                    cp $cp_path/${mapper}_${species}_div${div}_${quality}_MQ${MQ}.bam ./${mapper}_bams/ 

                    python3 read_origins_bam_to_tsv.py --bam_file $bam_file --output_file $output_file

                done

            done

        done

    done

done

echo
echo "Done!"
echo 
echo "Running read_origins_plots.R"
echo

Rscript read_origins_plots.R


echo "Done!"
echo






