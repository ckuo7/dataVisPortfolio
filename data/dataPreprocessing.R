library('ggmap')
setwd('~/Desktop/MSAN622/spring-2015-msan622/data/')
rm(list = setdiff(ls(), lsf.str())) # clear the variable

df <- read.csv('./bikeshare2012_11_19.csv')
head(df)

df$hour <- substr(df$newDate,12,13)

#df.a1 <- aggregate( df$count, by = list(hour = df$hour,station = df$Start.Station) , sum)
#head(df.new2.output)
#names(df.new2.ouput) <- c("daypart","date", "station", "output")

df <- read.csv('../../project/2012-Q4-Trips-History-Data.csv')

df$Start.date <- strptime(df$Start.date, format="%m/%d/%Y %H:%M")
df$End.date <- strptime(df$End.date, format="%m/%d/%Y %H:%M")
df$count <- 1
df$yearMonth <- substr(df$Start.date,1,7)

df2012_11 <- df[df$yearMonth == "2012-11",]
df2012_11$day <- substr(df2012_11$Start.date,9,10)


df2012_11$hour <- substr(df2012_11$Start.date,12,13)
# get the unique station
station <- unique(df2012_11$Start.Station)
station <- gsub("&","and",station)
station <- sapply(station, f <- function(x){
  return(paste(x,"Washington, District of Columbia, USA.",sep=', '))
})
# remove one station that causing error
station <- station[c(1:84,86:length(station))]
# get the geo location information
stationlist <- lapply(station, f <- function(x){
  return(geocode(x,output="more"))
})
df.station <- do.call(rbind,stationlist)
#df.station$station <- station[c(1:84,86:length(station))]
# select the area and zipcode
dfm1 <- df.station[ df.station$locality %in% c("washington"),]
dfm2 <- dfm1[ is.na(dfm1$postal_code) == F,]

df2012_11_day <- split(df2012_11, df2012_11$day)

lapply( df2012_11_day, function(df){
  
  day <- df$day[1]
  print(day)
  # aggregate
  df.start <- aggregate( df$count, by = list(hour = df$hour ,station = df$Start.Station), sum)
  names(df.start) <- c("hour", "station", "count")


  df.end <- aggregate( df$count, by = list(hour = df$hour ,station = df$End.Station), sum)
  names(df.end) <- c("hour", "station", "count")
  # merge

  df.new <- merge( df.start, df.end, by = c('hour','station'), all = T)
  names(df.new) <- c("hour", "station", "output", "input")

  # replace na witht zero
  df.new[ is.na(df.new$output) == T,]$output <- 0
  df.new[ is.na(df.new$input) == T,]$input <- 0

  # calculate net
  df.new$net <- df.new$input - df.new$output
  head(df.new)
  nrow(df.new)

  # append missing hour
  df.new.split <- split(df.new, df.new$station)
  df.new.split.lapply <- lapply(df.new.split, f<- function(x){
  misshour <- setdiff(c("00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"), x$hour)
  #firstrow <- df[1,]
  #newrow <- apply(misshour, f <- function(y){
  for ( h in misshour){
    firstrow <- x[1,]
    firstrow$hour <- h
    firstrow$net <- 0
    x <- rbind(x,firstrow)
  }
  #print(t(newrow))
  #x <- rbind(x,newrow)
  return(x)
  })

  #df.new.split.lapply[[1]]
  df.new2 <- do.call(rbind,df.new.split.lapply)

  df.all2 <- merge(df.new2,dfm2,by=c('station'), all=F )

  write.csv(df.all2, paste('./bikeshare/bs_2012_11_',day,'.csv',sep=""), row.names= F,na="")
  return(day)
})


########################## clean

df <- read.csv('./projectData.csv')

#df$day <- substr(df$datetime,9,10)
df$hour <- substr(df$datetime,12,13)
write.csv(df,'./projectData.csv',row.names=F,na="")


df <- read.csv('./bs_2012_11_19_clean.csv')
head(df)
