library(readr)
library(ggplot2)
library(dplyr)
library(shiny)

students_big <- read_csv("data/students_big.csv")

ui <- fluidPage(
  
  selectInput("variable",
              "Which variable to plot?",
              choices = c(
                "importance_reducing_pollution",
                "importance_recycling_rubbish",
                "importance_conserving_water", 
                "importance_saving_enery",
                "importance_owning_computer",
                "importance_internet_access"
              )
  ),
  plotOutput("plot")
)


server <- function(input, output) {
  
  
  output$plot <- renderPlot({
    
    ggplot(students_big) +
      aes_string(x = input$variable, fill = "gender") +
      geom_density(alpha = 0.5)
    
  })
  
}

shinyApp(ui, server)install.pa