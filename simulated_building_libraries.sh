
path=...your parent directory.../sim_libraries
cp_path=...your parent directory.../gargammel

mkdir -p ${path}/temp_fastas

cd ${path}

cp ${cp_path}/div_simulations/data/*_d.fa ./
cp ${cp_path}/nodiv_simulations/data/*_d.fa ./


# endogenous (without and with divergence)

for species in elephant rhino ; do 

    mv ${species}_d.fa ${species}_div0_d.fa

    for div in 0 1 2 3 4 5 6 9 12 15 ; do

        python3 making_fastas.py -d div${div} -s ${species} -n 9050000
        mv ${species}_div${div}_9050000.fa ${species}_div${div}_50.fa

        python3 making_fastas.py -d div${div} -s ${species} -n 1810000
        mv ${species}_div${div}_1810000.fa ${species}_div${div}_10.fa

        python3 making_fastas.py -d div${div} -s ${species} -n 181000
        mv ${species}_div${div}_181000.fa ${species}_div${div}_1.fa

    done

done

# bacteria (without divergence)

for species in bacteria  ; do

        python3 making_fastas.py -s ${species} -n 8869000
        mv ${species}_8869000.fa ${species}_49.fa

        python3 making_fastas.py -s ${species} -n 16109000
        mv ${species}_16109000.fa ${species}_89.fa

        python3 making_fastas.py -s ${species} -n 17738000
        mv ${species}_17738000.fa ${species}_98.fa

done

# human (without divergence)

for species in human ; do 

    python3 making_fastas.py -s ${species} -n 181000
    mv ${species}_181000.fa ${species}_1.fa

done


#build the simulated libraries

for species in elephant rhino ; do 

    for div in 0 1 2 3 4 5 6 9 12 15 ; do

        cat "${species}_div${div}_d.fa" > "${species}_div${div}_100end.fa"

        cat "./old_temp_fastas/${species}_div${div}_50.fa" "./temp_fastas/human_1.fa" "./temp_fastas/bacteria_49.fa" > "${species}_div${div}_50end.fa"

        cat "./old_temp_fastas/${species}_div${div}_10.fa" "./temp_fastas/human_1.fa" "./temp_fastas/bacteria_89.fa" > "${species}_div${div}_10end.fa"

        cat "./old_temp_fastas/${species}_div${div}_1.fa" "./temp_fastas/human_1.fa" "./temp_fastas/bacteria_98.fa" > "${species}_div${div}_1end.fa"
    
    done

done

# Move the temporaries subsampled fastas to a new directory called temp_fastas

mv ${path}/*_d.fa ${path}/temp_fastas/
mv ${path}/*50.fa ${path}/temp_fastas/
mv ${path}/*10.fa ${path}/temp_fastas/
mv ${path}/*1.fa ${path}/temp_fastas/
mv ${path}/*bacteria* ${path}/temp_fastas/
mv ${path}/*human* ${path}/temp_fastas/

# Ensure that the each read is on a new line for the simulated libraries

for div in 1 2 3 4 5 6 9 12 15 ; do

  sed -i '0,/^>/! s/>/\n>/g' *div${div}*
  sed -i '0,/^>/! s/>/\n>/g' *div${div}*
  sed -i '0,/^>/! s/>/\n>/g' *div${div}*

done

