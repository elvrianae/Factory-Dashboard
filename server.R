# A. Libraries 
library(shiny)
library(shinydashboard)
library(dplyr)
library(markdown)
library(plotly)
library(rworldmap)
library(ggplot2)
library(hrbrthemes)
library(viridis)
library(readxl)


# B. Import Data
Complete <- read.csv2("Complete.csv", header = T, sep = ";")

# C. Server
shinyServer(function(input, output) {
    
    tab_list <- NULL
    
    showNotification("Hello, Welcome to My Dashboard!", duration = 15, type = "warning")
    
    
    output$value1 <- renderValueBox({
        TotalAmount <- as.numeric(Complete$TotalAmount)
        avg_total_amount <- round(mean(TotalAmount), 2)
        valueBox(
            avg_total_amount,
            "Average of Total Amount",
            icon = icon("sort-amount-up"),
            color = "aqua"
        )
        
    })
    
    output$value2 <- renderValueBox({
        avg_unit_price <- round(mean(as.numeric(Complete$UnitPrice)), 2)
        valueBox(
            avg_unit_price,
            "Average of Unit Price",
            icon = icon("coins"),
            color = "olive"
        )
    })
    
    output$value3 <- renderValueBox({
        avg_quantity <- round(mean(Complete$Quantity), 2)
        valueBox(
            avg_quantity,
            "Average of Quantity",
            icon = icon("file-signature"),
            color = "yellow"
        )
    })
    
    output$bar_plot <- renderPlotly({
        ggplot(Complete, aes(x=Complete$Country, y=Complete$Quantity) ) +
            geom_bar(stat="identity", fill="#fa8264") +
            ggtitle("Sales in Each Country") +
            coord_flip() +
            theme_ipsum() +
            xlab("Country") +
            ylab("Quantity") +
            theme(
                panel.grid.minor.y = element_blank(),
                panel.grid.major.y = element_blank(),
                legend.position="none")  
    })
    
    output$histogram <- renderPlotly({
        ggplot(Complete, aes(x=Complete$Quantity)) +
            stat_bin(breaks=seq(0,150,6), fill="#62b3f5", color="#62b3f5", alpha=0.9) +
            ggtitle("Density of Quantity Orders by Customers") +
            theme_ipsum() +
            xlab("Quantity") +
            ylab("Density")
    })
    
    output$bar_plot <- renderPlotly({
        ggplot(Complete, aes(x=Complete$Country, y=Complete$Quantity) ) +
            geom_bar(stat="identity", fill="#fa8264") +
            ggtitle("Sales in Each Country") +
            coord_flip() +
            theme_ipsum() +
            xlab("Country") +
            ylab("Quantity") +
            theme(
                panel.grid.minor.y = element_blank(),
                panel.grid.major.y = element_blank(),
                legend.position="none")  
    })
    
    output$violin <- renderPlotly({
        Country <- Complete$Country
        ggplot(Complete, aes(x=Complete$Package, y=Complete$Quantity, fill=Package)) +
            geom_violin(color="#69b3a2", alpha=0.8) +
            ggtitle("Number of Package Orders by Customers") +
            theme(plot.title = element_text(size=12)) +
            xlab('Package') +
            ylab('Quantity')    
    })
    
    output$data_table  <- DT::renderDataTable({DT::datatable(Complete)
    })
    
    output$summary  <- renderPrint({summary(Complete [,c(-1:-4,-7:-10,-14:-15)])
    })
    
    output$map <- renderPlot({
        countries <- as.data.frame(table(Complete$Country))
        colnames(countries) <- c("country", "value")
        matched <- joinCountryData2Map(countries, joinCode = "NAME", nameJoinColumn = "country")
        mapCountryData(matched, nameColumnToPlot = "value", mapTitle = "", 
                       catMethod = "pretty", colourPalette = c("green", "darkgreen"))
    })
    
})
