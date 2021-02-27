#server.R

data <- read.csv(file = 'data.csv')
server <- function(input, output, session) {
  observe({
    language<- input$languages
    info <- subset(data, name==language)
    pop <- info[1,3]
    image <- info[1,4]
    js$changeLogo(image)
  })
                  
}
