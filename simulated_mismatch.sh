#As a note: For an unknown reason gargammel was outputing divergence 3-fold which is why the divergence percentages are divided by 3 and edited using sed. The code may be a bit messy, but it works :)


# Make 5' files for all divergence levels

for amount in 1 2 3 4 5 6 9 12 15 ; do 

    path=...your parent directory.../gargammel/mismatch
    file=${path}/div_${amount}_single-5.dat

    mkdir -p ${path}
    touch ${file}

    cat ${file} | seq 0 201 > ${file}

    awk 'BEGIN {OFS="\t"} NR == 1 \
    {print "", "A->C", "A->G", "A->T", "C->A", "C->G","C->T", "G->A", "G->C", "G->T", "T->A", "T->C", "T->G"} \
    NR > 1 {print NR-2, "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'"}' \
    ${file} > ${file}.tmp && mv ${file}.tmp ${file}

    
    if [ "$amount" == 1 ]; then

        sed -i 's/.01/0.00333333 [0.00266667..0.00400000]/g' ${file}

    elif [ "$amount" == 2 ]; then

        sed -i 's/.02/0.00666667 [0.00333333..0.01000000]/g' ${file}

    elif [ "$amount" == 3 ]; then

        sed -i 's/.03/0.010 [0.005..0.015]/g' ${file}

    elif [ "$amount" == 4 ]; then

        sed -i 's/.04/0.01333333 [0.01000000..0.01666667]/g' ${file}

    elif [ "$amount" == 5 ]; then
        sed -i 's/.05/0.01666667 [0.01333333..0.02000000]/g' ${file}

    elif [ "$amount" == 6 ]; then
        sed -i 's/.06/0.02 [0.01..0.03]/g' ${file}

    elif [ "$amount" == 9 ]; then
        sed -i 's/.09/0.03 [0.02..0.04]/g' ${file}

    elif [ "$amount" == 12 ]; then
        sed -i 's/.012/0.04 [0.03..0.05]/g' ${file}

    else
        sed -i 's/.015/0.05 [0.04..0.06]/g' ${file}

    fi

done 


# Make 3' files for all divergence levels

for amount in 1 2 3 4 5 6 9 12 15 ; do

    path=/crex1/proj/sediment_paleogenomics/private/1_STEPHANIE_DOLENZ/simulations_tom/gargammel/mismatch
    file=${path}/div_${amount}_single-3.dat

    touch ${file}

    cat ${file} | seq -f "replace%g" 201 -1 0 > ${file}

    sed -i 's/replace/-/g' ${file}

    sed -i 's/-0/0/' ${file}

    awk 'BEGIN {OFS="\t"} NR == 1 \
    {print "", "A->C", "A->G", "A->T", "C->A", "C->G","C->T", "G->A", "G->C", "G->T", "T->A", "T->C", "T->G"} \
    NR > 1 {print $1, "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'", "'.0${amount}'"}' \
    ${file} > ${file}.tmp && mv ${file}.tmp ${file}


    if [ "$amount" == 1 ]; then

        sed -i 's/.01/0.00333333 [0.00266667..0.00400000]/g' ${file}

    elif [ "$amount" == 2 ]; then

        sed -i 's/.02/0.00666667 [0.00333333..0.01000000]/g' ${file}

    elif [ "$amount" == 3 ]; then

        sed -i 's/.03/0.010 [0.005..0.015]/g' ${file}

    elif [ "$amount" == 4 ]; then

        sed -i 's/.04/0.01333333 [0.01000000..0.01666667]/g' ${file}

    elif [ "$amount" == 5 ]; then
        sed -i 's/.05/0.01666667 [0.01333333..0.02000000]/g' ${file}

    elif [ "$amount" == 6 ]; then
        sed -i 's/.06/0.02 [0.01..0.03]/g' ${file}

    elif [ "$amount" == 9 ]; then
        sed -i 's/.09/0.03 [0.02..0.04]/g' ${file}

    elif [ "$amount" == 12 ]; then
        sed -i 's/.012/0.04 [0.03..0.05]/g' ${file}

    else
        sed -i 's/.015/0.05 [0.04..0.06]/g' ${file}

    fi

done
