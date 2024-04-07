## R Shiny web application for a proteomics data

There are lots of data generated from a proteomics experiment i.e Liquid chromatography–mass spectrometry (LC-MS). The two dataset1.xlsx and dataset2.xlsx are toy datasets stored in the data directory. Sheet RawData depicts the protein expression
in each sample, sheet GroupInfo depicts group information for each sample which will be used for barplot in task 2.

1. Designed a relational database to organize and store the data from excel dataset1.xlsx and dataset2.xlsx.<br>
2. Based on the database created from above, designed an user interface where user can choose any protein (P1, P2, P3 etc) from any dataset to visualize the protein expression in different groups. For demonstration, I've displayed a barplot of
protein expression in the two groups (G1, G2) for protein 1 in dataset1.

In order to run this application, first run the dataloader file to store the datasets from excel sheets to a mysql database. Open and run either global.R or ui.R file to visualize the protein expression from a toy dataset. Here is a screenshot of my application. <br><br><br>
![output](https://github.com/ShipraGupta16/rshiny_demo/assets/25715747/897cae86-c8c2-4716-ba60-7dbd923437c6)
