library(shiny)
library(InSilicoVA)

shinyUI(fluidPage(
  
  titlePanel("Probabilistic Cause-of-death Assignment using Verbal Autopsies"),          
  p("Developed by Tyler McCormick ", (a(href="mailto:tylermc@uw.edu", "(tylermc@uw.edu)")), 
    "and Zehang Richard Li ", a(href="mailto:lizehang@uw.edu", "(lizehang@uw.edu)")),  
  p("The complete study can be viewed ", a(href="http://arxiv.org/abs/1411.3042", "here")),
  hr(),
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
      hr(),
      h3("Choose your preferences"),
      br(),
      sliderInput("simLength", "Number of iterations in the simulation", min=300, max=7000, value=4000),
      checkboxInput("autoLength", "Automatically increase iterations if needed?", FALSE),
      checkboxInput("isNumeric", "Data already in numeric form?", FALSE),
      checkboxInput("useProbbase", "Use InterVA conditional probability without reestimating?", FALSE), #NOT WORKING
      checkboxInput("keepProbbase", "Estimating Probbase levels only", TRUE),
      checkboxInput("datacheck", "Check data consistency?", TRUE),
      checkboxInput("externalSep", "Separate out external clauses (suggested)?", TRUE),
      numericInput("seed", "Select Seed Value", 1, min = "1"),
      h6("(Please note this connection is not encrypted.  Do not upload data that 
          require a secure connection.)"),
      actionButton("processMe", "Analyze my data!"),
      hr(),
      downloadButton("downloadData", "Download Summary as .csv")
    ),
    
    mainPanel(
      plotOutput("mainPlot")
    )
  ),
  p("Webpage created by John Kaltenbach ", a(href="mailto:jkbach@uw.edu", "(jkbach@uw.edu)"))
))
