
cd ...your parent directory.../ref_genomes/

# Create indexes for both bwa and bowtie2

for species in elephant rhino ; do 

        ref_fasta=...your parent directory.../ref_genomes/${species}_genome.fa

        bwa index $ref_fasta 
        bowtie2-build $ref_fasta ${species}_genome --threads 8

done

# Map the simulated libraries using bwa-aln, bwa-mem, sensitive end-to-end bowtie2, very-sensitive end-to-end bowtie2, and sensitive local bowtie2

for species in elephant rhino ; do
	
	for div in 0 1 2 3 4 5 6 9 12 15 ; do

		for quality in 100end 50end 10end 1end ; do

	                for mapper in bwaaln bwamem sensitive_bowtie verysensitive_bowtie local_bowtie ; do


                		cp_path=...your parent directory.../sim_libraries
                                path=...your parent directory.../${mapper}_map
                                bwa_ref=...your parent directory.../ref_genomes/${species}_genome.fa
                                bowtie_ref_path=...your parent directory.../ref_genomes
                                sim_fasta=${path}/sim_DNA/${species}_div${div}_${quality}.fa
                                sim_fastq=${path}/sim_DNA/${species}_div${div}_${quality}.fq
                                mapped_sai=${path}/${mapper}_${species}_div${div}_${quality}_aligned.sai
                                mapped_sam=${path}/${mapper}_${species}_div${div}_${quality}_aligned.sam
                                mapped_bam=${path}/${mapper}_${species}_div${div}_${quality}_aligned.bam
                                sorted_bam=${path}/${mapper}_${species}_div${div}_${quality}_sorted.bam
                                deduped_bam=${path}/deduped_${mapper}_${species}_div${div}_${quality}.bam


                                mkdir -p ${path}/sim_DNA/
                                mkdir -p ${path}/temp_BAM_SAM/
                                
                
                                if [ ${mapper} == "sensitive_bowtie" ] ; then
                
                                    cp ${cp_path}/${species}_div${div}_${quality}.fa ${path}/sim_DNA/
                
                                    echo 
                                    echo "Converting fasta to fastq"
                                    echo 
                
                                    reformat.sh in="${sim_fasta}" out="${sim_fastq}" overwrite=t qfake=40 
                                    echo 
                                    echo "fastq created"
                                    echo 
                
                                    echo "Mapping ${species}_div${div}_${quality}.fq to ${species} genome"
                                    echo
                                    echo
                
                                    bowtie2 -x ${bowtie_ref_path}/${species}_genome -U $sim_fastq -S $mapped_sam --sensitive -p 8
                
                                    echo
                                    echo
                                    echo "Finished mapping!"
                                    echo
                                    echo "Aligned reads located in ${mapped_sam}"
                                    echo
                
                                    samtools view -bS $mapped_sam > $mapped_bam
                                    samtools sort $mapped_bam -o $sorted_bam
                                    samtools index $sorted_bam  $sorted_bam.bai
                                    samtools rmdup -sS $sorted_bam $deduped_bam

                
                                    samtools view -bq 1 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools view -bq 20 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools view -bq 25 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools view -bq 30 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                
                
                                    mv $mapped_sam ${path}/temp_BAM_SAM/
                                    mv $mapped_bam ${path}/temp_BAM_SAM/
                                    mv $sorted_bam ${path}/temp_BAM_SAM/
                                    mv $deduped_bam ${path}/temp_BAM_SAM/

                                if [ ${mapper} == "verysensitive_bowtie" ] ; then
                
                                    cp "${cp_path}/${species}_div${div}_${quality}.fa" "${path}/sim_DNA/"
                
                                    echo 
                                    echo "Converting fasta to fastq"
                                    echo 
                
                                    reformat.sh in="${sim_fasta}" out="${sim_fastq}" overwrite=t qfake=40 
                                    echo 
                                    echo "fastq created"
                                    echo 
                
                                    echo "Mapping ${species}_div${div}_${quality}.fq to ${species} genome"
                                    echo
                                    echo
                
                                    bowtie2 -x ${bowtie_ref_path}/${species}_genome -U $sim_fastq -S $mapped_sam --very-sensitive -p 8
                
                                    echo
                                    echo
                                    echo "Finished mapping!"
                                    echo
                                    echo "Aligned reads located in ${mapped_sam}"
                                    echo
                
                                    samtools view -bS $mapped_sam > $mapped_bam
                                    samtools sort $mapped_bam -o $sorted_bam
                                    samtools index $sorted_bam  $sorted_bam.bai
                                    samtools rmdup -sS $sorted_bam $deduped_bam

                
                                    samtools view -bq 1 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools view -bq 20 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools view -bq 25 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools view -bq 30 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                
                
                                    mv $mapped_sam ${path}/temp_BAM_SAM/
                                    mv $mapped_bam ${path}/temp_BAM_SAM/
                                    mv $sorted_bam ${path}/temp_BAM_SAM/
                                    mv $deduped_bam ${path}/temp_BAM_SAM/

                                if [ ${mapper} == "local_bowtie" ] ; then
                
                                    cp "${cp_path}/${species}_div${div}_${quality}.fa" "${path}/sim_DNA/"
                
                                    echo 
                                    echo "Converting fasta to fastq"
                                    echo 
                
                                    reformat.sh in="${sim_fasta}" out="${sim_fastq}" overwrite=t qfake=40 
                                    echo 
                                    echo "fastq created"
                                    echo 
                
                                    echo "Mapping ${species}_div${div}_${quality}.fq to ${species} genome"
                                    echo
                                    echo
                
                                    bowtie2 -x ${bowtie_ref_path}/${species}_genome -U $sim_fastq -S $mapped_sam --sensitive-local -p 8
                
                                    echo
                                    echo
                                    echo "Finished mapping!"
                                    echo
                                    echo "Aligned reads located in ${mapped_sam}"
                                    echo
                
                                    samtools view -bS $mapped_sam > $mapped_bam
                                    samtools sort $mapped_bam -o $sorted_bam
                                    samtools index $sorted_bam  $sorted_bam.bai
                                    samtools rmdup -sS $sorted_bam $deduped_bam

                
                                    samtools view -bq 1 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools view -bq 20 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools view -bq 25 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools view -bq 30 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                
                
                                    mv $mapped_sam ${path}/temp_BAM_SAM/
                                    mv $mapped_bam ${path}/temp_BAM_SAM/
                                    mv $sorted_bam ${path}/temp_BAM_SAM/
                                    mv $deduped_bam ${path}/temp_BAM_SAM/
                
                
                                elif [ ${mapper} == "bwaaln" ] ; then
                
                
                                    cp "${cp_path}/${species}_div${div}_${quality}.fa" "${path}/sim_DNA/"
                
                                    echo 
                                    echo "Converting fasta to fastq"
                                    echo 
                
                                    reformat.sh in="${sim_fasta}" out="${sim_fastq}" overwrite=t qfake=40
                                    echo 
                                    echo "fastq created"
                                    echo 
                
                                    echo "Mapping ${species}_div${div}_${quality}.fq to ${species} genome"
                
                                    echo
                                    echo
                
                                    bwa aln "$bwa_ref" -t 8 -l 16500 -n 0.01 -o 2 "$sim_fastq" > "$mapped_sai"
                
                                    echo
                                    echo
                                    echo "Finished mapping!"
                                    echo
                
                                    echo "Aligned reads located in ${mapped_sai}"
                                    echo
                
                                    bwa samse "$bwa_ref" "$mapped_sai" "$sim_fastq" > "$mapped_sam"
                                    samtools view -bS "$mapped_sam" > "$mapped_bam"
                                    samtools sort "$mapped_bam" -o "$sorted_bam"
                                    samtools index "$sorted_bam" "$sorted_bam.bai"
                                    samtools rmdup -sS "$sorted_bam" "$deduped_bam"

                
                                    samtools view -bq 1 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools view -bq 20 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools view -bq 25 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools view -bq 30 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                
                
                                    mv $mapped_sai ${path}/temp_BAM_SAM/
                                    mv $mapped_sam ${path}/temp_BAM_SAM/
                                    mv $mapped_bam ${path}/temp_BAM_SAM/
                                    mv $sorted_bam ${path}/temp_BAM_SAM/
                                    mv $deduped_bam ${path}/temp_BAM_SAM/
                
                
                                elif [ ${mapper} == "bwamem" ] ; then
                
                                    cp "${cp_path}/${species}_div${div}_${quality}.fa" "${path}/sim_DNA/"
                
                                    echo 
                                    echo "Converting fasta to fastq"
                                    echo 
                
                                    reformat.sh in="${sim_fasta}" out="${sim_fastq}" overwrite=t qfake=40
                                    echo 
                                    echo "fastq created"
                                    echo 
                
                                    echo "Mapping ${species}_div${div}_${quality}.fq to ${species} genome"
                
                                    echo
                                    echo
                
                                    bwa mem "$bwa_ref" -t 8 -k 19 -r 2.5 "$sim_fastq" > "$mapped_sam"
                
                                    echo
                                    echo
                                    echo "Finished mapping!"
                
                                    echo "Aligned reads located in ${mapped_sam}"
                                    echo
                
                                    samtools view -bS "$mapped_sam" > "$mapped_bam"
                                    samtools sort "$mapped_bam" -o "$sorted_bam"
                                    samtools index "$sorted_bam" "$sorted_bam.bai"
                                    samtools rmdup -sS "$sorted_bam" "$deduped_bam"
                
                                    samtools view -bq 1 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools view -bq 20 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools view -bq 25 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools view -bq 30 "${deduped_bam}" > "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ1.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ20.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ25.bam"
                                    samtools index "${path}/${mapper}_${species}_div${div}_${quality}_MQ30.bam"
                
                                    mv $mapped_sam ${path}/temp_BAM_SAM/
                                    mv $mapped_bam ${path}/temp_BAM_SAM/
                                    mv $sorted_bam ${path}/temp_BAM_SAM/
                                    mv $deduped_bam ${path}/temp_BAM_SAM/
                
                
                                fi

                        done

                done

        done

done

