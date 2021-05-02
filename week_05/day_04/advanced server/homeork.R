#height arm app
library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)
students_big <- read_csv("data/students_big.csv")


ui <- fluidPage(
  
  fluidRow(
    radioButtons(
      "age",
      "Age",
      choices = c(10:18),
      inline = TRUE
    )
    
  ),
  
  fluidRow(
    column(6,
           plotOutput("hist1"),
    ),       
    column(6,
           plotOutput("hist2")
      
      )
    
    )
  )

server <- function(input, output, session) {

  filtered_data <- reactive({
    students_big %>%
      filter(ageyears == input$age)  
  })
 
  output$hist1 <- renderPlot({
    ggplot(filtered_data()) +
      geom_histogram(aes(x = height))
  })
  
  output$hist2 <- renderPlot({
    ggplot(filtered_data()) +
      geom_histogram(aes(x = arm_span)) 
  })
    
}

shinyApp(ui, server)