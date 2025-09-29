
library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Title and information 
  titlePanel("Data Science Capstone: Final project"),
  h1("Algorithm to predict the next word."),
  h4("Author: Joel Castillo"),
  h4("Date: 28/09/2025"), 
  
  # Overview
  fluidRow(
    column(4, h3("Overview"), 
           p("This Shiny app shows an algorithm to predict the next word. 
             This algorithm is based on n-grams and uses the data set from the Coursera website."), 
           p("To predict the next word, the algorithm requires the text as context to predict the word, 
             as well as an n, which is the n-gram to be used in the algorithm. 
             The function calculates the next word for the text and its probability, 
             note that the output contains until five possible predicted words."), 
           p("You can check with any text, or check with this examples:"), 
           tags$ul(
             tags$li("Hey sunshine, can you follow me and make me the"),
             tags$li("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"),
             tags$li("Ohhhhh #PointBreak is on tomorrow. Love that film and haven’t seen it in quite some")
           ), 
           p("Link to",  a("Github Respository of the project.", 
                                            href ="https://github.com/JoelCae/Data-Science-Capstone-Final-Project"),
             "Important: Note that the function of the algorithm is in global.R, and the clean and process of the data is from the
             previous assignment. "), 
      
    ) 
  ),
  
    # Sidebar with ngrams and text input
    sidebarLayout(
        sidebarPanel(
          h3("Inputs:"),
            sliderInput("ngram",
                        "Based on ngrams:",
                        min = 2,
                        max = 4,
                        value = 4), 
            textInput(inputId = "context",
                      label = "Enter some text:",
                      value = "Can you follow me please? It would mean the",
                      placeholder = "Type here...")
        ),

        # Show a plot of the generated distribution
        mainPanel(
          h3("Prediction of the next word"),
          tableOutput("table_result")
        )
    )
)



