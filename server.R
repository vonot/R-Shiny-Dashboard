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
    
    output$pop20 <- renderValueBox({
      valueBox(
        paste0(popyear20, "%"), "Popularidade de 2020", icon = icon("thumbs-up"))
    })
    
    output$pop19 <- renderValueBox({
      valueBox(
        paste0(popyear19, "%"), "Popularidade de 2019", icon = icon("hand-scissors"), color = "green")
    })
    
    output$pop18 <- renderValueBox({
      valueBox(
        paste0(popyear18, "%"), "Popularidade de 2018", icon = icon("hand-rock"), color = "yellow")
    })
    
    output$pop17 <- renderValueBox({
      if(is.na(info[1,10])){
        popyear17Fixed <- '--'
      } else{
        popyear17Fixed <- paste0(popyear17, "%")
      }
      valueBox(
        popyear17Fixed, "Popularidade de 2017", icon = icon("hand-paper"), color = "red")
    })
    
    output$plot <- renderPlot({
      x <- 2017:2020
      y <- c(popyear17, popyear18, popyear19,popyear20)
      
      plot(x,y, type = "l", xaxt="none", xlab="")
      axis(1, seq(2017, 2020, 1))
      mtext(side=1, line=2, "Ano")
    })
    
    output$plot2 <- renderPlot({
      value <- c(loved, dread, wanted)
      group <- c("Gostam", "Odeiam", "Querem")
      
      pie(value, labels = group, radius = 0.8)
    })
  })
                  
}
