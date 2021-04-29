library(shiny)
library(tidyverse)



ui <- fluidPage(
  
  radioButtons(
    "text_select",
    "what text do you ant to see?",
    choices = c("Cat", "Dog")
  ),
  
  textOutput("text_output")
)
server <- function(input, output){
  output$text_output <- renderText({
    
    if(input$text_select == "Cat"){
      return("Cats are the best!")
    } else {
        return("Dogs are the best!")
      }
  })
  
  
}

shinyApp(ui, server)