library(shiny)
library(InSilicoVA)

shinyUI(fluidPage(
  
  titlePanel("Probabilistic Cause-of-death Assignment using Verbal Autopsies"),
  p("The complete study can be viewed ", a(href="http://arxiv.org/abs/1411.3042", "here")),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("readIn", 
                "Upload your own data here", 
                multiple = FALSE,
                accept = NULL),
      downloadButton("downloadData", "Click here to download a csv of the data")
    ),
    
    mainPanel(
      plotOutput("mainPlot")
    )
  )
))