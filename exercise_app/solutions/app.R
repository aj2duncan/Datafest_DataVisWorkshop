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
      numericInput(inputId = "max_rain", 
                   label = "Maximum Monthly Rainfall above:",
                   min = 0, max = 270, value = 150),
      selectizeInput(inputId = "user_location",
                     label = "Choose locations:",
                     choices = c("Cambridge","Eastbourne","Nairn","Tiree"),
                     selected = c("Cambridge","Eastbourne","Nairn","Tiree"),
                     multiple = TRUE),
      actionButton(inputId = "go", label = "Plot Data")
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
    user_year <- isolate(input$year)
    max_rain <- isolate(input$max_rain)
    user_location <- isolate(input$user_location)
    input$go # listen to plot button
    
    # filter data
    weather_to_plot <- filter(weather, year <= user_year, 
                              rain >= max_rain,
                              location %in% user_location)
    # count data
    counted_weather <- count(weather_to_plot, location)
    
    # plot data
    plot_ly(counted_weather, x = ~location, y = ~n, color = ~location, 
            type = "bar")
  })
  
}

shinyApp(ui, server)