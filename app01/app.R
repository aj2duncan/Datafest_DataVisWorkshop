# load packages
library(shiny)
library(dplyr)
library(plotly)

# Define what the user sees
ui <- fluidPage(

    # Application title
    titlePanel("Diamonds"),

    # Sidebar with input for user to control 
    sidebarLayout(
        sidebarPanel(
            sliderInput(label = "Number of Diamonds",
                        inputId = "diamonds",
                        min = 1, max = 10000, value = 500)
        ),

        # Show the generated plot
        mainPanel(
           plotlyOutput("diamondsPlot")
        )
    )
)

# Define server logic required to sort data and draw plot
server <- function(input, output) {

    output$diamondsPlot <- renderPlotly({
        # gather info from user
        num_diamonds <- input$diamonds
        
        # sample correct number
        diamonds_to_plot <- sample_n(diamonds, num_diamonds)

        # draw scatterplot
        plot_ly(data = diamonds_to_plot, x = ~carat, y =  ~price, 
                color = ~cut,
                type = "scatter", mode = "markers")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
