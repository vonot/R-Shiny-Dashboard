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
      image : null
    };
  
    params = shinyjs.getParams(params, defaultParams);
  
    var logo = document.getElementById('logo')
    logo.src = params.image
  }
  
shinyjs.tableData = function(params){

    // Inicalização dos dados
    
    var defaultParams = {
      data : null
    };
    
    params = shinyjs.getParams(params, defaultParams);
    
    let data = params.data
    
    let length = data['Linguagens'].length
    
    let dados = []
    
    for(let i=0; i<length; i++){
    dados[i] = {nome: data.Linguagens[i],
                x2020 : data.X2020[i],
                x2019 : data.X2019[i],
                x2018 : data.X2018[i],
                x2017 : data.X2017[i]}
    }
    
    //Inicialização das tabelas
    
    var table20 = document.getElementById('table20')
    var table20 = document.getElementById('table19')
    var table20 = document.getElementById('table18')
    var table20 = document.getElementById('table17')
    
    //Montagem das tabelas
    
    //2020
    
    table20.innerHTLM += '<tbody>'
    for(let i = 0; i<length; i++){
      if(dados[i].x2020 != null){}
      
    }
    
    
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
    extendShinyjs(text = jsCode, functions = c("loadData", "tableData")),
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
               fluidRow(
                 tabBox(
                 title = "Lista das Linguagens mais populares",
                 id = "table", height = "250px",
                 tabPanel("2020", 
                          tags$table(class= "table", id="table20",
                                     tags$thead( class="thead-light",
                                                 tags$tr(
                                                   tags$th("#"),
                                                   tags$th("Linguagem"),
                                                   tags$th("Popularidade"),
                                                 )
                                       
                                     ))
                            ), 
                 tabPanel("2019",
                          tags$table(class= "table", id="table19",
                                     tags$thead( class="thead-light",
                                                 tags$tr(
                                                   tags$th("#"),
                                                   tags$th("Linguagem"),
                                                   tags$th("Popularidade"),
                                                 )
                                                 
                                     ))
                          ),
                 tabPanel("2018", 
                          tags$table(class= "table", id="table18",
                                     tags$thead( class="thead-light",
                                                 tags$tr(
                                                   tags$th("#"),
                                                   tags$th("Linguagem"),
                                                   tags$th("Popularidade"),
                                                 )
                                                 
                                     ))
                          ),
                 tabPanel("2017",
                          tags$table(class= "table", id="table17",
                                     tags$thead( class="thead-light",
                                                 tags$tr(
                                                   tags$th("#"),
                                                   tags$th("Linguagem"),
                                                   tags$th("Popularidade"),
                                                 )
                                                 
                                     ))
                          )
                )
               )
      ),
      
      tabItem(tabName = "compare",
      
      taskItem(value = 90, color = "green",
               "Teste")
      )
    )
  )
)