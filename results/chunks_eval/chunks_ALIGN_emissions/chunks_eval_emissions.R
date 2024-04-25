require(ggplot2)

setwd("/home/heumos/git/pangenome-paper/results/chunks_eval/chunks_ALIGN_emissions//")

chunks1 <- read.table("1chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks2 <- read.table("2chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks4 <- read.table("4chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks8 <- read.table("8chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks16 <- read.table("16chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks32 <- read.table("32chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks64 <- read.table("64chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks128 <- read.table("128chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks256 <- read.table("256chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks512 <- read.table("512chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1
chunks1024 <- read.table("1024chunks_ALIGN_emissions.tsv", sep = "\t", as.is = T)$V1

chunky_boy <- c(chunks1, chunks2, chunks4, chunks8, chunks16, chunks32, chunks64, chunks128, chunks256, chunks512, chunks1024)
texty_boy <- c("1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024")

df <- data.frame(chunky_boy)
df$texty_boy <- texty_boy
df$texty_boy <- as.character(df$texty_boy)
df$texty_boy <- factor(df$texty_boy, levels=unique(df$texty_boy))

g <- ggplot(df, aes(group = 1)) +
  aes(x = texty_boy, y = chunky_boy) + 
  geom_point() +
  scale_y_log10() +
  xlab("number of chunks") +
  ylab("CO2e emissions in kg") +
  geom_line() + 
  ylim(0, 30) +
  theme(text = element_text(size=20))

g
ggsave("by_chunks_ALIGN_emissions.pdf", g)
ggsave("by_chunks_ALIGN_emissions.png", g)
