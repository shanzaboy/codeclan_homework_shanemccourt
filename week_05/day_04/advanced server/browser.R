library(shiny)
library(tidyverse)
library(CodeClanData)
ui <- fluidPage(
  sliderInput("sample_size", "Sample Size", value = 50, min = 1, max = 912),
  plotOutput("histogram")
)
server <- function(input, output) {
  sampled_data <- reactive({
    students_big %>%
      select(height) %>%
      sample_n(input$sample_size) 
    
    
  output$histogram <- renderPlot({
    ggplot(sampled_data) +
      aes(x = height) +
      geom_histogram()
  })
  }
  shinyApp(ui, server)
  # 2:41
  # Task - 10 mins
  # Find and fix the errors in this Shiny app. You’ll need to use the syntax checker in RStudio and browser.