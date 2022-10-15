require(tidyverse)
require(ggplot2)
require(plotly)

IMdekom<- read.csv("IM-dekom.csv")

IMdekom<- IMdekom %>% gather(4:11, key="Uzrok", value="Doprinos")
IMdekom$Starost <- factor(IMdekom$Starost,levels = unique(IMdekom$Starost))

IMdekom$Ukupno <- round(IMdekom$Ukupno,3)
IMdekom$Doprinos <- round(IMdekom$Doprinos,3)
IMdekom$Uzrok <- factor(IMdekom$Uzrok, levels=c("Kardiovaskularni","Tumori", "Respiratorni","Eksterni","Digestivni","Endokrini","Nedefinisani","Ostali"))

IMplotgg<- ggplot(IMdekom, aes(fill = Uzrok, y = Doprinos, x = Starost)) +
  geom_bar(position = "stack", stat = "identity") +
  geom_line(aes(x=Starost,y=Ukupno, group=1),col="#4daf4a",size=0.5, linetype=1) +
  #coord_flip() +
  facet_wrap(~ Pol, nrow = 2, ncol = 1) + theme_minimal() + theme(legend.position = "bottom") +
  xlab(NULL) + ylab(NULL) + scale_fill_manual(values = c("#de2d26", "#636363" ,"#386CB0", "#FDC086","#BF5B17", "#80B1D3", "#FCCDE5", "#8DD3C7" ))+
  scale_y_continuous(breaks = (seq(-0.3, 1, 0.3)))

IMplotly<- ggplotly(IMplotgg)


IMplotly$x$data[[31]]$text <- IMplotly$x$data[[31]]$text %>%  gsub(pattern = "<br />Ukupno", replacement = " je doprinela porastu OTŽ za ") %>%  gsub(pattern = "<br />Uzrok: Ostali", replacement = "")
IMplotly$x$data[[32]]$text <- IMplotly$x$data[[32]]$text %>%  gsub(pattern = "<br />Ukupno", replacement = " je doprinela porastu OTŽ za ") %>%  gsub(pattern = "<br />Uzrok: Ostali", replacement = "")
IMplotly<- IMplotly %>% 
add_trace(x=0, y=0, marker = list(symbol="circle",color= '#4daf4a', width=1.5, opacity= 0),showlegend=T, name="Ukupan doprinos") %>% layout(separators=".,")

IMplotly
