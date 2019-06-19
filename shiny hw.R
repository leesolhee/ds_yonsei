## 데이터 살펴보기
str(mtcars)

## 앱 생성

#패키지 로딩
library(shiny)
require(ggplot2)


### ui
ui <- fluidPage(
  titlePanel('Regression Analysis of mtcars'),
  sidebarLayout(
    sidebarPanel(
      selectInput('x', 'Select independent variable',
                  choices = c("",names(mtcars)[-1])),
      actionButton("analysis"," Analysis "),
      hr()
    ),
    mainPanel(
      plotOutput('plot'),
      verbatimTextOutput("text")
    )
  )
)


### server
server <- function(input, output) {
  output$plot=renderPlot({
    input$analysis
    isolate({
      
      ggplot(data=mtcars, aes_string(req(input$x),"mpg"))+
        geom_point()+
        geom_smooth(method="lm")
    })
  })
  output$text=renderPrint({
    input$analysis
    isolate({
      options(digits = 3)
      fit <- eval(parse(text=paste0("lm(mpg ~",req(input$x),",data = mtcars)")))
      b <- coef(fit)
      summary(fit)
    })
  })
  
}  


## 앱 로딩

shinyApp(ui,server)
