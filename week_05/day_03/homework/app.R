library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)

all_teams <- unique(olympics_overall_medals$team)
ui <- fluidPage(
    
    tags$i(tags$u(titlePanel("Olympic Medals"))),
    
    plotOutput("medal_plot"),
    
    DT::dataTableOutput("table_output"),
    
    
    
    tabsetPanel(
        tabPanel(
            fluidRow(
              column(6, 
               radioButtons("season",
                            "Summer or Winter Olympics?",
                            choices = c("Summer", "Winter")
               )
        ),
              column(6,
                selectInput("team",
                          "Which Team?",
                           choices = all_teams
               )   
        )
        
    ),
    tabPanel("Olympics Website",
             fluidRow(
                 column(12,tags$i(tags$a("The Olympics website", 
                                         href = "https://www.olympic.org"
                                         )
                                 )
                )
    
             )
    )
    ))
)
server <- function(input, output) {
  
  filtered_data <- reactive({
    olympics_overall_medals %>%
      filter(team == input$team) %>%
      filter(season == input$season)
  })
    output$medal_plot <- renderPlot({
        
            ggplot(filtered_data()) +
            aes(x = medal, y = count, fill = medal) +
            geom_col()})
      
      output$table_output <-  DT::renderDataTable({
        olympics_overall_medals %>% 
          filter(team == input$team) %>% 
          slice(1:10)
         
    })
}
shinyApp(ui = ui, server = server)

# Task - 15 mins (Optional)
# Take our Olympic Medals app from the first lesson and
# Add a table, which lists the counts of Gold, Silver and Bronze medals for the chosen team in the chosen season.
# Use reactive to increase the efficiency of the app you’ve built.
# Add an action button so the plots only update after you’ve clicked the button.