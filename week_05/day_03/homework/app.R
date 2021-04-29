library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)
all_teams <- unique(olympics_overall_medals$team)
ui <- fluidPage(
    theme = shinytheme("darkly"),
    tags$i(tags$u(titlePanel("Olympic Medals"))),
    
    plotOutput("medal_plot"),
    
    
    
    tabsetPanel(
        tabPanel(
            fluidRow(
            column(6, 
               radioButtons("season",
                            tags$u("Summer or Winter Olympics?"),
                            choices = c("Summer", "Winter")
               )
        ),
        column(6,
               selectInput("team",
                          tags$u("Which Team?"),
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
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team == input$team) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            theme(panel.background = element_rect(fill = "yellow")) +
            geom_col()
    })
}
shinyApp(ui = ui, server = server)