import sys
import argparse
from Bio import SeqIO
from random import sample


parser = argparse.ArgumentParser(description='Randomly choose sequences to build fasta datasets with simulated DNA')
parser.add_argument('-s', '--species',  action='store', type=str, help='species to add')
parser.add_argument('-d', '--divergence', nargs='?', const=True, default=False, help='divergence added; write as div1')
parser.add_argument('-n', '--number', action='store', type=int, help='number of reads')
args = parser.parse_args()

species = args.species
div = args.divergence
nread = args.number


if div:
    output_filename = "{}_{}_{}.fa".format(species, div, nread)
    with open(output_filename, 'w') as output_file:
        with open("{}_{}_d.fa".format(species, div)) as f:
            seqs = SeqIO.parse(f, "fasta")
            samps = ((seq.name, seq.seq) for seq in sample(list(seqs), nread))
            for samp in samps:
                output_file.write(">{}\n{}".format(*samp))
else:
    output_filename = "{}_{}.fa".format(species, nread)
    with open(output_filename, 'w') as output_file:
        with open("{}_d.fa".format(species)) as f:
            seqs = SeqIO.parse(f, "fasta")
            samps = ((seq.name, seq.seq) for seq in sample(list(seqs), nread))
            for samp in samps:
                output_file.write(">{}\n{}".format(*samp))

print("finished")
