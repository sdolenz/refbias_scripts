# Runs Fastp to trim adapters, filter for ≥20bp (apart from Siberian Unicorn and Mastadon, which is ≥30), and merge reads


path=...your parent directory.../emperical_mappings/


# Runs Fastp for Siberian Unicorn, Maize, Human, Steppe Mammoth, and American Mastodon libraries

for species in sunicorn maize human mammoth mastodon ; do

        filename=ancient_${species}

        if [ ${species} == "sunicorn" ] ; then 

                fastp \
                -i ${path}/${filename}_1.fq.gz \
                -I ${path}/${filename}_2.fq.gz \
                -m \
                --merged_out merged.${filename}.fq.gz \
                --dedup \
                -n 3 \
                -o trimmed.${filename}.1.fq.gz -O trimmed.${filename}.2.fq.gz \
                -h ${filename}.html \
                -l 30 -w 8


       elif [ ${species} == "human" ] || [ ${species} == "mammoth" ] 

                fastp \
                -i ${path}/${filename}_1.fq.gz \
                -I ${path}/${filename}_2.fq.gz \
                -m \
                --merged_out merged.${filename}.fq.gz \
                --dedup \
                -n 3 \
                -o trimmed.${filename}.1.fq.gz -O trimmed.${filename}.2.fq.gz \
                -h ${filename}.html \
                -l 20 -w 8


        elif [ ${species} == "mastodon" ]

                fastp \
                -i ${path}/${filename}.fq.gz \
                --dedup \
                -n 3 \
                -o trimmed.${filename}.fq.gz \
                -h ${filename}.html \
                -l 30 -w 8

        else

                fastp \
                -i ${path}/${filename}.fq.gz \
                --dedup \
                -n 3 \
                -o trimmed.${filename}.fq.gz \
                -h ${filename}.html \
                -l 20 -w 8
            
        fi

done



# Run Fastp for horse with and without USER treatment

for species in horse ; do 

        for treatment in user nouser ; do

                filename=ancient_${species}_${treatment}

                fastp \
                -i ${path}/${filename}.fq.gz \
                --dedup \
                -n 3 \
                -o trimmed.${filename}.fq.gz \
                -h ${filename}.html \
                -l 20 -w 8

        done

done

