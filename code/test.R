# Sarah Van Alsten
# Date Created: OCTOBER 23, 2020
# Last Update: OCTOBER 23, 2020
# Packages Used: tidyverse, janitor
#
# Purpose: Epidemiologists can use R too! (example)
########################################################################################
library(tidyverse)

covid <- read.table("data/boroughs-case-hosp-death.txt", header = T, sep = ",")
covid <- janitor::clean_names(covid)

date_col <- covid$date_of_interest


pdf("output/NYC_Covid_Counts_example.pdf")
covid %>% 
  pivot_longer(cols = names(.)[2:ncol(.)], names_to = "measure", values_to = "quantity") %>%
  filter(str_detect(measure, "case_count")) %>%
  mutate(date_of_interest = lubridate::dmy(date_of_interest))%>%
  ggplot(aes(x = date_of_interest, y = quantity, color = measure, group = measure)) +
  geom_line() + 
  theme_bw() + 
  labs(x = "Date", y = "Daily Case Count", color = "Borough") +
  scale_color_discrete(labels = c("Brooklyn", "Bronx", "Manhattan", "Queens", "Staten Island"))
dev.off()
