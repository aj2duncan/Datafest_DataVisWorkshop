# load packages
library(shiny)
library(readr)
library(dplyr)
library(plotly)

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
            sliderInput(inputId = "years", label = "Choose years:",
                        min = min(weather$year),
                        max = max(weather$year),
                        value= c(min(weather$year),max(weather$year)), 
                        sep = "")
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
        years_to_show = input$years
        
        # filter data
        weather_to_plot <- filter(weather, 
                                  between(year, 
                                          left = min(years_to_show),
                                          right = max(years_to_show)))
        
        # plot data
        plot_ly(weather_to_plot, x = ~location, y = ~sun, 
                type = "box")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
