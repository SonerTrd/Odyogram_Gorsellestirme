# 2022-08-08
# Soner Turudu
# University of Groningen PhD student
# https://cran.r-project.org/web/packages/audiometry/vignettes/Intro_to_PTA_Standards.html
# Bernhard Lehnert

library(ggplot2)
library(audiometry)

ex1 <- data.frame(time = gl(5, 6),
                  f = rep(c(250, 500, 1000, 2000, 4000, 8000), 5),
                  t = c(0, 5, 0, 0, 15, 0, 
                        -5, -5, 0, -5, 0, 0,
                        0, -10, 0, -5, -5, -10,
                        0, 0, 0, 5, 0, -5,
                        10, 10, 10, 5, 25, 20  ))



ggpl <- gg_pta(ex1, lettermark = "L")
gg_pta(ex1, lettermark = "L") +
  geom_point(aes(x = f, y = t, color = time), size = 2, alpha=.5) +
  geom_line(aes(x = f, y = t, color = time), lwd=1) + 
  scale_color_manual(labels = c("PO1", "PO2", "PO3", "PO4", "PO5"),
                   values = c( "orchid", "lightsteelblue", "deepskyblue", "cyan", "grey"))+
  labs(color=( "Participants"))
ggsave("audiogram_plot4.png", width=6, height=4, device='png', units='in', dpi=400)




