# To generate tsvs for simulated datasets and to run AMBER to generate figures in paper and also for MQ comparison of all simulated datasets

# Dependencies: samtools/1.16 python/3.9.5 pysam/0.17.0-python3.9.5

# Download AMBER on github which will create a directory called AMBER in your parent directory

path=...your parent directory.../AMBER

cd ${path}

echo
echo "Run amber_make_tsvs.sh"
echo

bash amber_make_tsvs.sh

echo
echo "Done!"
echo

echo
echo "Run amber_submit.sh"
echo

bash amber_submit.sh

echo
echo "Done!"
echo
