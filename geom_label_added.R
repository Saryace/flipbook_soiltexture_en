
library(ggtern)
library(dplyr)
library(ggrepel)

soil_data <- data.frame(
  soil = c("a", "b", "c", "d"),
  sand = c(15, 18, 57, 32),
  silt = c(52, 70, 8, 26),
  clay = c(33, 12, 35, 42),
  om = c(1, 3, 4, 11),
  bd = c(1.33, 1.38, 1.76, 1.15)
)

data(USDA)

USDA_text <- USDA  %>% group_by(Label) %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)


ggplot(data = USDA, aes(y = Clay,
                        x = Sand,
                        z = Silt)) +
  coord_tern(L = "x", T = "y", R = "z") +
  geom_polygon(aes(fill = Label),
               alpha = 0.0,
               size = 0.5,
               color = "black") +
  geom_text(data = USDA_text,
            aes(label = Label),
            color = 'black',
            size = 2) +
  geom_point(data = soil_data,
             aes(x = sand,
                 y = clay,
                 z = silt)) +
  geom_label(data = soil_data,
             aes(x = sand,
                 y = clay,
                 z = silt,
                 label = soil),
                 hjust=0, vjust=0) +
  theme_showarrows() +
  theme_clockwise() +
  theme(text = element_text(family = "Helvetica")) +
  guides(fill = FALSE, color = FALSE)
