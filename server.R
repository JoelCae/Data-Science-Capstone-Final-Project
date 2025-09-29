
library(shiny)
library(tidytext)
library(tidyverse)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$table_result <- renderTable({
      predict_ngram(input$context, input$ngram,  top_k = 5)
    })

}
