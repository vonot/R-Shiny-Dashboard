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
  author.innerHTML = 'Criado por: ' +  params.author
  release.innerHTML = 'Lançado em: ' + params.release
  version.innerHTML = 'Versão Atual: ' + params.version
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
                ),
                column(6,
                       box(
                         title = "Informação sobre a Linguagem", status = "primary", solidHeader = TRUE, collapsible = FALSE, width = 12,
                         img(id = "logo", height = "150px", width = "150px", style="border-radius:10px;")
                       )
                ),
                column(6,
                       valueBoxOutput("pop20", width = 6),
                       valueBoxOutput("pop19", width = 6),
                       valueBoxOutput("pop18", width = 6),
                       valueBoxOutput("pop17", width = 6)
                )
              ),
              fluidRow(
                column(6,
                       box(
                         title = "Grafico Popularida (%) / Tempo (Ano)", solidHeader = TRUE, collapsible = TRUE, width = 12,
                         plotOutput("plot")
                       )
                ),
                
                column(6,
                       box(
                         title = "Grafico Popularida (%) / Tempo (Ano)", solidHeader = TRUE, collapsible = TRUE, width = 12,
                         plotOutput("plot2")
                       )
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