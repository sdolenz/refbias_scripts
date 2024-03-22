# Concatenate all tsv files of the same MQ to create a tsv that is by MQ
for mapper in bwaaln bwamem verysensitive_bowtie sensitive_bowtie local_bowtie ; do

   for species in elephant rhino ; do

      for div in 0 1 2 3 4 5 6 9 12 15 ; do

         for quality in 100end 50end 10end 1end ; do

            cat ${mapper}_${species}_div${div}_${quality}_MQ* > ${mapper}_${species}_div${div}_${quality}_mapping_stats_byMQ.tsv 

         done

      done

   done

done


# Iterate through each TSV file ending with "byMQ.tsv"
for file in *byMQ.tsv; do
  # Remove rows containing "Read_Length" after skipping the first line
  awk 'NR == 1 || !/Read_Length/' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done
