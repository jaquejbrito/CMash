#!/bin/sh

#this script is based on the implementation in Metalign and 
#adjusted for CMash's needs.

numThreads=8
#cmashBaseName="cmash_db_n1000_k60"
cmashBaseName="TrainingDatabase"
cmashDatabase="${cmashBaseName}.h5"
cmashDump="${cmashBaseName}_dump.fa"

# dump all the k-mers in the new training database
echo "dumping training k-mers"
rm ${cmashDump} 2> /dev/null
python dump_kmers.py ${cmashDatabase} ${cmashDump}

#Remove KMC prefix and suffix files (generated by counting)
echo "running kmc"
rm "${cmashBaseName}.kmc_pre" 2> /dev/null
rm "${cmashBaseName}.kmc_suf" 2> /dev/null

# count all the k-mers in the training database
../KMC/bin/kmc -v -k21 -fa -ci1 -t"${numThreads}" -jlogsample ${cmashDump} "${cmashBaseName}_dump" .