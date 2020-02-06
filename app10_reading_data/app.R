# load packages
library(shiny)
library(readr)
library(dplyr)
library(leaflet)

# weather data produced by the met office 
# https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data
# 4 datasets were collated into the dataset available here.

weather = read_csv("weather.csv")

# Define what the user sees
ui <- fluidPage(
    
    # Application title
    titlePanel("Weather"),
    
    # Sidebar with inputs for user to control 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "location", label = "Choose Location",
                        choices = c("Cambridge", "Eastbourne", "Nairn", "Tiree"))
        ), 
        
        # Show the generated plot
        mainPanel(
            plotlyOutput("plot")
        ))
)

# Define server logic required to sort data and draw plot
server <- function(input, output) {
    
    output$plot <- renderPlotly({
        # collect data from user
        user_choice = input$location
        
        # filter data
        weather_to_plot <- filter(weather, location == user_choice)
        
        # plot data
        plot_ly(weather_to_plot, x = ~date, y = ~rain, 
                type = "scatter", mode = "markers+lines")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
