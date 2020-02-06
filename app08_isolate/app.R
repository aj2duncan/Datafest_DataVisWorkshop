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
                        choices = c("Bar Chart", "Scatterplot")),
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
    
    # separate data handling from plotting
    data_to_plot <- reactive({
        # gather info from user but only when asked
        num_diamonds <- isolate(input$diamonds)
        types_cut <- isolate(input$cut)
        
        # listen to go button
        input$go
        
        # sample correct number
        diamonds_to_plot <- sample_n(diamonds, num_diamonds)
        # filter cut
        diamonds_to_plot <- filter(diamonds_to_plot, cut %in% types_cut)
        
        # return data to plot
        return(diamonds_to_plot)    
    })
    
    output$diamondsPlot <- renderPlotly({
        
        # NOTE: At the momemnt type of chart isn't isolated, so if it changes
        # a new chart will be drawn instantly
        
        # draw correct plot
        if (input$plot_type == "Bar Chart") {
            # count each type of cut
            counted_data <- count(data_to_plot(), cut)
            # draw bar chart
            plot_ly(data = counted_data, x = ~cut, y = ~n, color = ~cut,
                    type = "bar")
        } else {
            # draw scatterplot
            plot_ly(data = data_to_plot(), x = ~carat,
                    y = ~price, color = ~cut, type = "scatter", mode = "markers")
            
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
