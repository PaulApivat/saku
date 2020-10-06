# R version 4.0.2 (2020-06-22)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Catalina 10.15.6

sessionInfo()

# libraries
library(jsonlite)
library(tidyverse)
library(reactable)
library(magrittr)

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

data <- data.frame(t(sapply(funnel,c)))
# a data frame (where columns are lists)
class(data)
# this column is a list of dataframes
class(data$steps)
class(data$starting_amount)

# this is a dataframe again
class(data$steps[[321]]$value)

print(data$steps[[321]])


data$steps[[319]]$value %>%
    split(.$step_conv_ratio__fl) %>% view()

# This works, but
# how do I loop through all [[1:321]]
data$steps[[319]] %>%
    map(sample_function)

unlist(data$steps[c(1:321)])

list[c(1:321)]

list %>%
    modify_depth(3, '+', 100L) %>%
    str()

str(list[[319]])

# this worked
# use modify_at function on a target column within a specific dataframe
list[[319]]$value %>%
    modify_at(c(2), as.numeric) %>%
    str()


# a list of dataframes
list <- data$steps
class(list)

# for every dataframe in list
for (df in list){
    # print out content of first column (character)
    print(df$value$step_label)
}

for (df in 1:length(list)){
    print(list[[df]]$value$step_conv_ratio__fl)
}

sample_function <- function(x){
    x %<>%
        select(1:5)
    
    return(x)
}

new_list <- map(data$steps[[321]], sample_function)
unlist_new_list <- unlist(new_list)

View(as.data.frame(unlist_new_list))

# final for loop with map function
for (i in 1:length(list)){
    new_list <- map(list[[i]]$value, sample_function)
}


class(data$steps[[321]]$value)




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


data$

df4[[1]][[107]]$value %>% view()

# going into each event (funnel) and selecting most important columns
df4[[1]][[107]]$value %>%
    select(step_label, count, avg_time, step_conv_ratio__fl) %>%
    view()


for (i in df4[[1]][[i]]$value){
    print(i)
}

# First column is a list of dataframe

# turn dataframe (of just first column) back into a list ----
list <- data[[1]]

data[[1]][[7]]$value$

# loop through list ----
library(purrr)
install.packages("magrittr")
library(magrittr)

# loop function
for (df in 1:length(list)){
    list[[df]]
}

# loop function
loop_function <- function(x){
    x %>%
        select('step_label') -> x
    
    return(x)
}

# Print out individual columns from each dataframe----

for (df in list){
    #grab first column of each dataframe
    print(df$value$funnel_id)
}

for (df in 1:length(list)){
    print(list[[df]]$value$step_conv_ratio__fl)
}


for (df in 1:length(list)){
    step_conv <- list[[df]]$value$step_conv_ratio__fl
}


for (df in list){
    print(df)
}


loop_result_2 <- map(list[[319]], ~loop_function(.))

loop_result_3 <- map(list[[1]]$value, ~loop_function(.))

list[[1]]$value


for (j in data$steps){
    print(j)
}



list %>%
    select("value.step_label")


loop_result_2$value
    
lapply(list, loop_function)



for (i in list[[i]]){
    map(list[[i]]$value, ~loop_function(.))
}
    
data$steps[[2]]


list[[3]]


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


