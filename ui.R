#ui.R

library(shiny)
library(shinydashboard)
library(shinyjs)

data <- read.csv(file = 'data.csv')

for(i in data){
  choices<- data[i,2]
}

jsCode <- "
shinyjs.changeLogo = function(image){
  var logo = document.getElementById('logo')
  logo.src = image
}
"

ui <- dashboardPage(
  dashboardHeader(title = "Dash LP"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dash", icon = icon("dashboard")),
      menuItem("Compare", tabName = "comp")
    )
  ),
  dashboardBody(
    useShinyjs(),
    extendShinyjs(text = jsCode, functions = c("changeLogo")),
    tabItems(
      tabItem(tabName = "dash",
              fluidRow(
                column(12,
                       selectInput("languages", "Select Languges", choices = choices, multiple = FALSE, selected = NULL, width = "100%"), 
                )
              ),
              fluidRow(
                column(6,
                       img(id = "logo", height = "200px", width = "200px")),
                column(6,
                       fluidRow(
                         column(12,
                                p("Hello"))
                       ),
                       fluidRow(
                         column(6,
                                p("Create By: ")),
                         column(6,
                                p("At:"))
                       )
                )
              )
      ),
      
      tabItem( tabName = "comp",
        p("OLa")
      )
    )
)
)