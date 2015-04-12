
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