load("DESeq.RData")
library(DESeq2)
library(stringr)
dim(se)
library(dplyr)
colnames(colData(se))[2] <- "Group"
colnames(colData(se))[3] <- "Patient"
se_exclude <- se
se_exclude <- se_exclude[,-(grep("L215A",colnames(se_exclude)))]
se_exclude <- se_exclude[,-(grep("193",colnames(se_exclude)))]
se_exclude$Patient<- str_replace_all(se_exclude$Patient,pattern = "p574",replacement = "p57")
se_exclude$Patient <- str_replace_all(se_exclude$Patient,pattern = "p575",replacement = "p57")
se_exclude$Patient <- str_replace_all(se_exclude$Patient,pattern = "p576",replacement = "p57")
se_exclude$Group
se_exclude$Group <- factor(se_exclude$Group, 
                          levels = c("N","T","L"),
                          labels = c("Normal","Tumor","Metastasis"))
dds <- DESeqDataSet(se_exclude, design = ~batch+Group )
nrow(dds)
dds <- dds[ rowSums(counts(dds)) > 1, ]



library("ggplot2")
plot_count <- function(topGene="MYC"){
  geneCounts <- plotCounts(dds, gene=topGene, intgroup=c("Group","Patient"), returnData=TRUE)
  ggplot(geneCounts, aes(x=Group, y=count, color=Patient, group=Patient)) +
    scale_y_log10() + 
    geom_point(size=3) +
    geom_line() +
    ggtitle(paste("Gene",topGene,sep = " "))+
    theme_bw()
  ggsave(paste(topGene,"png",sep = "."),width = 7,height = 6,
         path = getwd())
}

home <- getwd()
gene_list_368 <- read.delim(file = "368 common elements in TvsN and LvsT.txt",
                            header = FALSE  )
gene_list_368 <- as.vector(gene_list_368[,1])
gene_list_365 <- read.delim(file = "365 elements included exclusively in LvsT.txt",
                            header = FALSE  )
gene_list_365 <- as.vector(gene_list_365[,1])

#plot 368
dir.create(paste(home,"368_picture",sep = "/"))
setwd(paste(home,"368_picture",sep = "/"))
for (ID in 1:length(gene_list_368)) {
  plot_count(gene_list_368[ID])
}

#plot 365
dir.create(paste(home,"365_picture",sep = "/"))
setwd(paste(home,"365_picture",sep = "/"))

for (ID in 1:length(gene_list_365)) {
  plot_count(gene_list_365[ID])
}





