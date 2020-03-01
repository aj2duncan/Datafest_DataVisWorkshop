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
      selectizeInput(inputId = "location", label = "Choose location:",
                     choices = c("Cambridge", "Eastbourne", "Nairn", "Tiree"),
                     selected = c("Cambridge", "Eastbourne", "Nairn", "Tiree"),
                     multiple = TRUE),
      sliderInput(inputId = "years", label = "Choose years:",
                  min = min(weather$year), max = max(weather$year),
                  value= c(min(weather$year), max(weather$year)), 
                  sep = ""), # to avoid 1,990 as we would prefer 1990
      actionButton(inputId = "go", label = "Plot Data")
    ), 
    
    
    # Show the generated plot
    mainPanel(
      tabsetPanel(
        tabPanel("Boxplots", plotlyOutput("plot1")),
        tabPanel("Scatterplot", plotlyOutput("plot2"))
      )
    ))
)

# Define server logic required to sort data and draw plot
server <- function(input, output) {
  
  output$plot1 <- renderPlotly({
    # collect data from user
    slider_years <- isolate(input$years)
    user_location <- isolate(input$location)
    input$go
    
    # filter data
    weather_to_plot <- filter(weather, between(year, left = min(slider_years),
                                               right = max(slider_years)),
                              location %in% user_location)
    
    # plot data
    plot_ly(weather_to_plot, x = ~location, y = ~rain, type = "box")
  })
  
  output$plot2 <- renderPlotly({
    # collect data from user
    slider_years <- isolate(input$years)
    user_location <- isolate(input$location)
    input$go
    
    # filter data
    weather_to_plot <- filter(weather, between(year, left = min(slider_years),
                                               right = max(slider_years)),
                              location %in% user_location)
    
    # plot data
    plot_ly(weather_to_plot, x = ~date, y = ~rain, color = ~location,  
            type = "scatter", mode = "markers+lines")
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
