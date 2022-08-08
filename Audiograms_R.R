# 2022-08-08
# Soner Turudu
# University of Groningen PhD student
# https://cran.r-project.org/web/packages/audiometry/vignettes/Intro_to_PTA_Standards.html
# Bernhard Lehnert

library(ggplot2)
library(audiometry)


ex1 <- data.frame(time = gl(5, 6),
                  f = rep(c(250, 500, 1000, 2000, 4000, 8000), 5),
                  t = c(5, 5, 5, 5, 5, -5, 
                        -5, -5, 0, -5, 5, 0,
                        0, -5, -5, 0, -5, 5,
                        -5, 0, 5, 0, 0, -5,
                        5, 15, 10, 10, 20, 30
                        ))


ggpl <- gg_pta(ex1, lettermark = "R")
gg_pta(ex1, lettermark = "R") +
  geom_point(aes(x = f, y = t, color = time), size = 2, alpha=.5) +
  geom_line(aes(x = f, y = t, color = time), lwd=1) + 
  scale_color_manual(labels = c("PO1", "PO2", "PO3", "PO4", "PO5"),
                   values = c("red", "blue", "green", "Yellow", "orange", "purple", "brown", "pink", "wheat", "seagreen", "orchid", "lightsteelblue", "deepskyblue", "cyan", "antiquewhite"))+
  labs(color=( "Participants"))

ggsave("audiogram_plot3.png", width=6, height=4, device='png', units='in', dpi=400) 




