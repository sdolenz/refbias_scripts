# refbias_scripts
Here are the workflows and scripts used for the analysis of reference and read length biases on simulated and emperical data found in Dolenz et al. currently in review at the Journal of Bioinformatics. For any questions, comments, or concerns please feel free to reach out to me at stephanie.dolenz@geo.su.se. 


## Table Of Contents

* [Simulated Datasets Generation and Processing Scripts](#simulated-datasets-workflow)
* [Emperical Datasets Processing Scripts](#emperical-datasets-workflow)
* [Running AMBER Scripts](#amber-scripts)
* [Read Origins Scripts](#read-origins-workflow)
* [Mapping Stats Scripts](#mapping-stats-workflow)
* [Acknowledgements](#acknowledgements)


## Simulated datasets workflow
...

## Emperical datasets workflow
...

## AMBER scripts
...

## Read origins workflow
This will generate tsvs and R plots of the proportions of reads mapping to either bacteria, human, or the endogenous species (elephant or rhino). To run this, please download the read_origins* scripts, in addition to the read_origins_all_headers.tsv, and run the [read_origins_pipeline.sh](read_origins_pipeline.sh), which will calculate the proportion of reads from each of the simulated libraries that are from bacteria, human, or the endogenous species and produce line plots to interpret this data. 

## Mapping stats workflow
This will generate tsvs and R plots on the mapping statistics of the simulated libraries (including mismapped reads, correctly mapped reads, and unmapped reads). For this, please download the mapping_stats* scripts. You will be able to run the [mapping_stats_pipeline.sh](mapping_stats_pipeline.sh) which will copy the BAMs and simulated fasta libraries needed, run the analyses, and produce three paneled plots of the mentioned statistics. 

## Acknowledgements
I would like to thank my coauthors Tom van der Valk, Chenyu Jin, Jonas Oppenheimer, Muhammad Bilal Sharif, Ludovic Orlando, Beth Shapiro, Love Dalén, and Peter D. Heintzman for their help and insightful advice. Also, my amazing cat, Pip, for keeping me sane during all of the bug fixes. 

***This project utilized ChatGPT, OpenAI for assistance in writing and editing scripts***
