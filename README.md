# Simple Climate Data Viewer

The **Simple Climate Data Viewer** made with RStudio is a Shiny web application that visualizes climate data across different cities. The app allows users to interactively select a location from a map, view temperature trends over the years in a time series plot, and download the filtered data for further analysis.

## Features:
- **Interactive Map**: Select a location from a leaflet map with clickable markers.
- **Time Series Plot**: Displays the temperature trends over the years for the selected city.
- **Download Data**: Allows users to download the climate data for the selected city as a CSV file.

## Dataset:

| Location      | Latitude | Longitude | Year | Temperature (°C) |
|---------------|----------|-----------|------|------------------|
| New York      | 40.2     | -74.0     | 2020 | 12.3             |
| New York      | 40.2     | -74.0     | 2021 | 11.8             |
| Los Angeles   | 34.1     | -118.0    | 2020 | 17.5             |
| Los Angeles   | 34.1     | -118.0    | 2021 | 18.0             |
| Chicago       | 41.9     | -87.6     | 2020 | 10.4             |
| Chicago       | 41.9     | -87.6     | 2021 | 9.9              |

The dataset includes temperature data for three cities across two years.

## Key Concepts

### 1. R Shiny Basics:
- **UI and Server Structure**: Shiny apps are built around two main components:
  - **UI (User Interface)**: Defines the layout and input/output elements of the app.
  - **Server**: Defines the logic that powers the app’s interactivity and responds to user inputs. 

Understanding how to structure these two components and how they work together is essential for building a responsive Shiny app.

### 2. Using Reactive Functions:
- **Reactive Programming**: This is at the heart of Shiny. The `reactive()` function captures inputs from the UI (such as map clicks) and dynamically updates outputs (e.g., plots).
  - In this app, **`input$map_marker_click`** was used to detect clicks on the map and dynamically update the temperature plot based on the selected city.

### 3. Interactive Data Visualization with Leaflet and ggplot2:
- **Leaflet**: Used to create interactive maps with clickable markers for different cities.
- **ggplot2**: Utilized to create a time series plot that responds to user interactions. Proper aesthetics like line plots and axis formatting were implemented to ensure clarity.

### 4. Data Filtering and Plotting Based on User Input:
- **Reactive Data Filtering**: Shiny allows for filtering data based on user input. In this case, the app filters the temperature data by city and year based on the user's map selection.
- **Sorting Data**: It is important to arrange data by key variables (e.g., year) to avoid plotting errors like vertical lines between data points.

### 5. Handling CSV Files and Downloads:
- **Download Handlers**: Shiny provides `downloadHandler()` to allow users to download filtered data based on their selections in the app.
- **Data Input/Output**: The app manages data loading, filtering, and export. Users can interactively filter data and download the results as a CSV file. I have included the New_York_climate_data.csv file in the repository for reference.


## How to Run:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   ```
2. **Run the app**: 
   Click the **"Run App"** button in RStudio to launch the Shiny app in your browser.

## Dependencies:

- **Shiny**: For building the web application.
- **Leaflet**: For the interactive map.
- **ggplot2**: For the time series plot.
- **dplyr**: For data manipulation.

To install the required packages, run the following command in your R console:

```r
install.packages(c("shiny", "leaflet", "ggplot2", "dplyr"))
```


