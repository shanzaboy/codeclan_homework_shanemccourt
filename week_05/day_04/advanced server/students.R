library(tidyverse)
library(shiny)
library(CodeClanData)
ui <- fluidPage(
  fluidRow(
    
    column(4,
           sliderInput("bins", 
                       "Number of Bins",
                       min = 1, max = 100, value = 30)
    ),
    column(4,
           sliderInput("alpha",
                       "Alpha of Points",
                       min = 0, max = 1, value = 0.8)
    ),
    column(4,
           sliderInput("max_height",
                       "Maximum Height to Plot",
                       min = min(students_big$height),
                       max = max(students_big$height), 
                       value = max(students_big$height))
    )
  ),
  fluidRow(
    actionButton("update", "Update!")
  ),
  fluidRow(
    column(6,
           plotOutput("histogram")
    ),
    column(6,
           plotOutput("scatter")
    )
  )
)
server <- function(input, output) {
  students_filtered <- eventReactive(input$update,{
    students_big %>%
      filter(height <= input$max_height)
  })
  output$histogram <- renderPlot({
    ggplot(students_filtered()) +
      aes(x = height) +
      geom_histogram(bins = input$bins)
  })
  output$scatter <- renderPlot({
    ggplot(students_filtered()) +
      aes(x = height, y = arm_span) +
      geom_point(alpha = input$alpha)
  })
}
shinyApp(ui = ui, server = server)


# Task 10 mins
# Update the student height app above with the scatter plot and the 
#histogram, so that the plots only update to a change in max_height when a button is pressed.
# 12:07
# Task - 15 mins (Optional)
# Take our Olympic Medals app from the first lesson and
# Add a table, which lists the counts of Gold, Silver and Bronze medals for the chosen team in the chosen season.
# Use reactive to increase the efficiency of the app you’ve built.
# Add an action button so the plots only update after you’ve clicked the button.