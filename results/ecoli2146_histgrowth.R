require(ggplot2)

setwd("/home/heumos/git/pangenome-paper/results/")

ecoli <- read.table("ecoli2146.pan.explode.0.og.crush.og.2013.gfa.histgrowth.095.tsv", sep = "\t", as.is = T, skip = 6)
colnames(ecoli) <- c("#haps", "quorum>=0", "quorum>=95: Softcore pangenome.", "quorum>=50: Shell pangenome.", "quorum>=10: Cloud pangenome.")

g <- ggplot(ecoli, aes(x = `#haps`)) +
  aes(x = `#haps`) +
  #geom_point() +
  xlab("#haplotypes") +
  ylab("#base pairs") +
  geom_line(aes(y =`quorum>=0`), color = "darkred", linewidth = 1.5, linetype = "dashed") + 
  geom_line(aes(y = `quorum>=95: Softcore pangenome.`), color = "steelblue", linewidth = 1.5, linetype = "dashed") + 
  geom_line(aes(y = `quorum>=50: Shell pangenome.`), color = "darkgreen", linewidth = 1.5, linetype = "dashed") + 
  geom_line(aes(y = `quorum>=10: Cloud pangenome.`), color = "orange", linewidth = 1.5, linetype = "dashed") + 
  ylim(0, max(ecoli$`quorum>=0`)) +
  theme(text = element_text(size=20))
g

chr19_save <- ecoli
chr19_save$`quorum>=50: Shell pangenome.` <- ecoli$`quorum>=50: Shell pangenome.` - ecoli$`quorum>=95: Softcore pangenome.`
chr19_save$`quorum>=10: Cloud pangenome.` <- ecoli$`quorum>=10: Cloud pangenome.` - ecoli$`quorum>=50: Shell pangenome.`
chr19_save$`quorum>=0` <- ecoli$`quorum>=0` - ecoli$`quorum>=10: Cloud pangenome.`

species <- seq(1, 2013)
condition <- c(rep(c("quorum>=0"), 2013),rep(c("quorum>=95: Softcore pangenome."), 2013),rep(c("quorum>=50: Shell pangenome."), 2013),rep(c("quorum>=10: Cloud pangenome."), 2013))
condition <- factor(condition, levels = c("quorum>=0", "quorum>=10: Cloud pangenome.", "quorum>=50: Shell pangenome.", "quorum>=95: Softcore pangenome."))
value <- c(chr19_save$`quorum>=0`,chr19_save$`quorum>=95: Softcore pangenome.`, chr19_save$`quorum>=50: Shell pangenome.`, chr19_save$`quorum>=10: Cloud pangenome.`)
data2 <- data.frame(species,condition,value)

# Stacked
p <-ggplot(data2, aes(fill=condition, y=value, x=species)) + 
  geom_bar(stat="identity", position = "stack") +
  scale_fill_manual(values=c("#e41a1c", 
                             "#377eb8", 
                             "#4daf4a", 
                             "#984ea3"))  + labs(fill='growth type') + xlab("#haplotypes") + ylab("#base pairs") +
  theme(legend.position="bottom") +
  theme(legend.text=element_text(size=7))
p
ggsave("ecoli2013_histgrowth.pdf", p, width = 8, height = 5)
ggsave("ecoli2013_histgrowth.png", p, width = 8.5, height = 5)

# original panacus colors
p <-ggplot(data2, aes(fill=condition, y=value, x=species)) + 
  geom_bar(stat="identity", position = "stack") +
  scale_fill_manual(values=c('#f77189', '#bb9832', '#50b131', '#36ada4', '#3ba3ec', '#e866f4'))  + labs(fill='growth type') + xlab("#base pairs") + ylab("#haplotypes")
p

