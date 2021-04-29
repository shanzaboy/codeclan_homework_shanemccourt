library(shiny)
library(tidyverse)
library(CodeClanData)

ui <- fluidPage(
  
  
  radioButtons(
    "gender",
    "Male or Female dogs?",
    choices = c("Male", "Female")
  ),
  
  #DT provides a good overlay and theme""
  DT::dataTableOutput("table_output")
  
)


server <- function(input, output){
  
  output$table_output <- DT::renderDataTable({
    nyc_dogs %>% 
      filter(gender == input$gender) %>% 
      slice(1:10)
    
    
  })
  
}

shinyApp(ui, server)
# 
# 
# Add three drop down selectors to the app above that let you filter the data based on:
#   Dog colour
# Borough
# Dog breed
# Extension: You should try using fluidRow from yesterdays lesson to lay the buttons
# 
# out more neatly. Remember, you’ll need to update your UI and your server.