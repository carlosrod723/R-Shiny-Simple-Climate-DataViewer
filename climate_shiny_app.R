# Load the necessary libraries
library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)

# Create the dataset
temp <- tibble(
  location = c("New York", "Los Angeles", "Chicago", "New York", "Los Angeles", "Chicago"),
  latitude = c(40.2, 34.1, 41.9, 40.2, 34.1, 41.9),
  longitude = c(-74.0, -118.0, -87.6, -74.0, -118.0, -87.6),
  year = c(2020, 2020, 2020, 2021, 2021, 2021),
  temperature = c(12.3, 17.5, 10.4, 11.8, 18.0, 9.9)
)

# Define the UI
ui <- fluidPage(
  titlePanel("Simple Climate Data Viewer"),
  
  # Sidebar layout with input and output
  sidebarLayout(
    sidebarPanel(
      h3("Select a location:"),
      
      # Output the interactive map
      leafletOutput("map", height = "300px"),
      
      # Download button for filtered data
      downloadButton("downloadData", "Download Data")
    ),
    
    # Main panel for displaying the plot
    mainPanel(
      h4("Temperature Time Series Plot"),
      plotOutput("climatePlot")
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  
  # Render the map with markers
  output$map <- renderLeaflet({
    leaflet(data = temp) %>%
      addTiles() %>%
      addMarkers(lng = ~longitude, lat = ~latitude, 
                 popup = ~location, layerId = ~location)
  })
  
  # Reactive expression to capture the clicked location
  selected_location <- reactive({
    click <- input$map_marker_click
    if (is.null(click)) {
      return("New York")  # Default to New York if no city is selected
    } else {
      return(click$id)  # Capture the clicked location ID
    }
  })
  
  # Render the plot for the selected location
  output$climatePlot <- renderPlot({
    location <- selected_location()
    
    # Filter the data for the selected location
    filtered_data <- temp %>% 
      filter(location == !!location) %>% 
      arrange(year)
    
    # Generate the time series plot using ggplot2
    ggplot(filtered_data, aes(x = year, y = temperature, group = 1)) +
      geom_line(color = "blue") +
      geom_point(size = 3, color = "black") +
      labs(title = paste("Temperature for", location),
           x = "Year", y = "Temperature (°C)") +
      scale_x_continuous(breaks = unique(filtered_data$year)) +
      theme_minimal() +
      ylim(min(temp$temperature) - 1, max(temp$temperature) + 1)  # Consistent y-axis across cities
  })
  
  # Download handler for filtered data
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(selected_location(), "climate_data.csv", sep = "_")
    },
    content = function(file) {
      location <- selected_location()
      filtered_data <- temp %>% filter(location == !!location)
      write.csv(filtered_data, file, row.names = FALSE)
    }
  )
}

# Run the Shiny app
shinyApp(ui = ui, server = server)