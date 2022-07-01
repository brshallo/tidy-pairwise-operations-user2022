library(tidyverse)
library(palmerpenguins)
library(corrr)
library(recipes)
# devtools::install_github("TimTeaFan/dplyover")
library(dplyover)
options(digits = 2)

ppenguins <- na.omit(penguins) %>%
  rename(bi_len_mm = bill_length_mm,
         bi_dep_mm = bill_depth_mm,
         fl_len_mm = flipper_length_mm)

# base cor()
ppenguins %>%
  select(contains("_mm")) %>%
  cor()

# corrr examples
ppenguins %>%
  select(contains("_mm")) %>%
  corrr::correlate()

ppenguins %>%
  select(contains("_mm")) %>%
  corrr::correlate() %>% 
  corrr::shave()

ppenguins %>%
  select(contains("_mm")) %>%
  corrr::correlate() %>% 
  corrr::focus(bi_len_mm)

cor_p_value <- function(x, y) stats::cor.test(x, y)$p.value

ppenguins %>%
  select(contains("_mm")) %>%
  corrr::colpair_map(cor_p_value)

made_up_agg <- function(x, y) mean((x + y) / 2)

ppenguins %>%
  select(contains("_mm")) %>%
  corrr::colpair_map(made_up_agg)

# recipes examples of pairwise correlations
rec <- recipe(body_mass_g ~ bi_len_mm + bi_dep_mm + fl_len_mm, data = ppenguins) %>% 
  step_ratio(all_predictors(), 
             denom = denom_vars(all_predictors()))

rec %>% 
  prep(data = ppenguins) %>% 
  juice() %>% 
  glimpse()

# dplyover examples
cor_p_value <- function(x, y) stats::cor.test(x, y)$p.value

ppenguins %>% 
  mutate(across2x(contains("_mm"),
                  contains("_mm"),
                  list(ratio = `/`, difference = `-`),
                  .names = "{fn}_{xcol}_{ycol}"))

ppenguins %>% 
  group_by(species) %>% 
  summarise(n = n(),
            across2x(.xcols = contains("_mm"), 
                     .ycols = contains("_mm"),
                     .fns = list(pval = ~cor_p_value(.x, .y)), 
                     .names = "{fn}_{xcol}_{ycol}",
                     .comb = "minimal"))


ppenguins %>% 
  group_by(species) %>%
  summarise(across2x(.xcols = contains("_mm"), 
                     .ycols = contains("_mm"),
                     .fns = cor, 
                     .comb = "minimal"),
            n = n())

summarise(cells_numeric, across2x(where(is.numeric), where(is.numeric), cor, .comb = "minimal"))
library(modeldata)

data(cells)
cells_numeric <- select(cells, where(is.numeric))

dim(cells_numeric)

library(dplyover)
summarise(cells_numeric, across2x(where(is.numeric), where(is.numeric), cor, .comb = "minimal"))
