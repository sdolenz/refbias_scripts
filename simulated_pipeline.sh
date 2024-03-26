#Here is the pipeline that will submit the scripts to simulated diverged reads, build simulated libraries, and map the simulated libraries to the appropriate reference genome using various alignment tools

#Dependencies: python/3.9.5


#download gargammel from github, this will create a directory "gargammel" within your parent directory

path=...your parent directory.../gargammel
cd ${path}

# Create mismatch files to simulate 1, 2, 3, 4, 5, 6, 9, 12, and 15 divergence

bash simulated_mismatch.sh

# Generate simulated reads with and without divergence

bash simulated_simulations.sh

# Create and change to sim_libraries directory 

path2=...your parent directory.../sim_libraries
mkdir -p ${path2}
cd ${path2}

# Construct simulated libraries 

bash simulated_building_libraries.sh

# Map simulated libraries 
