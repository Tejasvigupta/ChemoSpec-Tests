plotSpectra3<-function(spectra,
                       which=1,
                       main = "none",
                       yrange = range(spectra$data),
                       amplify = 1.0,
                       lab.pos=mean(spectra$freq),
                       showGrid = TRUE , ...) {
  chkSpectra(spectra)
  
   #condition to check whether the length of the "which" argument is 1 or not 
  if(length(which)!=1)
  {
    stop("Arguement 'which' length must be equal to 1")
  }
  
  #Extracting the data from spectra object and amplifying it
  spectrum<-spectra$data[which,]*amplify
  
  #Extracting the frequency
  frequency<-spectra$freq
  
  #Creating a New dataframe with extracted data for creating a ggplot
  df<-data.frame(spectrum,frequency)
  lab.x<-lab.pos
  lab.y<-spectrum[findInterval(lab.x,sort(spectra$freq))]
  
  #Creating and storing the ggplot 
  p<-ggplot(df)+
  labs(x=spectra$unit[1],y=spectra$unit[2])+
    theme(plot.title=element_text(size=12,color="red" ,hjust=0.5))+
  theme_bw()+
  theme(legend.position = "none")+
  geom_text(aes(x=lab.x,y=lab.y+0.1,label=spectra$names[which]))+
  ylim(yrange)+
    theme(panel.border = element_blank(),axis.line = element_line(colour = "black"))
    
  #Checking the optional conditions in the function
  if(!showGrid) 
  {
    p = p + theme(panel.grid.minor = element_blank(),panel.grid.major = element_blank())
  }
  if(main!="none")
  {
    p = p + ggtitle(main) + theme(plot.title = element_text(hjust = 0.5,size=20))
  }
  p=p+geom_line(aes(x=frequency,y=spectrum),color=spectra$colors[which])
  p
}


#demo
library(ChemoSpec)
library(ggplot2)
data(SrE.IR)
plotSpectra3(SrE.IR,10,
amplify=10,
showGrid=TRUE,
yrange=c(0,3),
lab.pos = 2000)
