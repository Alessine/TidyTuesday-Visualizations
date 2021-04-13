#library(tidytuesdayR)
#library(glue)
#library(RColorBrewer)
#library(tidyverse)
#library(maps)

# Read in the data from the tidy tuesday library.
#tuesdata <- tidytuesdayR::tt_load(2021, week = 16)

df_us_postoffices <- data.frame(tuesdata[1])
summary(df_us_postoffices)

us_map <- map_data("usa")
states <- map_data("state")

post_offices_1950 <- df_us_postoffices %>%
  filter(post_offices.established <= 1950 & 
           between(post_offices.longitude, -126, -60) &
           (post_offices.discontinued > 1950 | is.na(post_offices.discontinued)))
post_offices_1950

theme_set(theme_void())
gg1 <- ggplot() +
  geom_polygon(data = states, aes(x = long, y = lat, group = group), fill = "midnightblue", color = "dimgrey") +
  coord_fixed(1.3)

gg1 +
  geom_point(data = post_offices_1950, aes(x = `post_offices.longitude`, y = `post_offices.latitude`), color = "yellow", size = 0.1)



