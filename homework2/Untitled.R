
state.x77

setwd('~/Desktop/MSAN622/spring-2015-msan622/homework2/')
rm(list = setdiff(ls(), lsf.str()))

df <- data.frame(
  state.name,
  state.abb,
  state.x77,
  state.region,
  state.division,
  row.names = NULL
)

names(df) <- c('stateName','stateAbb','population','Income','illiteracy','lifeExp','murder','hsGrad','frost','area','stateRegion','stateDivision')
df['illiteracyPopulation'] <- df['population'] * df['illiteracy']
summary(df)

df['illiteracyCut'] <- cut(df$illiteracy, breaks = c(0,0.625,0.950,1.575,3), right= F)
df['count'] <- 1
df2 <- aggregate( df$count, by = list(stateRegion = df$stateRegion ,illiteracyRange = df$illiteracyCut), sum)




write.csv(
  df, 
  file = "stateX77.csv", 
  row.names = FALSE
)

write.csv(
  df2, 
  file = "stateX77aggregate.csv", 
  row.names = FALSE
)


# hw4
setwd('~/Desktop/MSAN622/spring-2015-msan622/data/')
library(ggplot2)

mov_ <- movies[ is.na(movies$budget) == T,]
nrow(mov_)

movies_ <- movies
names(movies_) <- c(names(movies_)[1:2],"Length",names(movies_)[4:24])

year <- data.frame(year = sort(unique(movies$year),decreasing=T))

write.csv(movies_,'../data/moviesWhole.csv',row.names=F,na="")
write.csv(year,'../data/moviesYear.csv',row.names=F,na="")
write.csv(mov_,'./movieRna.csv',row.names=F)

mv0 <- data.frame(unique(movies$year))
names(mv0) <- "year"
mv1 <- aggregate(movies$Romance, by = list(movies$year),sum)
names(mv1) <- c("year","count")
mv2 <- aggregate(movies$Documentary, by = list(movies$year),sum)
names(mv2) <- c("year","count")
mv3 <- aggregate(movies$Action, by = list(movies$year),sum)
names(mv3) <- c("year","count")
mv4 <- aggregate(movies$Animation, by = list(movies$year),sum)
names(mv4) <- c("year","count")
mv5 <- aggregate(movies$Drama, by = list(movies$year),sum)
names(mv5) <- c("year","count")
mv6 <- aggregate(movies$Comedy, by = list(movies$year),sum)
names(mv6) <- c("year","count")
mv7 <- aggregate(movies$Short, by = list(movies$year),sum)
names(mv7) <- c("year","count")

mv01 <- merge(mv0,mv1,by='year',all.x=T)
names(mv01) <- c('year','romance')
mv012 <- merge(mv01,mv2,by='year',all.x=T)
names(mv012) <- c('year','romance','documentary')
mv0123 <- merge(mv012,mv3,by='year',all.x=T)
names(mv0123) <- c('year','romance','documentary',"action")
mv01234 <- merge(mv0123,mv4,by='year',all.x=T)
names(mv01234) <- c('year','romance','documentary',"action","animation")
mv012345 <- merge(mv01234,mv5,by='year',all.x=T)
names(mv012345) <- c('year','romance','documentary',"action","animation","drama")
mv0123456 <- merge(mv012345,mv6,by='year',all.x=T)
names(mv0123456) <- c('year','romance','documentary',"action","animation","drama","comedy")
mv01234567 <- merge(mv0123456,mv7,by='year',all.x=T)
names(mv01234567) <- c('year','romance','documentary',"action","animation","drama","comedy","short")

head(mv01234567)

mvsum <- mv01234567$romance + mv01234567$documentary + mv01234567$action + mv01234567$animation + mv01234567$drama + mv01234567$comedy +mv01234567$short
mv01234567$sum <- mvsum

write.csv(mv01234567,"./movieGenreYear.csv",row.names=F)
