## DATA
library(shiny)
library(tidytext)
library(tidyverse)

bigrams <- readRDS(file = "bigrams.rds")
trigrams <- readRDS(file = "trigrams.rds")
fourgrams <- readRDS(file = "fourgrams.rds")


predict_ngram <- function(context, ngram = 4, top_k = 5) {
  
  words <- unlist(str_split(context, " "))
  n <- length(words)
  
  if (ngram == 4 & n >= 3) {
    last3 <- words[n-2]; last2 <- words[n-1]; last1 <- words[n]
    candidates <- fourgrams %>%
      filter(str_starts(fourgram, paste(last3, last2, last1))) %>%
      mutate(next_word = word(fourgram, 4),
             prob = n / sum(n)) %>%
      select(next_word, prob) %>%
      arrange(desc(prob))
    
  } else if (ngram == 3 & n >= 2) {
    last2 <- words[n-1]; last1 <- words[n]
    candidates <- trigrams %>%
      filter(str_starts(trigram, paste(last2, last1))) %>%
      mutate(next_word = word(trigram, 3),
             prob = n / sum(n)) %>%
      select(next_word, prob) %>%
      arrange(desc(prob))
    
  } else if (ngram == 2 & n >= 1) {
    last1 <- words[n]
    candidates <- bigrams %>%
      filter(str_starts(bigram, last1)) %>%
      mutate(next_word = word(bigram, 2),
             prob = n / sum(n)) %>%
      select(next_word, prob) %>%
      arrange(desc(prob))
    
  } else if (ngram == 1) {
    candidates <- unigrams %>%
      mutate(next_word = word,
             prob = n / sum(n)) %>%
      select(next_word, prob) %>%
      arrange(desc(prob))
    
  } else {
    stop("The algorithm needs different inputs to determine the best next word. Please try again.")
  }
  
  names(candidates) <- c("Next word", "Probability")
  return(head(candidates, top_k))
}