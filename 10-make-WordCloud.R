
# libraries ---------------------------------------------------------------

library(wordcloud)
library(tidyverse)

# make word cloud ---------------------------------------------------------

if( !exists("corpus")) {
  source("02-build-corpus.R")
}

corpus_txt = iconv(corpus$content$content, to = "utf-8", sub="")
wordcloud(corpus_txt, scale=c(4,0.5), max.words=150, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))
