#Here is the pipeline that will submit the scripts to simulated diverged reads, build simulated libraries, and map the simulated libraries to the appropriate reference genome using various alignment tools

#Dependencies: 

# Create mismatch files to simulate 1, 2, 3, 4, 5, 6, 9, 12, and 15 divergence

bash simulated_mismatch.sh

# Generate simulated reads with and without divergence

bash simulated_simulations.sh

