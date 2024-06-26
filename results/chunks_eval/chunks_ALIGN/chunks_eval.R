require(ggplot2)

setwd("/home/heumos/git/pangenome-paper/results/chunks_eval/chunks_ALIGN/")

chunks1 <- read.table("1chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks2 <- read.table("2chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks4 <- read.table("4chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks8 <- read.table("8chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks16 <- read.table("16chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks32 <- read.table("32chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks64 <- read.table("64chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks128 <- read.table("128chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks256 <- read.table("256chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks512 <- read.table("512chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1
chunks1024 <- read.table("1024chunks_ALIGN.tsv", sep = "\t", as.is = T)$V1

# function to iterate: normalize to minutes, then take the mean and collapse in one value (
# in the future some kind of box plot for e.g. 1024 chunks, but not for this report
format_time <- function(s, cond=F) {
  m <- 0
  s_d <- strsplit(s, "d")
  # TODO IF!
  if (length(s_d[[1]]) > 1) {
    m <- m + (as.integer(s_d[[1]][1])*1440) 
    s_h <- strsplit(s_d[[1]][2], "h")
  } else {
    s_h <- strsplit(s_d[[1]][1], "h")
  }
  if (length(s_h[[1]]) > 1) {
    m <- m + (as.integer(s_h[[1]][1])*60)
    s_m <- strsplit(s_h[[1]][2], "m")
  } else {
    s_m <- strsplit(s_h[[1]][1], "m")
  }
  if (length(s_m[[1]]) > 1) {
    m <- m + (as.integer(s_m[[1]][1]))    
  }
  if (cond) {
    if (m == 0) {
      m <- as.integer(strsplit(s, "s")[[1]][1]) / 60
    } 
  }
  return(m)
}

chunks1 <- format_time(chunks1)
chunks2 <- mean(unlist(lapply(chunks2, format_time)))
chunks8 <- mean(unlist(lapply(chunks8, format_time)))
chunks16 <- mean(unlist(lapply(chunks16, format_time)))
chunks32 <- mean(unlist(lapply(chunks32, format_time)))
chunks64 <- mean(unlist(lapply(chunks64, format_time)))
chunks128 <- mean(unlist(lapply(chunks128, format_time)))
chunks256 <- mean(unlist(lapply(chunks256, format_time)))
chunks512 <- mean(unlist(lapply(chunks512, format_time)))
chunks4 <- mean(unlist(lapply(chunks4, format_time)))
chunks1024 <- mean(unlist(lapply(chunks1024, format_time)))

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
  ylab("time in minutes (log10 scale)") +
  geom_line() + 
  theme(text = element_text(size=20))

g
ggsave("by_chunks_ALIGN.pdf", g)
ggsave("by_chunks_ALIGN.png", g)

#### VIOLIN ####

chunks1 <- read.table("1chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks2 <- read.table("2chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks4 <- read.table("4chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks8 <- read.table("8chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks16 <- read.table("16chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks32 <- read.table("32chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks64 <- read.table("64chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks128 <- read.table("128chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks256 <- read.table("256chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks512 <- read.table("512chunks_ALIGN.tsv", sep = "\t", as.is = T)
chunks1024 <- read.table("1024chunks_ALIGN.tsv", sep = "\t", as.is = T)

chunks1$gr <- "1"
chunks2$gr <- "2"
chunks4$gr <- "4"
chunks8$gr <- "8"
chunks16$gr <- "16"
chunks32$gr <- "32"
chunks64$gr <- "64"
chunks128$gr <- "128"
chunks256$gr <- "256"
chunks512$gr <- "512"
chunks1024$gr <- "1024"

chunks1$V1 <- format_time(chunks1$V1)
chunks2$V1 <- unlist(lapply(chunks2$V1, format_time))
chunks4$V1 <- unlist(lapply(chunks4$V1, format_time))
chunks8$V1 <- unlist(lapply(chunks8$V1, format_time))
chunks16$V1 <- unlist(lapply(chunks16$V1, format_time))
chunks32$V1 <- unlist(lapply(chunks32$V1, format_time))
chunks64$V1 <- unlist(lapply(chunks64$V1, format_time))
chunks128$V1 <- unlist(lapply(chunks128$V1, format_time))
chunks256$V1 <- unlist(lapply(chunks256$V1, format_time))
chunks512$V1 <- unlist(lapply(chunks512$V1, format_time))
chunks1024$V1 <- unlist(lapply(chunks1024$V1, format_time))

violin_chunks <- rbind(chunks1, chunks2, chunks4, chunks8, chunks16, chunks32, chunks64, chunks128, chunks256, chunks512, chunks1024)

group <- as.character(violin_chunks$gr)
library("dplyr")
violin_chunks <- violin_chunks %>%
  mutate(gr=factor(gr,levels=c("1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024")))

p <- ggplot(violin_chunks, aes(x=gr, y=V1)) + 
  geom_violin() +
  scale_y_log10() +
  xlab("number of chunks") +
  ylab("time in minutes (log10 scale)") +
#  ylim(c(0, 4200)) +
  theme(text = element_text(size=20))
p

p <- ggplot(violin_chunks, aes(x=gr, y=V1)) + 
  geom_boxplot() +
  scale_y_log10() +
  xlab("number of chunks") +
  ylab("time in minutes (log10 scale)") +
  theme(text = element_text(size=20))
p

ggsave("by_chunks_ALIGN_violin.pdf", p)
ggsave("by_chunks_ALIGN_violing.png", p)

#### HAPS ####

# haps2 <- format_time(read.table("2haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps4 <- format_time(read.table("4haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps8 <- format_time(read.table("8haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps16 <- format_time(read.table("16haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps32 <- format_time(read.table("32haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps64 <- format_time(read.table("64haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps128 <- format_time(read.table("128haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps256 <- format_time(read.table("256haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps512 <- format_time(read.table("512haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# haps1024 <- format_time(read.table("1024haps_ALIGN.tsv", sep = "\t", as.is = T)$V1,T)
# 
# happy_boy <- c(haps2, haps4, haps8, haps16, haps32, haps64, haps128, haps256, haps512, haps1024)
# texty_boy <- c("2", "4", "8", "16", "32", "64", "128", "256", "512", "1024")
# 
# df <- data.frame(happy_boy)
# df$texty_boy <- texty_boy
# df$texty_boy <- as.character(df$texty_boy)
# df$texty_boy <- factor(df$texty_boy, levels=unique(df$texty_boy))
# 
# g <- ggplot(df, aes(group = 1)) +
#   aes(x = texty_boy, y = happy_boy) + 
#   geom_point() +
#   xlab("number of haplotypes") +
#   ylab("time in seconds (log10 scale)") +
#   scale_y_log10() +
#   geom_line() + 
#   theme(text = element_text(size=14))
# g
# ggsave("by_haps_ALIGN.pdf", g)
# ggsave("by_haps_ALIGN.png", g)
# 
# #### co2 chunks ####
# co2 <- read.table("co2.tab", as.is = T, header = T, sep = "\t", check.names = F)
# co2 <- co2[order(co2$chunks),]
# co2$chunks <- as.character(co2$chunks)
# co2$chunks <- factor(co2$chunks, levels = co2$chunks)
# g <- ggplot(co2, aes(group = 1)) +
#   aes(x = chunks, y = emissions_in_kg) + 
#   geom_point() +
#   xlab("number of chunks") +
#   ylab("emissions in kg") +
#   geom_line() + 
#   expand_limits(y = 0) +
#   theme(text = element_text(size=14))
# g
# 
# ggsave("by_chunks_co2.pdf", g)
# ggsave("by_chunks_co2.png", g)
