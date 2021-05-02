# weekend homework

library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)


# read in data
game_sales


# provides a full list of the publishers

pub_dist <- game_sales %>%
  distinct(publisher)


ui <- fluidPage(
  theme = shinytheme("superhero"),
  tags$i(tags$u(titlePanel("Game sales through the years"))),
  hr(),

  # input selection for publisher
  fluidRow(
    selectInput("publisher",
      label = ("Pick a publisher"),
      choices = c(pub_dist)
    )
  ),
  fluidRow(
    # bar is showing the total sales through the years in a stacked way
    column(6, plotOutput("bar")),
    # bar2 is based on the sales for the selected publisher by genre
    column(6, plotOutput("bar2"))
  ),
  hr(),


  # shows the top 10 sales by title for the selected publisher
  fluidRow(
    DT::dataTableOutput("table_output")
  )
)




server <- function(input, output, session) {
  filtered_data <- reactive({
    game_sales %>%
      filter(publisher == input$publisher)
  })

  output$bar <- renderPlot({
    game_sales %>%
      ggplot() +
      aes(x = year_of_release, y = sales, fill = publisher) +
      geom_col() +
      ggtitle("Total Sales")
  })

  output$bar2 <- renderPlot({
    ggplot(filtered_data()) +
      aes(x = year_of_release, y = sales, fill = genre) +
      geom_col() +
      ggtitle(input$publisher, "Sales by genre")
  })

  output$table_output <- DT::renderDataTable({
    game_sales %>%
      filter(publisher == input$publisher) %>%
      arrange(desc(sales)) %>%
      head(5)
  })
}

shinyApp(ui, server)