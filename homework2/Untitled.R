
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

write.csv(
  df, 
  file = "stateX77.csv", 
  row.names = FALSE
)