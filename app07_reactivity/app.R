# load packages
library(shiny)
library(dplyr)
library(plotly)

# Define what the user sees
ui <- fluidPage(
    
    # Application title
    titlePanel("Diamonds"),
    
    # Sidebar with inputs for user to control 
    sidebarLayout(
        sidebarPanel(
            selectInput(label = "Type of plot", inputId = "plot_type",
                        choices = c("Barplot", "Scatterplot")),
            sliderInput(label = "Number of Diamonds",
                        inputId = "diamonds",
                        min = 1, max = 10000, value = 500),
            selectizeInput(label = "Choose cut",
                           inputId = "cut", 
                           choices = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                           selected = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                           multiple = TRUE),
            actionButton(inputId = "go", label = "Plot Data")
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
        
        # gather info from user but only when asked
        num_diamonds <- isolate(input$diamonds)
        types_cut <- isolate(input$cut)
        
        # listen to go button
        input$go
        
        # sample correct number
        diamonds_to_plot <- sample_n(diamonds, num_diamonds)
        # filter cut
        diamonds_to_plot <- filter(diamonds_to_plot, cut %in% types_cut)
        
        # NOTE: At the momemnt type of chart isn't isolated, so if it changes
        # a new chart will be drawn instantly
        
        # draw correct plot
        if (input$plot_type == "Barplot") {
            # count number of diamonds
            counted_diamonds <- count(diamonds_to_plot, cut)
            
            # draw boxplots
            plot_ly(data = counted_diamonds, x = ~cut, y = ~n, color = ~cut,
                    type = "bar")
        } else {
            # draw scatterplot
            plot_ly(data = diamonds_to_plot, x = ~carat,
                    y = ~price, color = ~cut, type = "scatter", mode = "markers")
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
