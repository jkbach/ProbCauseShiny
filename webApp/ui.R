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
      fileInput("customProbbase", 
                "Upload a customized conditional probability table", 
                multiple = FALSE,
                accept = NULL),
      checkboxInput("defaultCondProb", "or click here to use the default", FALSE),
      br(),
      h3("Choose your preferences"),
      br(),
      sliderInput("simLength", "Number of iterations in the simulation", min=300, max=7000, value=4000),
      checkboxInput("isNumeric", "Data already in numeric form?", FALSE),
      checkboxInput("useProbbase", "Use without InterVA conditional probability reestimating?", TRUE), #NOT WORKING
      checkboxInput("keepProbbase", "Keep Probbase inconsistincies (ensures compatibility with InterVA)?", TRUE),
      checkboxInput("datacheck", "Check data consistency?", TRUE),
      checkboxInput("externalSep", "Separate out external clauses (suggested)?", TRUE),
      numericInput("seed", "Select Seed Value", 1, min = "1"),
      actionButton("processMe", "Analyze my data!"),
      hr(),
      downloadButton("downloadData", "Download Summary as .csv")
    ),
    
    mainPanel(
      plotOutput("mainPlot")
    )
  )
))
