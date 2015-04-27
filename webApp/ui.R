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
      sliderInput("simLength", "Number of iterations in the simulation"),
      sliderInput("burnin", "Iterations to discard from the beginning")
      checkboxInput("isNumeric", "Already in numeric form", FALSE),
      checkboxInput("useProbbase", "Use InterVA conditional probability reestimating", FALSE),
      checkboxInput("keepProbbase", "keepProbbase", FALSE),
      checkboxInput("datacheck", "Check data consistency", TRUE),
      actionButton("processMe", "Generate data"), 
      hr(),
      downloadButton("downloadData", "Download Summary as .csv")
    ),
    
    mainPanel(
      plotOutput("mainPlot")
    )
  )
))