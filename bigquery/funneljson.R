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
# column names are correct

df4 <- data.frame(t(sapply(funnel,c)))

# dataframe (each column is a list)
class(df4)

# list of characters
class(df4$steps)
class(df4$starting_amount)
class(df4$X_sdc_table_version)


# Exploratory (df4) ----

str(df4$starting_amount)
str(df4$X_sdc_table_version)
str(df4$X_sdc_received_at)

# Cannot explore invalid 'type' (list) of argumment
df4 %>% 
    summarize(
        max_starting = max(starting_amount)
    )

# Converting each list within a dataframe to a normal column
# unlist each column, wrap around as.tibble()

starting_amount <- as.tibble(unlist(df4$starting_amount))
X_sdc_table_version <- as.tibble(unlist(df4$X_sdc_table_version))

data.frame(starting_amount, X_sdc_table_version)
    


steps <- as.tibble(unlist(df4$steps))

steps 

starting_amount %>%
    mutate(value = as.numeric(value)) %>%
    summarize(
        min_starting = min(value),
        max_starting = max(value)
    )

class(df4[[1]][[1]]$value)


df4[[1]][[107]]$value %>% view()

# going into each event (funnel) and selecting most important columns
df4[[1]][[107]]$value %>%
    select(step_label, count, avg_time, step_conv_ratio__fl) %>%
    view()


for (i in df4[[1]][[i]]$value){
    print(i)
}

# First column is a list of dataframe
list <- df4[[1]]


list %>% view()

list[2]

list[[1]]$value$session_event

# for loop and assign function to global environment
# write out single data frames
# Might not be necessary, as we want to keep list of datafrmaes
for (i in seq(list)){
    assign(paste0("df", i), list[[i]])
}

list2 <- list

list <- list2


for(i in seq_along(list)){
    for (j in seq_along(colnames(list[[i]]))){
        if(colnames(list[[i]])[j] != "value.step_label"){
            colnames(list[[i]])[j] <- paste(colnames(list[[i]])[j], i, sep = ".")
        }
    }
}

# alternative
for (i in names(list)) {   
    for (j in seq_along(colnames(list[[i]]))) {     
        if (colnames(list[[i]])[j] != "value.step_label") {       
            colnames(datasets[[i]])[j] <- paste(colnames(list[[i]])[j], i, sep = ".")     
        }   
    } 
} 


# then reduce (this didn't work)

new_df <- Reduce(function(x, y) merge(x, y, all = TRUE, by = "value.step_label"), list)


