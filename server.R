# server function
server <- function(input, output){
    
    output$protein_data <- renderPlotly({
        
        # Connection to database myProtein_db 
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "myProtein_db",
            host = "localhost",
            port = 3306,
            username = "root",
            password = "")
        on.exit(dbDisconnect(conn), add = TRUE)
        
        # Executing the query
        table<-dbGetQuery(conn, paste0(
            "Select protein_ds.sample_name, protein_ds.sample_value,
            protein_ds.Protein, group_ds.group_name, group_ds.dataset_name
            FROM protein_ds INNER JOIN group_ds
            ON group_ds.sample_name = protein_ds.sample_name
            AND group_ds.dataset_name='", input$selectDataset, "'
            AND protein_ds.Protein='", input$selectProtein,"';"))
        
        # converting table to dataframe
        table1<-as.data.frame(table)
        
        # Barplot using plotly
        plot_ly(data=table1,x=~sample_name, y=~sample_value,
                color=~group_name,type="bar")%>%
            layout(
                title = "Protein Barplot",
                xaxis = list(title="Sample Name"),
                yaxis = list(title="Sample Value")
            )
    })
}

