# 2022-08-08
# Soner Turudu
# University of Groningen PhD student
# https://cran.r-project.org/web/packages/audiometry/vignettes/Intro_to_PTA_Standards.html
# Bernhard Lehnert

library(ggplot2)
library(audiometry)

ex1 <- data.frame(time = gl(2, 6),
                  f = rep(c(250, 500, 1000, 2000, 4000, 8000), 2),
                  t = c(5, 5, 5, 5, 5, -5, 
                        -5, -5, 0, -5, 5, 0
                  ))


ggpl <- gg_pta(ex1, lettermark = "")
gg_pta(ex1, lettermark = "") +
  geom_point(aes(x = f, y = t, color = time), size = 2, alpha=.5) +
  geom_line(aes(x = f, y = t, color = time), lwd=1) + 
  scale_color_manual(labels = c("Right Ear", "Left Ear"),
                     values = c("red", "blue"))+
  labs(color=( ""))

ggsave("audiogram_plot5.png", width=6, height=4, device='png', units='in', dpi=400) 

