# load packages
library(shiny)
library(plotly)

# Define what the user sees
ui <- fluidPage(
  
  titlePanel("Plotly Histogram")
  
  # Sidebar with input for user to control 
  sidebarLayout(
    sidebarPanel(
      sliderInput(label = "Number of Points", inputId = "points",
                  min = 1, max = 10000, value = 500)
    ),
    
    # Show the generated plot
    mainPanel(plotlyOutput("Plot"))
  )
)

# Define server logic required to sort data and draw plot
server <- function(input, output) {
  
  output$Plot <- renderPlotly({ 
    # create data - needs to be a data frame (rectangular)    
    data_to_plot = data.frame(x = rnorm(input$points))
    # plot data
    plot_ly(data_to_plot, x = ~x, type = "histogram")
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)