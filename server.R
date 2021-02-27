#server.R
library(shinyjs)
library(dplyr)

data <- read.csv(file = 'data.csv')
server <- function(input, output, session) {
  observe({
    language<- input$languages
    info <- subset(data, name==language)
    image <- info[1,3]
    author <- info[1,4]
    release <- info[1,5]
    version <- info[1,6]
    popyear20 <- info[1,7]
    popyear19 <- info[1,8]
    popyear18 <- info[1,9]
    popyear17 <- info[1,10]
    loved <- info[1,11]
    dread <- info[1,12]
    wanted <- info[1,13]
    
    js$loadData(image, author, release, version)
    
    output$plot <- renderPlot({
      range <- input$slider[1]:input$slider[2]
      x <- range
      y <- c(popyear17, popyear18, popyear19,popyear20)
      
      plot(x,y, type = "l")
    })
    
    output$plot2 <- renderPlot({
      value <- c(loved, dread, wanted)
      group <- c("Gostam", "Odeiam", "Querem")
      
      pie(value, labels = group, radius = 0.8)
    })
  })
                  
}
