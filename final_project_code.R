# BIO 410 Final Project
# Srijan Joshi

# Load required libraries
library(Biostrings)
library(DECIPHER)

# Read in MEGAHIT assembly results for each of the 6 samples
allcontigs <- c()

for(i in 1:6){
  contigs <- readDNAStringSet(paste0('~/C:/Users/DELL/Downloads/Srijan/srijan/t', i, '_out/final.contigs.fa'))
  allcontigs <- c(allcontigs, contigs)
}

# Flatten the list output from the loop into a single object
allcontigs <- do.call(c, allcontigs)

# Filter to keep only contigs larger than 5000 bp
# (the full genome is ~18 kbp; smaller fragments are assembly artifacts)
toalign <- allcontigs[which(nchar(allcontigs) > 5000)]

# Rename sequences numerically for cleaner output
names(toalign) <- 1:length(toalign)

# Perform multiple sequence alignment on all assembled contigs
aligned <- AlignSeqs(toalign)

# Visualize alignment and save as HTML file for GitHub submission
BrowseSeqs(aligned, htmlFile = "alignment.html")

# Build a maximum likelihood phylogenetic tree from the alignment
tree <- Treeline(aligned, method = "ML", showPlot = TRUE)

# Save the phylogenetic tree as a PNG image for GitHub submission
png("phylogenetic_tree.png", width = 900, height = 700)
plot(tree)
dev.off()
