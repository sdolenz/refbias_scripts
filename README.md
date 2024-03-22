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
...

## Mapping stats workflow
To begin, copy all of the BAMs into a subdirectory called "bams" within a directory referred to in the code as "mismappers". These should be labeled as {mapper}_{species}_div{divergence percentage}_{endogenous content}end_MQ{mapping quality filter}.bam, such as bwaaln_elephant_div9_100end_MQ30.bam or local_bowtie_elephant_div2_1end_MQ1.bam. Then, copy the simulated fasta libraries to a subdirectory "fastas". 

Then run the python script [mapping_stats.py](mapping_stats.py) from the main directory "mismappers". This will output tsvs to a subdirectory created within the code called "new_tsvs" within the main directory. 

Then change to the "new_tsvs" directory (`cd ./new_tsvs`) and run 




## Acknowledgements
I would like to thank my coauthors Tom van der Valk, Chenyu Jin, Jonas Oppenheimer, Muhammad Bilal Sharif, Ludovic Orlando, Beth Shapiro, Love Dalén, and Peter D. Heintzman for their help and insightful advice. Also, my amazing cat Pip for keeping me sane during all of the bug fixes. 

***This project utilized ChatGPT, OpenAI for assistance in writing and editing scripts***
