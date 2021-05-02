# Question2
library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)
students_big <- read_csv("data/students_big.csv")

ui <- fluidPage(
  titlePanel("Reaction Time Vs Memory Game"),
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        radioButtons(
          "colour",
          "Colour of Buttons",
          choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")
        )
      ),
      fluidRow(
        sliderInput("slider1",
          label = h3("Transparency of Points"), min = 0,
          max = 1, value = 0.9
        )
      ),
      fluidRow(
        selectInput("shape",
          label = h3("Shape of Points"),
          choices = c(Square = 15, Circle = 16, Triangle = 17),
          selected = 15
        )
      ),
      fluidRow(
        textInput("text", label = h3("Title of Graph"), value = "Enter text...")
      )
    ),
    mainPanel(plotOutput("scatter"))
  )
)



server <- function(input, output) {
  output$scatter <- renderPlot({
    students_big %>%
      ggplot() +
      aes(x = reaction_time, y = score_in_memory_game) +
      geom_point(
        colour = input$colour,
        alpha = input$slider1,
        shape = as.numeric(input$shape)
      ) +
      ggtitle(input$text)
  },
  
  output$table_output <- DT::renderDataTable({
    nyc_dogs %>% 
      filter(gender == input$gender) %>% 
      slice(1:10))
}

shinyApp(ui, server)