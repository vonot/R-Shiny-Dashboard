#ui.R

library(shiny)
library(shinydashboard)
library(shinyjs)

data <- read.csv(file = 'data.csv')
print(data)
choices <- data[2]
print(choices)

jsCode <- "
shinyjs.loadData = function(params){
  var defaultParams = {
    image : null,
    author : null,
    release : 2021,
    version : 1
  };
  
  params = shinyjs.getParams(params, defaultParams);
  
  var logo = document.getElementById('logo')
  var author = document.getElementById('author')
  var release = document.getElementById('year')
  var version = document.getElementById('version')
  logo.src = params.image
  author.innerHTML = params.author
  release.innerHTML = params.release
  version.innerHTML = params.version
}
"

ui <- dashboardPage(
  dashboardHeader(title = "Dash LP"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dash", icon = icon("dashboard")),
      menuItem("Compare",
                  menuSubItem("Lista das Mais Populares 2020", tabName = "lista"),
                  menuSubItem("Compare Linguagens", tabName = "compare"))
    )
  ),
  dashboardBody(
    useShinyjs(),
    extendShinyjs(text = jsCode, functions = c("loadData")),
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
                       p(id="year"),
                       p(id="author"),
                       p(id="version"),
                )
              ),
              fluidRow(
                column(6,
                       plotOutput("plot"),
                       sliderInput(max = 2020, min = 2017, inputId = "slider", label = "Select Range of Plot", value = c(2017,2020))
                       
                ),
                column(6,
                       plotOutput("plot2")
                )
              )
              
      ),
      
      tabItem( tabName = "lista",
        p("OLa")
      ),
      
      tabItem(tabName = "compare",
      p("hello")
      )
    )
)
)