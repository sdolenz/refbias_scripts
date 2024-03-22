import argparse
import pysam

def extract(header):
    if "kraken:taxid" in header:
        # If the header contains "kraken:taxid" split at the second colon
        parts = header.split(":", 2)
        return parts[0] + ":" + parts[1]
    else:
        # Otherwise split at the first colon
        parts = header.split(":", 1)
        return parts[0]

def main(args):
    bam_file = args.bam_file
    output_file = args.output_file

    # Make a list to store extracted headers and read lengths
    extracted_data = []

    with pysam.AlignmentFile(bam_file, "rb") as samfile:
        for read in samfile:
            header = extract(read.qname)
            read_length = read.query_length
            extracted_data.append((header, read_length))

    with open(output_file, "w") as tsv:
        # Write the header
        tsv.write("Extracted Header\tRead Length\n")

        # Write the extracted data
        for header, read_length in extracted_data:
            tsv.write(f"{header}\t{read_length}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract read lengths by header in BAM")
    parser.add_argument("--bam_file", type=str, required=True, help="Input BAM file name.")
    parser.add_argument("--output_file", type=str, required=True, help="Output TSV file name.")
    args = parser.parse_args()

    main(args)
