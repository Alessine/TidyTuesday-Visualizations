library(tidytuesdayR)
library(glue)
library(RColorBrewer)
library(tidyverse)

# Read in the data from the tidy tuesday library.
#tuesdata <- tidytuesdayR::tt_load(2021, week = 16)

df_us_postoffices <- data.frame(tuesdata[1])
summary(df_us_postoffices)
