library(shiny)
library(tidyverse)
library(CodeClanData)
ui <- fluidPage(
  fluidRow(
    column(6,
           radioButtons('gender',
                        'Male or Female Dogs?',
                        choices = c("Male", "Female"))
    ),
    column(6,
           selectInput("breed",
                       "Which Breed?",
                       choices = unique(nyc_dogs$breed))
    )
  ),
  fluidRow(
    column(6,
           plotOutput("colour_barchart")
    ),
    column(6,
           plotOutput("borough_barchart")
    )
  )
)

server <- function(input, output) {
  #listener use the reative function - it listens and only reacts when things chnage /
  #once you do this you ned to put () on the new object - 
  filtered_data <- reactive({
    nyc_dogs %>%
    filter(gender == input$gender)  %>%
    filter(breed == input$breed)
  })
  #use the () to put onto the filetered_data due to the reactive
  output$colour_barchart <- renderPlot({
    ggplot(filtered_data()) +
      geom_bar(aes(x = colour))
  })
  #filtered data needs the () again due to the reactive
  output$borough_barchart <- renderPlot({
    ggplot(filtered_data()) +
      geom_bar(aes(x = borough)) 
  })
}
shinyApp(ui = ui, server = server)
