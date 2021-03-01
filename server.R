#server.R
library(shinyjs)

data <- read.csv(file = 'data.csv')
server <- function(input, output, session) {
  
  # DashBoard Main
  
  observe({
    language<- input$languages
    info <- subset(data, Linguagens==language)
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
      
    js$loadData(image)
    
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
    
    output$author <- renderValueBox({
      valueBox(
        value = tags$p(author, style="font-size: 18px; max-width:134px"), "Criado por: ")
    })
    
    output$release <- renderValueBox({
      valueBox(
        value = tags$p(release, style="font-size: 18px;"), "Lançado em: ")
    })
    
    output$version <- renderValueBox({
      valueBox(
        value = tags$p(version, style="font-size: 18px;"), "Ultima Versão: ")
    })
    
    output$porcentagem <- renderPlot({
      x <- 2017:2020
      y <- c(popyear17, popyear18, popyear19,popyear20)
      
      plot(x,y, type = "l", xaxt="none", xlab="", ylab="")
      axis(1, seq(2017, 2020, 1))
      mtext(side=1, line=2, "Ano")
      mtext(side=2, line = 2, "Popularidade (%)")
    })
    
    output$proporcaoa <- renderPlot({
      value <- c(loved, dread, wanted)
      labels <- c("Gostam", "Odeiam", "Querem")
      
      percentage<-round(value/sum(value)*100)
      
      labels_new<-paste(labels,percentage)
      labels_new
      
      final_labels<-paste(labels_new,'%',sep = "")
      final_labels
      
      pie3D(value, labels = final_labels, explode = 0.1, radius = 2, labelcex = 2, labelcol = "white")
    })
  })
  
  #Dashboard Table
  
  js$tableData(data)
  
  observe({
    langComp <- input$selectComparacao
    infoComp <- subset(data, Linguagens==langComp)
    png(file = "line_chart_2_lines.jpg")
    if(length(langComp)==0){
      output$compPlot <- renderPlot({
        compX1 <- 2017:2020
        compY1 <- c(0, 0, 0,0)
        plot(compX1,compY1, type = "l", xaxt="none", xlab="", ylab="")
        axis(1, seq(2017, 2020, 1))
        mtext(side=1, line=2, "Ano")
        mtext(side=2, line = 2, "Popularidade (%)")
      })
    } else {
        output$compPlot <- renderPlot({
          if(length(langComp)==1){
        compX1 <- 2017:2020
        compY1 <- c(infoComp[1,10], infoComp[1,9], infoComp[1,8],infoComp[1,7])
        plot(compX1,compY1, type = "l", xaxt="none", xlab="", ylab="")
        axis(1, seq(2017, 2020, 1))
        mtext(side=1, line=2, "Ano")
        mtext(side=2, line = 2, "Popularidade (%)")
    } else{
      for(i in infoComp){
        lines(c(2017:2020), c(infoComp[2,10], infoComp[2,9], infoComp[2,8],infoComp[2,7]), type = "l")
      }
    }
        })
    }
    dev.off()
  })
}