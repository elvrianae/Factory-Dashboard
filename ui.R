# Written by : Elvriana Elvani
# Department of Business statistics, Matana University
# Notes: Please don't share this code anywhere (just for my lecturer and my friends)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

# C. User Interface
shinyUI(
  dashboardPage(title = "Factory-Dashboard",
                    skin = "black",
                    dashboardHeader(title = "Factory-Dashboard",
                                    dropdownMenu(type = "messages"),
                                    dropdownMenu(type = "notifications"),
                                    tags$li(class="dropdown", 
                                            tags$img(src='Matana.png', height = 40, width = 40, 
                                                     type = "image/png", style = "margin-top: 5px; margin-right: 5px;"))),
                    
                    dashboardSidebar(
                      sidebarMenu(
                        sidebarSearchForm("searchText",
                                          "buttonSearch",
                                          "Search"),
                        menuItem("Dashboard",
                                 tabName = "dashboard",
                                 icon = icon("home")),
                        menuItem("Table",
                                 tabName = "table",
                                 icon = icon("table")),
                        menuItem("Summary",
                                 tabName = "summary",
                                 icon = icon("list")),
                        menuItem("Location of Customers",
                                 tabName = "map",
                                 icon = icon("search-location"),
                                 badgeColor = "green"),
                        menuItem("Source Code",
                                 icon = icon("download"),
                                 href = "https://github.com/elvrianae/Factory-Dashboard"),
                        menuItem("About Me",
                                 icon = icon("info-circle"),
                                 menuSubItem("Linked in",
                                             icon = icon("linkedin"),
                                             href = "https://www.linkedin.com/in/elvriana-elvani-0481511a3/"),
                                 menuSubItem("Instagram",
                                             icon = icon("instagram"),
                                             href = "https://www.instagram.com/elvriana_e/"),
                                 menuSubItem("Facebook",
                                             icon = icon("facebook-square"),
                                             href = "https://www.facebook.com/vanibrnapit/"))
                      )
                    ),
                    
                    dashboardBody(
                      tabItems(
                        tabItem(
                          tabName = "dashboard",
                          fixedRow(
                            valueBoxOutput("value1", width = 4),
                            valueBoxOutput("value2", width = 4),
                            valueBoxOutput("value3", width = 4)
                          ),
                          fluidRow(
                            infoBox("Top Sales (Country)",
                                    628,"USA",
                                    width = 3,
                                    icon = icon("globe-americas"),
                                    color = "navy"),
                            infoBox("Top Sales (City)",
                                    205, "London",
                                    width = 3,
                                    icon = icon("city"),
                                    color = "maroon"),
                            infoBox("Top Product",
                                    108, "Raclette Courdavault",
                                    width = 3,
                                    icon = icon("heart"),
                                    color = "navy"),
                            infoBox("Top Quantity",
                                    130,
                                    width = 3,
                                    icon = icon("thumbs-up"),
                                    color = "maroon")
                          ),
                          fluidRow(
                            box(title = "Bar Plot",
                                status = "warning",
                                solidHeader = T,
                                collapsible = T,
                                plotlyOutput("bar_plot")),
                            box(title = "Histogram",
                                status = "info",
                                solidHeader = T,
                                collapsible = T,
                                plotlyOutput("histogram"))
                          ),
                          fluidRow(
                            box(title = "Violin",
                                width = 12,
                                status = "success",
                                solidHeader = F,
                                collapsible = T,
                                plotlyOutput("violin")))
                        ),
                        
                        tabItem(tabName = "table",
                                fluidRow(
                                  DT::dataTableOutput("data_table"))
                        ),
                        tabItem(tabName = "summary",
                                fluidRow(
                                  verbatimTextOutput("summary")
                                ),
                        ),
                        tabItem(tabName = "map",
                                fluidRow(
                                  box(
                                    title = "Location of Customers",
                                    id = "map",
                                    status = "success",
                                    solidHeader = TRUE,
                                    width = 12,
                                    plotOutput("map", height = "750px")
                                  )
                                )
                        )
                      )
                    )
                )
)













