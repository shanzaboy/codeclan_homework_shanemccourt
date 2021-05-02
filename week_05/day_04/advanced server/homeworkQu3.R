library(ggplot2)
library(dplyr)
library(shiny)
library(readr)

students_big <- read_csv("data/students_big.csv")

ui <- fluidPage(
  
  radioButtons("type",
               "Plot Type",
               choices = c("Bar", "Pie Chart", "Stacked Bar")
  ),
  
  plotOutput("plot")
  
)

server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    if (input$type == "Bar"){
      
      plot <- 
        ggplot(students_big) +
        aes(x = gender, fill = gender) +
        geom_bar()
      
    }
    
    if (input$type == "Pie Chart"){
      
      plot <- 
        ggplot(students_big) +
        aes(x = 1, fill = gender) +
        geom_bar() +
        coord_polar("y")
      
    }
    
    if (input$type == "Stacked Bar"){
      
      plot <-
        ggplot(students_big) +
        aes(x = 1, fill = gender) +
        geom_bar() 
      
    }
    
    plot
  })
  
}

shinyApp(ui, server)