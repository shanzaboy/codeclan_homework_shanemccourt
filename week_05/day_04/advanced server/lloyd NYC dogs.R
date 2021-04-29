library(shiny)
library(tidyverse)
library(CodeClanData)


ui <- fluidPage(
  
  radioButtons(
    "gender",
    "Male or Female dogs?",
    choices = c("Male", "Female")
  ),
  
  fluidRow(
    column(4, 
           selectInput("select_colour",
                       "Filter data based on:",
                       choices = unique(nyc_dogs$colour)
                       # NOTE use unique rather than distinct here
           ) 
    ),
    
    column(4, 
           selectInput(
             "select_borough",
             "Filter data based on:",
             choices = unique(nyc_dogs$borough)
           )
    ),
    
    column(4, 
           selectInput(
             "select_breed",
             "Filter data based on:",
             choices = unique(nyc_dogs$breed)
           )
    ),
  ),
  
  DT::dataTableOutput("table_output")
  
  
)
server <- function(input, output){
  output$table_output <- DT::renderDataTable({
    nyc_dogs %>% 
      filter(gender == input$gender) %>% 
      filter(colour == input$select_colour) %>% 
      filter(borough == input$select_borough) %>% 
      filter(breed == input$select_breed)
  })
}
shinyApp(ui, server)

