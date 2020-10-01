# R version 4.0.2 (2020-06-22)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Catalina 10.15.6

sessionInfo()

# libraries
library(jsonlite)
library(tidyverse)
library(reactable)

# read json file ----
# funnel <- fromJSON("bq-mixpanel-funnel.json", flatten = TRUE)

# read multiple nested json ----

# "list" class
class(funnel)

# read data out into Large list (321 elements, 2.4 Mb)
# each row is *another* list
funnel <- lapply(readLines("bq-mixpanel-funnel.json"), fromJSON)

# Approach 1: convert to matrix, array
unlist_funnel <- matrix(unlist(funnel), byrow = TRUE, ncol = length(funnel[[1]]))
rownames(unlist_funnel) <- names(funnel)
as.data.frame(unlist_funnel)


# Approach 2: Convert list to data frame

df <- data.frame(matrix(unlist(funnel), nrow = length(funnel), byrow = TRUE))
df2 <- data.frame(matrix(unlist(funnel), nrow = length(funnel), byrow = FALSE))
df3 <- data.frame(matrix(unlist(funnel), nrow = 321, byrow = TRUE), stringsAsFactors = FALSE)

# Approach 3: plyr package // DID NOT WORK
#library(plyr)
#df4 <- ldply(funnel, data.frame)

# sapply ----
# Approach 4: sapply // BEST ANSWER BY FAR
# makes the MOST sense for nested
# requires another step, but the first 10-columns are CORRECT

df4 <- data.frame(t(sapply(funnel,c)))










