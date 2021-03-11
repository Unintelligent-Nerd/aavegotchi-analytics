# Create a Shiny App to show gas spent on transactions on the bonding curve smart contract
library(shiny)
library(shinycssloaders)
library(lubridate)
library(plotly)

# Read the data into R
df <- read.csv("./data/export-0xe5ecfb44bccd7a585fa7f4a8e02c450e525af2e4.csv")

# Convert UNIX time to datetime
df$date <- as_datetime(df$UnixTimestamp)

# Extract out the two relevant columns and remove row names from the data frame
df <- df[, c("date", "TxnFee.ETH.", "TxnFee.USD.")]
rownames(df) <- NULL

# Rename columns
names(df) <- c("date", "ETH", "USD")

ui <- fluidPage(

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),

   
   # Application title
   titlePanel("Aavegotchi Bonding Curve"),
   
   # Sidebar with selectInput to choose currency denomination
   sidebarLayout(
     
     
      sidebarPanel(
        
        fluidRow(
          
          tags$div(
            
            tags$h1("Gas consumption of our lil Ghstie frens"),
            
            tags$br(),
            
            tags$img(src = "aavegotchi.png", width = "25%"))
          ),
        
        fluidRow(
          
          selectInput("currency","Currency", choices = c("ETH", "USD")))
        
        ),
      
      # Display plot of Gas Fees History
      mainPanel(
         plotlyOutput("lineplot") %>%
           withSpinner()
      )
   )
)

# Define server logic required to plot
server <- function(input, output) {
  
  output$lineplot <- renderPlotly({
    
    plot <- plot_ly(df, x = ~date, y = ~get(input$currency), type = "scatter", mode = "lines")
    
    # Depending on the selectInput value, the title and y-axis will change to ETH or USD
    if (input$currency == "ETH") {
      
      plot %>%
        layout(title = "Transaction Fees (in ETH) of Bonding Curve Contract",
               yaxis = list(title = "Transaction Fees (ETH)"))
    } else {
      
      plot %>%
        layout(title = "Transaction Fees (in USD) of Bonding Curve Contract",
               yaxis = list(title = "Transaction Fees (USD)"))
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

