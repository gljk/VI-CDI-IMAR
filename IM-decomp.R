require(tidyverse)
require(ggplot2)
require(plotly)

IMdekom<- read.csv("IM-dekom.csv")

IMdekom<- IMdekom %>% gather(4:11, key="Uzrok", value="Doprinos")
IMdekom$Starost <- factor(IMdekom$Starost,levels = unique(IMdekom$Starost))
IMdekom$Ukupno <- round(IMdekom$Ukupno,3)
IMdekom$Doprinos <- round(IMdekom$Doprinos,3)

IMplotgg<- ggplot(IMdekom, aes(fill = Uzrok, y = Doprinos, x = Starost)) +
  geom_bar(position = "stack", stat = "identity") +
  geom_line(aes(x=Starost,y=Ukupno, group=1), col="#4daf4a",size=0.5, linetype=1,show.legend = T) +
  coord_flip() +
  facet_wrap(~ Pol, nrow = 1, ncol = 2) + theme_minimal() + theme(legend.position = "bottom") +
  xlab(NULL) + ylab(NULL) + scale_fill_manual(values = c("#BF5B17", "#8DD3C7","#386CB0","#de2d26", "#FDC086", "#FCCDE5", "#80B1D3", "#636363" ))

IMplotly<- ggplotly(IMplotgg)


IMplotly$x$data[[31]]$text <- IMplotly$x$data[[31]]$text %>%  gsub(pattern = "<br />Ukupno", replacement = " je doprinela porastu OTŽ za ") %>%  gsub(pattern = "<br />Uzrok: Tumori", replacement = "")
IMplotly$x$data[[32]]$text <- IMplotly$x$data[[32]]$text %>%  gsub(pattern = "<br />Ukupno", replacement = " je doprinela porastu OTŽ za ") %>%  gsub(pattern = "<br />Uzrok: Tumori", replacement = "")
IMplotly
