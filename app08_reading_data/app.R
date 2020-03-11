# load packages
library(shiny)
library(readr)
library(dplyr)
library(plotly)

# weather data produced by the met office 
# https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data
# 4 datasets were collated into the dataset available here.

weather <- read_csv("weather.csv")

# Define what the user sees
ui <- fluidPage(
    
    # Application title
    titlePanel("Weather"),
    
    # Sidebar with inputs for user to control 
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "year", label = "Choose years:",
                        min = 1990, max = max(weather$year),
                        value = max(weather$year), 
                        sep = ""), # to avoid 1,990 as we would prefer 1990
            numericInput(inputId = "max_temp", 
                         label = "Maximum Monthly Temperature above:",
                         min = 0, max = 30, value = 15)
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
        user_year <- input$year
        max_temp <- input$max_temp
        
        # filter data
        weather_to_plot <- filter(weather, year <= user_year, tmax >= max_temp)
        # count data
        counted_weather <- count(weather_to_plot, location)
        
        # plot data
        plot_ly(counted_weather, x = ~location, y = ~n, color = ~location, 
                type = "bar")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
