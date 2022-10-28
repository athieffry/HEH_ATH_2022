library(tidyverse)
library(tidylog)
library(magrittr)
library(readxl)
library(reshape2)


'h' <- head

# 1. READ DATA ####
# -----------------
TCs <- read_xlsx('~/Dropbox/Documents/HEH - Guest Lecturing/HEH_ATH_2022/data/CAGE_TC_counts.xlsx', col_names=T)


# 2. PLOT TOTAL LIBRARY SIZES ####
# --------------------------------
TCs %>%
  column_to_rownames('TC_id') %>%
  colSums() %>%
  enframe(name='sample', value='lib_size') %>%
  separate(col='sample', into=c('genotype', 'reps'), sep='_') %>%
  ggplot(aes(x=genotype, y=lib_size, fill=reps)) +
         geom_col(col='black', lwd=.3, position=position_dodge())

reshape2::melt() # wide => long
tidyr::pivot_wider() # long => wide
tidyr::separate() # split columns into more colums based on char


# 1. Gardez uniquement les genotypes wild type ####
TCs %>%
  select(TC_id, matches('wt')) %>%
# 2. Gardez uniquement les TCs situés sur le Chr3 (TC_id) ####
  filter(str_detect(TC_id, 'Chr3')) %>%
  # change from wide to long format ####
  melt(id.vars='TC_id', variable.name='sample', value.name='readcounts') %>%
  # separate genotype from replicates into two columns ####
  separate(col='sample', into=c('genotype', 'reps'), sep='_') %>%
# 3. Plot: distribution (density) pour chaque réplicat des wt, color=rep ####
  ggplot(aes(x=readcounts, col=reps)) +
         geom_density() +
         # make X-axis on a log-scale ####
         scale_x_log10() +
         # give meaningful legends ####
         labs(title='Distribution of TC expression in WT samples',
              subtitle='Chr3 only',
              x='TC readcount') +
         # make graph wider
         theme(aspect.ratio=.5)




# 2. NORMALIZE INTO TPM ####
# --------------------------
# a. get TPM normalization factors (sum of reads / 1000000)
TPM_factors <- TCs %>%
               select(-TC_id) %>%
               colSums() %>%
               enframe(name='sample', value='lib_size') %>%
               mutate('lib_size'=lib_size/1000000)
TPM_factors

# b. normalize into TPM, sample-wise
TCs_TPM <- TCs %>%
           column_to_rownames('TC_id') %>%
           apply(MARGIN=1, FUN=divide_by, TPM_factors$lib_size) %>%
           t() %>%
           as.data.frame()

h(TCs_TPM)

  # sanity check: all TPM values add up to 1000000 for each sample
  colSums(TCs_TPM)



# 3. MAKE HEATMAP OF TOP 1000 MOST EXPRESSED TCs ACROSS SAMPLES ####
# ------------------------------------------------------------------
# a. get top 1000 most variable TC_ids across samples
top_TCs <- TCs_TPM %>%
           apply(MARGIN=1, var) %>%
           sort(decreasing=T) %>%
           names() %>%
           head(1000)

top_TCs_TPM <- TCs_TPM %>%
               filter(rownames(.) %in% top_TCs)

# b. plot TC TPM expression distribution
top_TCs_TPM %>%
  melt() %>%
  separate('variable', c('geno', 'rep'), sep='_') %>%
  ggplot(aes(x=value, col=geno, lty=rep)) +
         geom_density() +
         scale_x_log10()


