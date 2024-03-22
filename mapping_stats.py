import pysam
import os
from Bio import SeqIO

def count_sequences_by_length_bin(fasta_file):
    sequence_counts = {}
    for record in SeqIO.parse(fasta_file, 'fasta'):
        read_length = len(record.seq)
        sequence_counts[read_length] = sequence_counts.get(read_length, 0) + 1
    return sequence_counts

def process_bam_file(bam_file):
    bam = pysam.AlignmentFile(bam_file, "rb")
    read_length_counts = {}

    # Extract alignment type from the BAM filename
    alignment_type = os.path.basename(bam_file).split("_")[0]

    for read in bam:
        read_length = read.query_length
        read_name_parts = read.query_name.split(":")
        
        if alignment_type.startswith(("bwamem", "local")):
            is_matching = read_name_parts[2] == str(read.reference_start)
            cigar = read.cigartuples
            if cigar and cigar[0][0] == 4:  # Checking for soft clipping
                soft_clipping_length = cigar[0][1]
                soft_clipped_start = read.reference_start - soft_clipping_length
                is_matching = read_name_parts[2] == str(soft_clipped_start)

        else:
            # For other alignment types, perform standard matching
            is_matching = read_name_parts[2] == str(read.reference_start)

        if read_length not in read_length_counts:
            read_length_counts[read_length] = {"total_mapped_reads": 0, "mismapped_reads": 0, "correctly_mapped_reads": 0}

        read_length_counts[read_length]["total_mapped_reads"] += 1
        if is_matching:
            read_length_counts[read_length]["correctly_mapped_reads"] += 1
        else:
            read_length_counts[read_length]["mismapped_reads"] += 1

    bam.close()
    return read_length_counts


def write_tsv(read_length_counts, output_file, sequence_counts):
    with open(output_file, "w") as f:
        f.write("Read_Length\tMismapped_Reads\tCorrectly_Mapped_Reads\tTotal_Mapped_Reads\tTotal_Reads\tUnmapped_Reads\n")
        for read_length, counts in read_length_counts.items():
            total_mapped_reads_count = counts["total_mapped_reads"]
            mismapped_reads = counts["mismapped_reads"]
            correctly_mapped_reads = counts["correctly_mapped_reads"]
            total_reads = sequence_counts[read_length]
            unmapped_reads = total_reads - total_mapped_reads_count

            f.write(f"{read_length}\t{mismapped_reads}\t{correctly_mapped_reads}\t{total_mapped_reads_count}\t{total_reads}\t{unmapped_reads}\n")

# Get the current directory
current_directory = os.getcwd()
bams_directory = os.path.join(current_directory, 'bams')
fastas_directory = os.path.join(current_directory, 'fastas')
new_tsvs_directory = os.path.join(current_directory, 'new_tsvs')

# Ensure the new_tsvs directory exists, if not, create it
if not os.path.exists(new_tsvs_directory):
    os.makedirs(new_tsvs_directory)

# Iterate over all fasta files
fasta_counts = {}
for fasta_file_name in os.listdir(fastas_directory):
    if fasta_file_name.endswith(".fa") and os.path.isfile(os.path.join(fastas_directory, fasta_file_name)):
        fasta_file = os.path.join(fastas_directory, fasta_file_name)
        sequence_counts = count_sequences_by_length_bin(fasta_file)
        fasta_counts[fasta_file_name] = sequence_counts


# Iterate over all bam files in the bams directory
for bam_file_name in os.listdir(bams_directory):
    if bam_file_name.endswith(".bam") and os.path.isfile(os.path.join(bams_directory, bam_file_name)):
        bam_file = os.path.join(bams_directory, bam_file_name)

        # Determine the prefix and parts of the BAM file name
        bam_file_parts = bam_file_name.split('_')
        if bam_file_parts[0] in ['sensitive', 'verysensitive', 'local']:
            # remove first part if it is sensitive, verysensitive, or local
            bam_file_parts = bam_file_parts[1:]

        corresponding_fasta_name = '_'.join(bam_file_parts[1:4]) + '.fa'
        sequence_counts = fasta_counts[corresponding_fasta_name]
        read_length_counts = process_bam_file(bam_file)

        # Output TSV file
        output_file = os.path.join(new_tsvs_directory, f"{bam_file_name.replace('.bam', '_mapping_stats.tsv')}")
        write_tsv(read_length_counts, output_file, sequence_counts)
        print(f"Processed {bam_file_name} and corresponding {corresponding_fasta_name}. Output saved to {output_file}")
