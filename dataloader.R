# install required packages
require(xlsx)

# Read the Dataset 1, sheet = 1
df1 = read.xlsx("data/Dataset1.xlsx",
                sheetName = "RawData", header = TRUE)
df1

# replace NA with 0
df1[is.na(df1)] <- 0
df1

# Read the Dataset 1, sheet = 2
df2 = read.xlsx("data/Dataset1.xlsx",
                sheetName = "GroupInfo", header = TRUE)
df2

# add a new column data set1 to groupinfo
df2 ['dataset_name'] = 'dataset1'
df2

# Read the Dataset 2, sheet = 1
df3 = read.xlsx("data/Dataset2.xlsx",
                sheetName = "RawData", header = TRUE)
df3

# replace NA with 0
df3[is.na(df3)] <- 0
df3

# drop the last two empty rows
df3 <- df3[-c(7:8),]
df3

# read the Dataset 2, sheet = 2
df4 = read.xlsx("data/Dataset2.xlsx",
                sheetName = "GroupInfo", header = TRUE)
df4

# add a new column data set2 to groupinfo
df4 ['dataset_name'] = 'dataset2'
df4

# reshaping the raw data from the given two data sets to store into DB
library(reshape2)
df1 <- melt(df1, variable.name ="sample_name", value.name= "sample_value")
df1

df3 <- melt(df3, variable.name ="sample_name", value.name= "sample_value")
df3

# row binding the two raw data sets into one data frame protein_df 
protein_df <- rbind(df1, df3)
protein_df

# row binding the two groupinfo data sets into one data frame group_df 
group_df <- rbind(df2, df4)
colnames(group_df) = c("sample_name", "group_name", "dataset_name")
group_df

##################################################
##### MySQL Database Connectivity with R      ####
##################################################

# install.packages("RMySQL")
library(RMySQL)

options(mysql = list(
    "host" = "127.0.0.1",
    "port" = 3306,
    "user" = "root",
    "password" = ""
))
databaseName <- "myProtein_db"

# two tables of DB
table1 <- "protein_ds"
table2 <- "group_ds"

saveData <- function(data) {
    # Connect to the database
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    db

    dbSendQuery(db, "SET GLOBAL local_infile = true;")

    # loading data into protein_ds table
    dbWriteTable(conn = db, name = "protein_ds", value = protein_df,
                 field.types = c(id ="int(11)", Protein ="varchar(45)",
                                    sample_name = "varchar(45))", 
                                    sample_value = "deimal(12,8)"), append = TRUE,
                                    overwrite = FALSE, row.names = FALSE)
    # loading data into group_ds table
    dbWriteTable(conn = db, name = "group_ds", value = group_df,
                 field.types = c(id ="int(11)",
                                 sample_name = "varchar(45))", 
                                 group_name = "deimal(12,8)", 
                                 dataset_name = varchar(45)), append = TRUE,
                                 overwrite = FALSE, row.names = FALSE)
    
   
    # Submit the update query and disconnect
    # dbGetQuery(db, query)
    query1 <- sprintf("SELECT * FROM %s", table1)
    query2 <- sprintf("SELECT * FROM %s", table2)
    
    # Submit the fetch query and disconnect
    data1 <- dbGetQuery(db, query1)
    data2 <- dbGetQuery(db, query2)
    
    dbDisconnect(db)
    data1
    data2
}
