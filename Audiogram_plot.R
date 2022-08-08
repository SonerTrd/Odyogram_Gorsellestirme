# 2022-08-08
# Soner Turudu
# University of Groningen PhD student
# https://www.timschoof.com/post/plotting-audiograms-in-r/


# Hazirlik asamasi 

# Dosyalarinizin bulundugu klasoru seciniz
setwd("/Users/SonerTrd/Desktop/")

if (!require(here)) install.packages("here")
if (!require(tidyverse)) install.packages("tidyr")


# Verilerin yuklenmesi 

ody = read.csv('audiogram_plot1.csv', sep=";",header=T)


# Verilerin duzenlenmesi 

# Verileri genis formattan uzun formata donusturuyoruz
# https://www.statology.org/long-vs-wide-data/
if("group" %in% colnames(ody)){
  long_data = gather(ody, key = "ear-freq", value = "dB",-participant,-group)
} 

# R125 kismindaki kulak yonunu ve frekansi ayirdik
ody1 = long_data %>% 
  separate(col = "ear-freq", into = c("ear","freq"), sep = (1))

# Kulak yonunu degiskene cevirdik (factor in R) ve R yerine right yaptik
# Ayrica 8000 yerine 8, 250 yerine 0.25 yazmasini sagladik. Baslikta kHz belirtecegiz
ody1 <- long_data %>% 
  separate(col = "ear-freq", into = c("ear","freq"), sep = (1)) %>%
  mutate(freq = (type.convert(freq))/1000) %>% 
  mutate(freqLabels = formatC(freq, format="g")) %>% 
  mutate(ear = factor(ear, levels = c("R", "L"))) %>%
  mutate(ear = recode(ear, "R" = "Right", "L" = "Left")) 

# Bos satirlar silindi
# Verileri direk bos satirlari silerek de hazirlayabilirsiniz
ody2 = subset(ody1, dB!='NA')


# Cizimlere basliyoruz 
# Tum veriseti cizdiriliyor
ggplot(data = ody2, aes(x=freq, y=dB, group=participant)) + 
  geom_line(data = ody2, aes(group=participant)) +
  theme_bw()

# Kulaklara ait veriler ayri ayri cizdiriliyor
ggplot(data = ody2, aes(x=freq, y=dB, group=participant)) + 
  geom_line(data = ody2, aes(group=participant), color= 'grey') +
  facet_grid(cols=vars(ear)) +
  theme_bw()

# Y eksenini ters ceviriyoruz ve sinirlandiriyoruz
ggplot(data = ody2, aes(x=freq, y=dB, group=participant)) + 
  geom_line(data = ody2, aes(group=participant)) +
  facet_grid(cols=vars(ear)) +
  scale_y_reverse(limits = c(110,-10), breaks = seq(-10, 110, by=10)) +
  theme_bw()

# X eksenini ayarliyoruz
ggplot(data = ody2, aes(x=freq, y=dB, group=participant)) + 
  geom_line(data = ody2, aes(group=participant)) +
  facet_grid(cols=vars(ear)) +
  scale_x_log10(breaks =unique(ody2$freq), labels = unique(ody2$freqLabels)) +
  scale_y_reverse(limits = c(110,-10), breaks = seq(-10, 110, by=10)) +
  theme_bw()

# -----------------------

# Sag ve sol kulak ortalamalari ile basliklar gorsele ekleniyor
ggplot(data = ody2, aes(x=freq, y=dB, group=participant)) + 
  geom_line(data = ody2, aes(group=participant), color='grey', size=.2) +
  facet_grid(cols=vars(ear)) +
  scale_x_log10(breaks =unique(ody2$freq), labels = unique(ody2$freqLabels)) +
  scale_y_reverse(limits = c(110,-10), breaks = seq(-10, 110, by=10)) +
  theme_bw() +
  stat_summary(data = ody2,
               aes(x=freq, y=dB, group=ear), 
               fun=mean,
               geom="line",lwd = 1.2)+
  theme(axis.text=element_text(size=9),
        axis.title=element_text(size=12),
        strip.text.x = element_text(size = 10))+
  labs(x = "Frequency (kHz)", y = "Threshold (dB HL)")

# Sekli kaydediyoruz

ggsave("audiogram_plot1.png", width=6, height=4, device='png', units='in', dpi=400) 

# http://www.sthda.com/english/wiki/ggplot2-line-plot-quick-start-guide-r-software-and-data-visualization








