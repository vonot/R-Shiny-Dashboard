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
    
    let tabelas = {'2020' : document.getElementById('table20'),
                   '2019' : document.getElementById('table19'),
                   '2018' : document.getElementById('table18'),
                   '2017' : document.getElementById('table17')}
    
    //Montagem das tabelas
    
    const construirTabela = (year) =>{
        let place = 1
        
        dados.sort(function (a, b) {
	
	        return (a['x' + year] < b['x' + year]) ? 1 : ((b['x' + year] < a['x' + year]) ? -1 : 0);
 
        });
        
        for(let i = 0; i<length; i++){
          if(dados[i]['x' + year]!=null){
            let row = document.createElement('tr')
            let colPlace = document.createElement('td')
            let colLanguage = document.createElement('td')
            let colBar = document.createElement('td')
            
            let infoPlace = document.createTextNode(place)
            let infoLanguage = document.createTextNode(dados[i].nome)
            let infoBar = document.createTextNode(dados[i]['x' + year] +'%')
            
            tabelas[year].appendChild(row)
            row.appendChild(colBar)
            row.insertBefore(colLanguage, colBar)
            row.insertBefore(colPlace, colLanguage)
        
            colPlace.appendChild(infoPlace)
            colLanguage.appendChild(infoLanguage)
            colBar.appendChild(infoBar)
            
            place++
          }
      }
    }
    
    construirTabela('2020')
    
    construirTabela('2019')
  
    construirTabela('2018')
    
    construirTabela('2017')
}  
"

ui <-dashboardPage(
  
  dashboardHeader(title = "Dash LP"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dash", icon = icon("dashboard"), selected = TRUE),
      menuItem("Compare", tabName = "lista")
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
                                img(id = "logo", height = "100%", width = "100%", style = "border-radius:10px;")
                         ),
                         column(4,
                                box(
                                  title = "Historia", solidHeader = TRUE, width = 12, collapsible = TRUE,
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
      tabItem(tabName = "lista",
              fluidRow(
                tabBox(
                  title = "Lista das Linguagens mais populares",
                  id = "table", height = "250px",
                  tabPanel("2020",
                           tags$table(class = "table",
                                      tags$thead(
                                        tags$tr(
                                          tags$th("#"),
                                          tags$th("Linguagem"),
                                          tags$th("Popularidade")
                                        )
                                      ),
                                      
                                      tags$tbody(id = "table20")
                                      
                           )
                  ),
                  tabPanel("2019",
                           tags$table(class = "table",
                                      tags$thead(
                                        tags$tr(
                                          tags$th("#"),
                                          tags$th("Linguagem"),
                                          tags$th("Popularidade")
                                        )
                                      ),
                                      
                                      tags$tbody(id = "table19")
                                      
                           )
                  ),
                  tabPanel("2018",
                           tags$table(class = "table",
                                      tags$thead(
                                        tags$tr(
                                          tags$th("#"),
                                          tags$th("Linguagem"),
                                          tags$th("Popularidade")
                                        )
                                      ),
                                      
                                      tags$tbody(id = "table18")
                                      
                           )
                  ),
                  tabPanel("2017",
                           tags$table(class = "table",
                                      tags$thead(
                                        tags$tr(
                                          tags$th("#"),
                                          tags$th("Linguagem"),
                                          tags$th("Popularidade")
                                        )
                                      ),
                                      
                                      tags$tbody(id = "table17")
                                      
                           )
                  )
                ),
                
                column(6,
                       selectInput("selectComparacao", "Selecione as Linguagens para comparar", multiple = TRUE, choices, width = '100%'),
                       box(title = NULL, width = '100%',
                           plotOutput("compPlot")
                           )
                )
      )
      )
    )
  )
)