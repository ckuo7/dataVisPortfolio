
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

############# chart3 #############

names(movies_)

movies1 <- movies_[is.na(movies_$budget) == F,]
nrow(movies_)
nrow(movies1)

mv3_1 <- aggregate(movies1$budget, by = list(movies1$year),mean)

mv3_2 <- movies1[ movies1$Action == 1,]
mv3_2_ <- aggregate(mv3_2$budget, by = list(mv3_2$year),mean)
nrow(mv3_2_)

mv3_3 <- movies1[ movies1$Animation == 1,]
mv3_3_ <- aggregate(mv3_3$budget, by = list(mv3_3$year),mean)
nrow(mv3_3_)

mv3_4 <- movies1[ movies1$Drama == 1,]
mv3_4_ <- aggregate(mv3_4$budget, by = list(mv3_4$year),mean)
nrow(mv3_4_)

mv3_5 <- movies1[ movies1$Documentary == 1,]
mv3_5_ <- aggregate(mv3_5$budget, by = list(mv3_5$year),mean)
nrow(mv3_5_)

mv3_6 <- movies1[ movies1$Comedy == 1,]
mv3_6_ <- aggregate(mv3_6$budget, by = list(mv3_6$year),mean)
nrow(mv3_6_)

mv3_7 <- movies1[ movies1$Romance == 1,]
mv3_7_ <- aggregate(mv3_7$budget, by = list(mv3_7$year),mean)
nrow(mv3_7_)

mv3_8 <- movies1[ movies1$Short == 1,]
mv3_8_ <- aggregate(mv3_8$budget, by = list(mv3_8$year),mean)
nrow(mv3_8_)

mv3_12 <- merge(mv3_1,mv3_2_,by='Group.1',all.x=T)
names(mv3_12) <- c('Group.1','total','action')

mv3_123 <- merge(mv3_12,mv3_3_,by='Group.1',all.x=T)
names(mv3_123) <- c('Group.1','total','action','animation')

mv3_1234 <- merge(mv3_123,mv3_4_,by='Group.1',all.x=T)
names(mv3_1234) <- c('Group.1','total','action','animation','drama')

mv3_12345 <- merge(mv3_1234,mv3_5_,by='Group.1',all.x=T)
names(mv3_12345) <- c('Group.1','total','action','animation','drama','documentary')

mv3_123456 <- merge(mv3_12345,mv3_6_,by='Group.1',all.x=T)
names(mv3_123456) <- c('Group.1','total','action','animation','drama','documentary','comedy')

mv3_1234567 <- merge(mv3_123456,mv3_7_,by='Group.1',all.x=T)
names(mv3_1234567) <- c('Group.1','total','action','animation','drama','documentary','comedy','short')

mv3_12345678 <- merge(mv3_1234567,mv3_8_,by='Group.1',all.x=T)
names(mv3_12345678) <- c('year','total','action','animation','drama','documentary','comedy','short','romance')



head(mv3_12345678)
summary(mv3_12345678)

mv3_12345678[ is.na(mv3_12345678$action)==T, ]$action <- 0
mv3_12345678[ is.na(mv3_12345678$animation)==T, ]$animation <- 0
mv3_12345678[ is.na(mv3_12345678$comedy)==T, ]$comedy <- 0
mv3_12345678[ is.na(mv3_12345678$documentary)==T, ]$documentary <- 0
mv3_12345678[ is.na(mv3_12345678$drama)==T, ]$drama <- 0
mv3_12345678[ is.na(mv3_12345678$romance)==T, ]$romance <- 0
mv3_12345678[ is.na(mv3_12345678$short)==T, ]$short <- 0

write.csv(mv3_12345678,'./moviesBudget.csv', row.names=F, na="")


names(movies_)
movies2 <- movies_[c(1:5,17:24)]
names(movies2)
write.csv(movies2,'../data/moviesWhole.csv',row.names=F,na="")
