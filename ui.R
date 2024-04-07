# load libraries
library(DT)
library(shiny)
library(DBI)
library(plotly)

# the user interface
ui <- fluidPage(
    
    titlePanel(strong ("Welcome to Protein Database")),
    sidebarPanel(
        
        # Make a select box
        selectInput("selectProtein", label = h5("Select the Protein name here"),
                    choices = list("P1", "P2", "P3", "P4", "P5", 
                                   "P6", "P7", "P8"),
                    selected = "P1"),
        selectInput("selectDataset", label = h5("Select the Dataset here"),
                    choices = list("Dataset1", "Dataset2"),
                    selected = "Dataset1"),
        submitButton("Submit"),
    ),
    mainPanel(
        textOutput("sample_name"),
        plotlyOutput("protein_data")
    ))