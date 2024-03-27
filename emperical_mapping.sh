# Mapping Siberian Unicorn, Human, Maize, American Mastodon, Steppe Mammoth, and horse with and without USER treatment (all with bwa-aln and Mastadon with additional bwa-mem and bowtie2)


path=...your parent directory.../emperical_mappings
ref_path=${path}/ref_genomes


mkdir -p ${path}/temp_BAM_SAM/



for species in sunicorn maize human mammoth mastodon horse ; do

  
  if [ ${species} == "maize" ]; then
  
      fastq=${path}/trimmed.ancient_${species}.fq.gz
      mapped_sai=${path}/ancient_${species}_aligned.sai
      mapped_sam=${path}/ancient_${species}_aligned.sam
      mapped_bam=${path}/ancient_${species}_aligned.bam
      sorted_bam=${path}/ancient_${species}_sorted.bam
      deduped_bam=${path}/deduped_ancient_${species}.bam
  
      
      echo "Mapping ${species}"
      echo
      echo
      bwa aln ${ref_path}/maize_reference.fa -t 20 -l 16500 -n 0.01 -o 2 $fastq > $mapped_sai
      echo
      echo
      echo "Finished mapping!"
      echo
  
      echo "Aligned reads located in ${mapped_sai}"
      echo
      bwa samse ${ref_path}/maize_reference.fa $mapped_sai $fastq > $mapped_sam
      samtools view -bS $mapped_sam > $mapped_bam
      samtools sort $mapped_bam -o $sorted_bam
      samtools index $sorted_bam $sorted_bam.bai
      samtools rmdup -sS $sorted_bam $deduped_bam
  
      samtools view -bq 1 ${deduped_bam} > ${path}/ancient_${species}_MQ1.bam
      samtools view -bq 20 ${deduped_bam} > ${path}/ancient_${species}_MQ20.bam
      samtools view -bq 25 ${deduped_bam} > ${path}/ancient_${species}_MQ25.bam
      samtools view -bq 30 ${deduped_bam} > ${path}/ancient_${species}_MQ30.bam
      samtools index ${path}/ancient_${species}_MQ1.bam
      samtools index ${path}/ancient_${species}_MQ20.bam
      samtools index ${path}/ancient_${species}_MQ25.bam
      samtools index ${path}/ancient_${species}_MQ30.bam
  
      mv $mapped_sai ${path}/temp_BAM_SAM/
      mv $mapped_sam ${path}/temp_BAM_SAM/
      mv $mapped_bam ${path}/temp_BAM_SAM/
      mv $sorted_bam ${path}/temp_BAM_SAM/
      mv $deduped_bam ${path}/temp_BAM_SAM/
  
  
  elif [ ${species} == "human" ]; then
  
      fastq=${path}/merged.ancient_${species}.fq.gz
      mapped_sai=${path}/ancient_${species}_aligned.sai
      mapped_sam=${path}/ancient_${species}_aligned.sam
      mapped_bam=${path}/ancient_${species}_aligned.bam
      sorted_bam=${path}/ancient_${species}_sorted.bam
      deduped_bam=${path}/deduped_ancient_${species}.bam
  
      
      echo "Mapping ${species}"
      echo
      echo
      bwa aln ${ref_path}/human_reference.fa -t 20 -l 16500 -n 0.01 -o 2 $fastq > $mapped_sai
      echo
      echo
      echo "Finished mapping!"
      echo
      
      echo "Aligned reads located in ${mapped_sai}"
      echo
      bwa samse ${ref_path}/human_reference.fa $mapped_sai $fastq > $mapped_sam
      samtools view -bS $mapped_sam > $mapped_bam
      samtools sort $mapped_bam -o $sorted_bam
      samtools index $sorted_bam $sorted_bam.bai
      samtools rmdup -sS $sorted_bam $deduped_bam
  
      samtools view -bq 1 ${deduped_bam} > ${path}/ancient_${species}_MQ1.bam
      samtools view -bq 20 ${deduped_bam} > ${path}/ancient_${species}_MQ20.bam
      samtools view -bq 25 ${deduped_bam} > ${path}/ancient_${species}_MQ25.bam
      samtools view -bq 30 ${deduped_bam} > ${path}/ancient_${species}_MQ30.bam
      samtools index ${path}/ancient_${species}_MQ1.bam
      samtools index ${path}/ancient_${species}_MQ20.bam
      samtools index ${path}/ancient_${species}_MQ25.bam
      samtools index ${path}/ancient_${species}_MQ30.bam
  
      mv $mapped_sai ${path}/temp_BAM_SAM/
      mv $mapped_sam ${path}/temp_BAM_SAM/
      mv $mapped_bam ${path}/temp_BAM_SAM/
      mv $sorted_bam ${path}/temp_BAM_SAM/
      mv $deduped_bam ${path}/temp_BAM_SAM/
  
  elif [ ${species} == "sunicorn" ]; then
  
      fastq=${path}/merged.ancient_${species}.fq.gz
      mapped_sai=${path}/ancient_${species}_aligned.sai
      mapped_sam=${path}/ancient_${species}_aligned.sam
      mapped_bam=${path}/ancient_${species}_aligned.bam
      sorted_bam=${path}/ancient_${species}_sorted.bam
      deduped_bam=${path}/deduped_ancient_${species}.bam
  
      
      echo "Mapping ${species}"
      echo
      echo
      bwa aln ${ref_path}/rhino_reference.fa -t 20 -l 16500 -n 0.01 -o 2 $fastq > $mapped_sai
      echo
      echo
      echo "Finished mapping!"
      echo
      
      echo "Aligned reads located in ${mapped_sai}"
      echo
      bwa samse ${ref_path}/rhino_reference.fa $mapped_sai $fastq > $mapped_sam
      samtools view -bS $mapped_sam > $mapped_bam
      samtools sort $mapped_bam -o $sorted_bam
      samtools index $sorted_bam $sorted_bam.bai
      samtools rmdup -sS $sorted_bam $deduped_bam
  
      samtools view -bq 1 ${deduped_bam} > ${path}/ancient_${species}_MQ1.bam
      samtools view -bq 20 ${deduped_bam} > ${path}/ancient_${species}_MQ20.bam
      samtools view -bq 25 ${deduped_bam} > ${path}/ancient_${species}_MQ25.bam
      samtools view -bq 30 ${deduped_bam} > ${path}/ancient_${species}_MQ30.bam
      samtools index ${path}/ancient_${species}_MQ1.bam
      samtools index ${path}/ancient_${species}_MQ20.bam
      samtools index ${path}/ancient_${species}_MQ25.bam
      samtools index ${path}/ancient_${species}_MQ30.bam
  
      mv $mapped_sai ${path}/temp_BAM_SAM/
      mv $mapped_sam ${path}/temp_BAM_SAM/
      mv $mapped_bam ${path}/temp_BAM_SAM/
      mv $sorted_bam ${path}/temp_BAM_SAM/
      mv $deduped_bam ${path}/temp_BAM_SAM/
  
    
    elif [ ${species} == "mammoth" ]; then
  
      fastq=${path}/merged.ancient_${species}.fq.gz
      mapped_sai=${path}/ancient_${species}_aligned.sai
      mapped_sam=${path}/ancient_${species}_aligned.sam
      mapped_bam=${path}/ancient_${species}_aligned.bam
      sorted_bam=${path}/ancient_${species}_sorted.bam
      deduped_bam=${path}/deduped_ancient_${species}.bam
  
      
      echo "Mapping ${species}"
      echo
      echo
      bwa aln ${ref_path}/elephant_reference.fa -t 20 -l 16500 -n 0.01 -o 2 $fastq > $mapped_sai
      echo
      echo
      echo "Finished mapping!"
      echo
      
      echo "Aligned reads located in ${mapped_sai}"
      echo
      bwa samse ${ref_path}/elephant_reference.fa $mapped_sai $fastq > $mapped_sam
      samtools view -bS $mapped_sam > $mapped_bam
      samtools sort $mapped_bam -o $sorted_bam
      samtools index $sorted_bam $sorted_bam.bai
      samtools rmdup -sS $sorted_bam $deduped_bam
  
      samtools view -bq 1 ${deduped_bam} > ${path}/ancient_${species}_MQ1.bam
      samtools view -bq 20 ${deduped_bam} > ${path}/ancient_${species}_MQ20.bam
      samtools view -bq 25 ${deduped_bam} > ${path}/ancient_${species}_MQ25.bam
      samtools view -bq 30 ${deduped_bam} > ${path}/ancient_${species}_MQ30.bam
      samtools index ${path}/ancient_${species}_MQ1.bam
      samtools index ${path}/ancient_${species}_MQ20.bam
      samtools index ${path}/ancient_${species}_MQ25.bam
      samtools index ${path}/ancient_${species}_MQ30.bam
  
      mv $mapped_sai ${path}/temp_BAM_SAM/
      mv $mapped_sam ${path}/temp_BAM_SAM/
      mv $mapped_bam ${path}/temp_BAM_SAM/
      mv $sorted_bam ${path}/temp_BAM_SAM/
      mv $deduped_bam ${path}/temp_BAM_SAM/
      
    elif [ ${species} == "mastodon" ]; then
  
  
      for mapper in bowtie bwaaln bwamem ; do
      
        fastq=${path}/trimmed.ancient_mastodon.fq.gz
        mapped_sai=${path}/ancient_mastodon_aligned_${mapper}.sai
        mapped_sam=${path}/ancient_mastodon_aligned_${mapper}.sam
        mapped_bam=${path}/ancient_mastodon_aligned_${mapper}.bam
        sorted_bam=${path}/ancient_mastodon_sorted_${mapper}.bam
        deduped_bam=${path}/deduped_ancient_mastodon_${mapper}.bam
        
        
        if [ ${mapper} == "bowtie" ]; then
  
          echo 
          echo "Mapping mastodon with ${mapper}"
          echo 
          echo
      
          bowtie2 -x ${ref_path}/elephant_genome -U $fastq -S $mapped_sam --sensitive -p 20
      
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
      
      
          samtools view -bq 1 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ1.bam
      
          samtools view -bq 20 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ20.bam
      
          samtools view -bq 25 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ25.bam
      
          samtools view -bq 30 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ30.bam
      
          samtools index ${path}/ancient_mastodon_${mapper}_MQ1.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ20.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ25.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ30.bam
      
          mv $mapped_sam ${path}/temp_BAM_SAM/
          mv $mapped_bam ${path}/temp_BAM_SAM/
          mv $sorted_bam ${path}/temp_BAM_SAM/
          mv $deduped_bam ${path}/temp_BAM_SAM/
      
  
        elif [ ${mapper} == "bwaaln" ]; then
      
          echo "Mapping mastodon with ${mapper}"
          echo
          echo
          bwa aln ${ref_path}/elephant_reference.fa -t 20 -l 16500 -n 0.01 -o 2 $fastq > $mapped_sai
          echo
          echo
          echo "Finished mapping!"
          echo
      
          echo "Aligned reads located in ${mapped_sai}"
          echo
          bwa samse ${ref_path}/elephant_reference.fa $mapped_sai $fastq > $mapped_sam
          samtools view -bS $mapped_sam > $mapped_bam
          samtools sort $mapped_bam -o $sorted_bam
          samtools index $sorted_bam $sorted_bam.bai
          samtools rmdup -sS $sorted_bam $deduped_bam
      
          samtools view -bq 1 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ1.bam
          samtools view -bq 20 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ20.bam
          samtools view -bq 25 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ25.bam
          samtools view -bq 30 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ30.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ1.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ20.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ25.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ30.bam
      
          mv $mapped_sai ${path}/temp_BAM_SAM/
          mv $mapped_sam ${path}/temp_BAM_SAM/
          mv $mapped_bam ${path}/temp_BAM_SAM/
          mv $sorted_bam ${path}/temp_BAM_SAM/
          mv $deduped_bam ${path}/temp_BAM_SAM/
  
  
        elif [ ${mapper} == "bwamem" ]; then
  
          echo
          echo "Mapping mastodon with ${mapper}"
          echo
          echo
      
          bwa mem ${ref_path}/elephant_reference.fa -t 20 -k 19 -r 2.5 $fastq > $mapped_sam
      
          echo
          echo
          echo "Finished mapping!"
          echo
      
          echo
          samtools view -bS $mapped_sam > $mapped_bam
          samtools sort $mapped_bam -o $sorted_bam
          samtools index $sorted_bam $sorted_bam.bai
          samtools rmdup -sS $sorted_bam $deduped_bam
      
      
      
          samtools view -bq 1 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ1.bam
          samtools view -bq 20 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ20.bam
          samtools view -bq 25 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ25.bam
          samtools view -bq 30 ${deduped_bam} > ${path}/ancient_mastodon_${mapper}_MQ30.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ1.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ20.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ25.bam
          samtools index ${path}/ancient_mastodon_${mapper}_MQ30.bam
      
      
          mv $mapped_sam ${path}/temp_BAM_SAM/
          mv $mapped_bam ${path}/temp_BAM_SAM/
          mv $sorted_bam ${path}/temp_BAM_SAM/
          mv $deduped_bam ${path}/temp_BAM_SAM/
  
        fi
  
      done        
  
  else
  
      for type in user nouser ; do
  
          fastq=${path}/trimmed.ancient_${species}_${type}.fq.gz
          mapped_sai=${path}/ancient_${species}_${type}_aligned.sai
          mapped_sam=${path}/ancient_${species}_${type}_aligned.sam
          mapped_bam=${path}/ancient_${species}_${type}_aligned.bam
          sorted_bam=${path}/ancient_${species}_${type}_sorted.bam
          deduped_bam=${path}/deduped_ancient_${species}_${type}.bam
  
  
          echo "Mapping ${species}"
          echo
          echo
          bwa aln ${ref_path}/horse_reference.fa -t 20 -l 16500 -n 0.01 -o 2 $fastq > $mapped_sai
          echo
          echo
          echo "Finished mapping!"
          echo
  
  
          echo "Aligned reads located in ${mapped_sai}"
          echo
          bwa samse ${ref_path}/horse_reference.fa $mapped_sai $fastq > $mapped_sam
          samtools view -bS $mapped_sam > $mapped_bam
          samtools sort $mapped_bam -o $sorted_bam
          samtools index $sorted_bam $sorted_bam.bai
          samtools rmdup -sS $sorted_bam $deduped_bam
  
          samtools view -bq 1 ${deduped_bam} > ${path}/ancient_${species}_${type}_MQ1.bam
          samtools view -bq 20 ${deduped_bam} > ${path}/ancient_${species}_${type}_MQ20.bam
          samtools view -bq 25 ${deduped_bam} > ${path}/ancient_${species}_${type}_MQ25.bam
          samtools view -bq 30 ${deduped_bam} > ${path}/ancient_${species}_${type}_MQ30.bam
          samtools index ${path}/ancient_${species}_${type}_MQ1.bam
          samtools index ${path}/ancient_${species}_${type}_MQ20.bam
          samtools index ${path}/ancient_${species}_${type}_MQ25.bam
          samtools index ${path}/ancient_${species}_${type}_MQ30.bam
  
          mv $mapped_sai ${path}/temp_BAM_SAM/
          mv $mapped_sam ${path}/temp_BAM_SAM/
          mv $mapped_bam ${path}/temp_BAM_SAM/
          mv $sorted_bam ${path}/temp_BAM_SAM/
          mv $deduped_bam ${path}/temp_BAM_SAM/
  
      done 
  
  fi

done
