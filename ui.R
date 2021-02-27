#ui.R

library(shiny)
library(shinydashboard)
library(shinyjs)
library(plotrix)

data <- read.csv(file = 'data.csv')
choices <- data[2]

jsCode <- "
shinyjs.loadData = function(params){
  var defaultParams = {
    image : null,
  };
  
  params = shinyjs.getParams(params, defaultParams);
  
  var logo = document.getElementById('logo')
  logo.src = params.image
}
"

ui <- dashboardPage(
  
  dashboardHeader(title = "Dash LP"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dash", icon = icon("dashboard")),
      menuItem("Compare",
                  menuSubItem("Lista das Mais Populares 2020", tabName = "lista"),
                  menuSubItem("Compare a Popularidade", tabName = "compare"))
    )
  ),
  dashboardBody(
    useShinyjs(),
    extendShinyjs(text = jsCode, functions = c("loadData")),
    tabItems(
      tabItem(tabName = "dash",
              fluidRow(
                column(12,
                       selectInput("languages", "Selecione a Linguagem", choices = choices, multiple = FALSE, selected = NULL, width = "100%"), 
                ),
                column(6,
                       box(
                         title = "Informação sobre a Linguagem", status = "primary", solidHeader = TRUE, collapsible = FALSE, width = 12,
                         column(4,
                                img(id = "logo", height = "100%", width = "100%", style="border-radius:10px;")
                         ),
                         column(4,
                                box(
                                  title = "Historia", solidHeader = TRUE, width = 12,
                                  p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tristique justo quis leo volutpat, id vestibulum risus tempus. Morbi fringilla tempus risus sit amet accumsan.")
                                )
                          ),
                         column(4,
                                valueBoxOutput("author", width = 12),
                                valueBoxOutput("release", width = 12),
                                )
                         
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
                         title = "Grafico Popularidade (%) / Tempo (Ano)", solidHeader = TRUE, collapsible = TRUE, width = 12,
                         plotOutput("porcentagem")
                       )
                ),
                
                column(6,
                       box(
                         title = "Proporção entre Pessoas que Gostam, Odiam e Querem aprender a Linguagem", solidHeader = TRUE, collapsible = TRUE, width = 12,
                         plotOutput("proporcaoa")
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