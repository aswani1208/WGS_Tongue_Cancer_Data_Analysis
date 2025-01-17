### Download data from SRA database

# install SRA tool kit to download the data

sudo apt-get install sra-toolkit

# configure SRA toolkit to save in current directory

vdb-config -i

# Modify your .bashrc file

export PATH=$PATH:$PWD/sratoolkit/bin

# Verify that the binaries will be found by the shell

which fastq-dump

# downloading data

mkdir sra_data
cd sra_data
prefetch ERR11468777 
prefetch ERR11468776
prefetch ERR11468775

# generate reads from pre-fetched download

fastq-dump --split-files --gzip \
    -X 1000000 ERR11468777/ERR11468777.sra
fastq-dump --split-files --gzip \
    -X 1000000 ERR11468776/ERR11468776.sra
fastq-dump --split-files --gzip \
    -X 1000000 ERR11468775/ERR11468775.sra   

# READ QC using FASTQC
# install FASTQC

wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip

# Unzip the archive

unzip /workspace/NGS_Data_Analysis/fastqc_v0.12.1.zip

# Run fastQC

/workspace/WGS_Tongue_Cancer_Data_Analysis/FastQC/fastqc ERR11468775_1.fastq.gz ERR11468775_2.fastq.gz
/workspace/WGS_Tongue_Cancer_Data_Analysis/FastQC/fastqc ERR11468776_1.fastq.gz ERR11468776_2.fastq.gz
/workspace/WGS_Tongue_Cancer_Data_Analysis/FastQC/fastqc ERR11468777_1.fastq.gz ERR11468777_2.fastq.gz

### html files will be created for both the Read 1 and Read 2 data.It can be opened and viewed in any browsers.

# Install fastp

# wget http://opengene.org/fastp/fastp
wget http://opengene.org/fastp/fastp --no-check-certificate

chmod a+x /workspace/WGS_Tongue_Cancer_Data_Analysis/fastp

# trimming reads

/workspace/WGS_Tongue_Cancer_Data_Analysis/fastp -i ERR11468775_1.fastq.gz -I ERR11468775_2.fastq.gz \
     -o ERR11468775_1_trimmed.fastq.gz -O ERR11468775_2_trimmed.fastq.gz

/workspace/WGS_Tongue_Cancer_Data_Analysis/fastp -i ERR11468776_1.fastq.gz -I ERR11468776_2.fastq.gz \
     -o ERR11468776_1_trimmed.fastq.gz -O ERR11468776_2_trimmed.fastq.gz

/workspace/WGS_Tongue_Cancer_Data_Analysis/fastp -i ERR11468777_1.fastq.gz -I ERR11468777_2.fastq.gz \
     -o ERR11468777_1_trimmed.fastq.gz -O ERR11468777_2_trimmed.fastq.gz