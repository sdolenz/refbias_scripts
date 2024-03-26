
# Simulating reads with divergence

for species in elephant rhino ; do 

  for div in 1 2 3 4 5 6 9 12 15 ; do 
  
    path=...your parent directory.../gargammel
    ref_fasta=...your parent directory.../ref_genomes/${species}_genome.fa
    size_dist=${path}/size_dist/size_dist.tsv
    to_sim=${path}/div_simulations/${species}/div_${divergence}/
    sim=${path}/div_simulations/data/${species}_div${divergence}
    div=${path}/mismatch/div_${divergence}_single-
    
    # Create the necessary directories
    mkdir -p ${path}/div_simulations/${species}/div_${divergence}/endo/
    mkdir -p ${path}/div_simulations/${species}/div_${divergence}/cont/
    mkdir -p ${path}/div_simulations/${species}/div_${divergence}/bact/
    mkdir -p ${path}/div_simulations/data/
    cp $ref_fasta ${path}/div_simulations/${species}/div_${divergence}/endo/
    
    # Run Gargammel to simulate diverged reads
    echo
    echo "Simulating DNA for ${species} with divergence ${divergence}"
    echo
    perl ${path}/gargammel.pl -f $size_dist -n 18100000 -matfile $div -o $sim $to_sim
    gunzip ${sim}_d.fa.gz
    gunzip ${sim}.e.fa.gz
    echo
    echo "Finished simulation for ${species} with divergence ${divergence}"
    echo
    echo "Simulated DNA reads located in ${sim}_d.fa"
    echo
    
  done

done

# Simulating reads without divergence


for species in elephant rhino human bacteria; do

    path=...your parent directory.../gargammel
    ref_fasta=...your parent directory.../ref_genomes/${species}_genome.fa
    size_dist=${path}/size_dist/size_dist.tsv
    to_sim=${path}/nodiv_simulations/${species}/
    sim=${path}/nodiv_simulations/data/${species}


    mkdir ${path}/nodiv_simulations/${species} 


    #needed for gargammel input
    mkdir -p ${path}/nodiv_simulations/${species}/endo/
    mkdir -p ${path}/nodiv_simulations/${species}/cont/
    mkdir -p ${path}/nodiv_simulations/${species}/bact/
    mkdir -p ${path}/nodiv_simulations/data/
    cp $ref_fasta ${path}/nodiv_simulations/${species}/endo/
            
    #gargammel run

    echo
    echo

    echo "Simulating DNA for ${species}"
    echo
    echo
        
    perl gargammel.pl -f $size_dist -n 18100000 -o $sim $to_sim

    gunzip ${sim}_d.fa.gz

    echo
    echo "Finished simulation for ${species} with no divergence!"
    echo
    echo "Simulated DNA reads located in ${sim}_d.fa"
    echo


done



    
