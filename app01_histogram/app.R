# load packages
library(shiny)

# Define what the user sees
ui <- fluidPage(
  
  titlePanel("Histogram"),
  
  # Sidebar with input for user to control 
  sidebarLayout(
    sidebarPanel(
      sliderInput(label = "Number of Points", inputId = "points",
                  min = 1, max = 10000, value = 500)
    ),
    
    # Show the generated plot
    mainPanel(plotOutput("Plot"))
  )
)

# Define server logic required to sort data and draw plot
server <- function(input, output) {
  # generate plot
  output$Plot <- renderPlot({ 
    # gather info from user
    num_points <- input$points
    
    # create data
    data_to_plot <- data.frame(x = rnorm(num_points))
    
    # create plot
    hist(data_to_plot$x, main = "Histogram") 
  })
}

# Run the application 
shinyApp(ui = ui, server = server)