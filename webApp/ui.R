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
      h3("Choose your preferences"),
      br(),
      sliderInput("simLength", "Number of iterations in the simulation", min=300, max=7000, value=5000),
      checkboxInput("isNumeric", "Data already in numeric form?", FALSE),
      checkboxInput("useProbbase", "Use InterVA conditional probability reestimating?", TRUE),
      checkboxInput("keepProbbase", "Keep Probbase inconsistincies (ensures compatibility with InterVA)?", TRUE),
      checkboxInput("datacheck", "Check data consistency?", TRUE),
      actionButton("processMe", "Analyze my data!"), 
      hr(),
      downloadButton("downloadData", "Download Summary as .csv")
    ),
    
    mainPanel(
      plotOutput("mainPlot")
    )
  )
))
