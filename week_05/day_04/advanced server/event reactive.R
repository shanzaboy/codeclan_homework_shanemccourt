library(shiny)
library(tidyverse)
library(CodeClanData)


ui <- fluidPage(
  fluidRow(
    column(3,
           radioButtons('gender',
                        'Male or Female Dogs?',
                        choices = c("Male", "Female"))
    ),
    column(3,
           selectInput("colour",
                       "Which colour?",
                       choices = unique(nyc_dogs$colour))
    ),
    column(3,
           selectInput("borough",
                       "Which Borough?",
                       choices = unique(nyc_dogs$borough))  
    ),
    column(3,
           selectInput("breed",
                       "Which Breed?",
                       choices = unique(nyc_dogs$breed))
           
           
           #can put in Multiple = TRUE to allow multiple selection
    )
  ),
  tableOutput("table_output"),
  #eventreactive button
  actionButton("update", "Update!"),
  
  tableOutput("table_output")
  
)
server <- function(input, output) {
  #places a button when you tell it to update (eventreactive - tie to a UI button above)
  dog_data <- eventReactive(input$update, {
    nyc_dogs %>%
      filter(gender == input$gender)  %>%
      filter(colour == input$colour) %>%
      filter(borough == input$borough) %>%
      filter(breed == input$breed) %>%
      slice(1:10)
  })
  output$table_output <- renderTable({
    dog_data()
  })
}
shinyApp(ui = ui, server = server)
