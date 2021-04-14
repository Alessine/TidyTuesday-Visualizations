library(tidytuesdayR)
library(glue)
library(RColorBrewer)
library(tidyverse)
library(maps)
library(gganimate)

# Read in the data from the tidy tuesday library.
tuesdata <- tidytuesdayR::tt_load(2021, week = 16)

df_us_postoffices <- data.frame(tuesdata[1])

states <- map_data("state")

post_offices_1950 <- df_us_postoffices %>%
  filter(post_offices.established <= 1950 & 
           between(post_offices.longitude, -126, -60) &
           (post_offices.discontinued > 1950 | is.na(post_offices.discontinued)))

df_us_postoffices_2 <- df_us_postoffices %>%
  filter(between(post_offices.longitude, -126, -60))

theme_set(theme_void())
gg1 <- ggplot() +
  geom_polygon(data = states, aes(x = long, y = lat, group = group), fill = "midnightblue", color = "darkgrey") +
  coord_fixed(1.3)

plot_1950 <- gg1 +
  geom_point(data = post_offices_1950, aes(x = `post_offices.longitude`, y = `post_offices.latitude`), color = "yellow", size = 0.01) +
  labs(title = "Post Offices in mainland U.S. in 1950") +
  theme(plot.title = element_text(hjust = 0.08, margin = margin(t = -50, b = -10)))

gg2 <- ggplot() +
  geom_polygon(data = states, aes(x = long, y = lat, group = group), fill = "midnightblue", color = "darkgrey") +
  coord_fixed(1.3)

plot_est <- gg2 +
  geom_point(data = df_us_postoffices_2, aes(x = `post_offices.longitude`, y = `post_offices.latitude`), color = "yellow", size = 0.01) +
  labs(title = "Post Offices in mainland U.S.") +
  theme(plot.title = element_text(hjust = 0.08, margin = margin(t = -50, b = -10))) +
  transition_manual(`post_offices.established`, cumulative = TRUE)

anim <- animate(plot_est)

anim_save("US_postoffices_est.gif", anim)


