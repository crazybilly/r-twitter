# libraries ---------------------------------------------------------------

library(tidyverse)
library(magrittr)
library(tm)
library(syuzhet)



# process text ------------------------------------------------------------

dtm  <- DocumentTermMatrix(corpus)

nrcsentiment  <- get_nrc_sentiment(some_tweets$text)
nrcsentiment$doc_id  <- some_tweets$doc_id
nrcsentiment %<>%
  select(doc_id, everything()) %>% 
  as.tibble()


nrclong  <- nrcsentiment %>%
  select(-positive,-negative) %>% 
  gather(emotion, n, -doc_id) 
  


# plot emotions -----------------------------------------------------------

emotioncount  <- nrclong %>% 
  group_by(emotion) %>% 
  summarize(
    n = sum(`n`)
  ) %>% 
  arrange(-n) %>% 
  ggplot(aes(x = factor(reorder(emotion, n)), y = n, fill = factor(emotion)) ) + 
    geom_col() + 
    coord_flip() + 
    labs(x = 'Emotion', y = '# of words', title = 'Total Count of Emotional Words')


positive_vs_negative  <- nrcsentiment %>% 
  ggplot(aes(x = doc_id)) + 
     geom_jitter(aes(y = negative), color = 'brown') + 
     geom_jitter(aes(y = positive), color = 'green') 


sentimentbytweet  <- nrcsentiment %>% 
  mutate( sentiment = positive- negative) %$% 
  hist(sentiment)
