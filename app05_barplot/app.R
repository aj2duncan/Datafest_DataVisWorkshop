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
            sliderInput(label = "Number of Diamonds",
                        inputId = "diamonds",
                        min = 1, max = 10000, value = 500),
            selectizeInput(label = "Choose cut",
                           inputId = "cut", 
                           choices = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                           selected = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                           multiple = TRUE)
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
        types_cut <- input$cut
        
        # sample correct number
        diamonds_to_plot <- sample_n(diamonds, num_diamonds)
        # filter cut
        diamonds_to_plot <- filter(diamonds_to_plot, cut %in% types_cut)
        # count number of diamonds
        counted_diamonds <- count(diamonds_to_plot, cut)
        
        # draw barplots
        plot_ly(data = counted_diamonds, x = ~cut, y = ~n, color = ~cut,
                type = "bar")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
