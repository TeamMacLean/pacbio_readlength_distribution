library(ggplot2)
library(readr)
args <- commandArgs(TRUE)
lengths = readr::read_tsv(as.character(args[1]), col_names=FALSE)
p = ggplot(lengths, aes(x=lengths$X2)) + geom_histogram(bins=100)

# change x axis ticks to vertical
p = p + theme(axis.text.x = element_text(angle=90, size=3), axis.text.y=element_text(size=3))

# add title
p = p + ggtitle("Distribution of read lengths")

# add darkblue border line
p = p + theme(axis.line = element_line(color = "darkblue", size = 1, linetype = "solid"))

# change x axis ticks with 1000 interval
p = p + scale_x_continuous(name="Read Lengths", breaks = seq(0,100000, by=1000) ) + scale_y_continuous(breaks=seq(0, 250000, by=1000))

# save plot
outputfilename = tools::file_path_sans_ext(basename(as.character(args[1])))
output = paste(outputfilename, ".png", sep="")
ggsave(filename = output,  plot = p, path="results", width = 7, height = 7, units="in")
