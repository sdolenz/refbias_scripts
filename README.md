# refbias_scripts
Here are the workflows and scripts used for the analysis of reference and read length biases on simulated and emperical data found in Dolenz et al. (Unravelling reference bias in ancient DNA datasets) currently in review at the Journal of Bioinformatics. For any questions, comments, or concerns please feel free to reach out to me at stephanie.dolenz@geo.su.se. 


## Table Of Contents

* [Simulated Datasets Generation and Processing Scripts](#simulated-datasets-workflow)
* [Emperical Datasets Processing Scripts](#emperical-datasets-workflow)
* [Running AMBER Scripts](#amber-scripts)
* [Read Origins Scripts](#read-origins-workflow)
* [Mapping Stats Scripts](#mapping-stats-workflow)
* [Acknowledgements](#acknowledgements)


## Simulated datasets workflow
This will generate and map simulated libraries comprising of "endogenous" (Asian elephant or Black rhino) reads in addition to human and bacterial "contamination" with 0-5%, 6%, 9%, 12%, and 15% divergence. For more information on the methods, please refer to the paper. The simulations use the tool gargammel, to download and an access the manual please visit [https://github.com/grenaud/gargammel.git](https://github.com/grenaud/gargammel.git). 

In order to run this, please download the simulated_* scripts ([simulated_mismatch.sh](simulated_mismatch.sh), [simulated_simulations.sh](simulated_simulations.sh), [simulated_read_selection.py](simulated_read_selection.py), [simulated_building_libraries.sh](simulated_building_libraries.sh), and [simulated_mapping.sh](simulated_mapping.sh)). Then run [simulated_pipeline.sh](simulated_pipeline.sh) to generate and map the simulated libraries. 

*It should be noted that the mapping script has been modified for this repository to be in the form of a for-loop for ease of understanding, but it is time intensive to run it in this form and therefore it is advised that the script is modified to an array. Also, the number of threads used has been set to 8, but it should be altered to your needs.*

## Emperical datasets workflow
This will run fastp on ancient emperical datasets used (including Human, American Mastodon, Steppe Mammoth, Maize, Siberian Unicorn, and Horse) and map the processed fastqs using BWA-aln (in addition to bwa-mem and bowtie2 for the American Mastadon). For more information on the methods, please refer to the paper. To run this, please download the emperical_* scripts ([emperical_fastp.sh](emperical_fastp.sh) and [emperical_mapping.sh](emperical_mapping.sh)). Then run [emperical_pipeline.sh](emperical_pipeline.sh) to process and map the ancient emperical datasets. 

*It should be noted that the mapping script has been modified for this repository to be in the form of a for-loop for ease of understanding, but it is time intensive to run it in this form and therefore it is advised that the script is modified to an array. Also, the number of threads used has been set to 20, but it should be altered to your needs.*

## AMBER scripts
...

## Read origins workflow
This will generate tsvs and R plots of the proportions of reads mapping to either bacteria, human, or the endogenous species (Asian elephant or Black rhino). To run this, please download the read_origins* scripts ([read_origins_bam_to_tsv.py](read_origins_bam_to_tsv.py) and [read_origins_plots.R](read_origins_plots.R)), in addition to the [read_origins_all_headers.tsv](read_origins_all_headers.tsv). Then run the [read_origins_pipeline.sh](read_origins_pipeline.sh) which will calculate the proportion of reads from each of the simulated libraries that are from bacteria, human, or the endogenous species and produce line plots to interpret this data. 

## Mapping stats workflow
This will generate tsvs and R plots on the mapping statistics of the simulated libraries (including mismapped reads, correctly mapped reads, and unmapped reads). For this, please download the mapping_stats* scripts ([mapping_stats.py](mapping_stats.py), [mapping_stats_modify_tsv.R](mapping_stats_modify_tsv.R), [mapping_stats_cat_tsv.sh](mapping_stats_cat_tsv.sh), and [mapping_stats_plots.R](mapping_stats_plots.R)). You will then be able to run the [mapping_stats_pipeline.sh](mapping_stats_pipeline.sh) which will copy the BAMs and simulated fasta libraries needed, run the analyses, and produce three paneled plots of the mentioned statistics. 

## Acknowledgements
I would like to thank my coauthors Tom van der Valk, Chenyu Jin, Jonas Oppenheimer, Muhammad Bilal Sharif, Ludovic Orlando, Beth Shapiro, Love Dalén, and Peter D. Heintzman for their help and insightful advice. Also, my amazing cat, Pip, for keeping me sane during all of the bug fixes. 

For this project, we acknowledge support from Science for Life Laboratory (SciLifeLab), the National Genomics Infrastructure (NGI) funded by the Swedish Research Council, and the computational resources (project IDs: NAISS 2023/5-153 and 2023/6-95) provided by the National Academic Infrastructure for Supercomputing in Sweden (NAISS) at the Uppsala Multidisciplinary Center for Advanced Computational Science (UPPMAX), which is partially funded by the Swedish Research Council through grant agreement no. 2022-06725. Further, my PhD is supported by the Knut and Alice Wallenberg Foundation (KAW 2021.0048). 


*This project utilized ChatGPT, OpenAI for assistance in writing and editing scripts.*
