#create individual tsv files

for species in elephant rhino ; do

    for div in 0 1 2 3 4 5 6 9 12 15 ; do 
            
        for quality in 100end 50end 10end 1end ; do 
        
            for mapper in bwaaln bwamem sensitive_bowtie verysensitive_bowtie local_bowtie ; do

                for MQ in 1 20 25 30 ; do

                    path=...your parent directory.../AMBER
                    bam_path=...your parent directory.../${mapper}_map

                    mkdir -p ${path}/${mapper}_tsv/div${div}_tsv/

                    touch ${mapper}_${species}_div${div}_${quality}_MQ${MQ}.tsv

                    printf "${mapper}_${species}_div${div}_${quality}_MQ${MQ}\t${bam_path}/${species}_div${div}_${quality}_MQ${MQ}.bam\n" ${mapper}_${species}_div${div}_${quality}_MQ${MQ}.tsv \
                    > tmp && mv tmp  ${mapper}_${species}_div${div}_${quality}_MQ${MQ}.tsv

                    mv ${mapper}_${species}_div${div}_${quality}_MQ${MQ}.tsv ${path}/${mapper}_tsv/div${div}_tsv/

                done

            done

        done

    done

done



#cat tsv files for amber input

for species in elephant rhino ; do

    for div in 0 1 2 3 4 5 6 9 12 15 ; do 
            
        for quality in 100end 50end 10end 1end ; do 
        
            for mapper in bwaaln bwamem sensitive_bowtie verysensitive_bowtie local_bowtie ; do

                for MQ in 1 20 25 30 ; do

                    path=...your parent directory.../AMBER/${mapper}_tsv/div${div}_tsv

                    cat ${path}/${mapper}_${species}_div${div}_${quality}_MQ* > ${path}/${mapper}_${species}_div${div}_${quality}_by_MQ.tsv
                
                done
            
            done

        done

    done

done


