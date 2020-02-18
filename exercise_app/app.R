# load packages
library(shiny)
library(readr)
library(dplyr)
library(plotly)

# read in weather data hint: weather <- read_csv("weather.csv")


# Define what the user sees
ui <- fluidPage(
  # Application title
  titlePanel(""),
  
  # Sidebar with input for user to control 
  sidebarLayout(
    sidebarPanel(
      sliderInput(label = "",
                  inputId = "",
                  min = , max = , value = c(, ))
    ),
    
    # Show the generated plot
    mainPanel(
      plotlyOutput("")
    )
  )
)

# Define server logic required to sort data and draw plot
server <- function(input, output) {
  
  output$ <- renderPlotly({
    plot_ly(data = , x = ~ , y = ~, color = ~, type = "box") %>%
      layout(boxmode = "group")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)