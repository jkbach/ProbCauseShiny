library(shiny)
install.packages("rJava")
library("rJava")

library(InSilicoVA)

shinyServer(function(input, output) {
  
  #Prepares the user's data for manipulation
  toAnalyze <- reactive({
    #Add dependency on processMe button
    input$processMe
    
    #Get user's data from input
    userData <- isolate(input$readIn)
    
    #prevent bad file error, continue when data is added
    if (is.null(userData))
      return (NULL)
    
    #load the data so it can be manipulated, save to variable
    curr <- read.csv(userData$datapath)
    return (curr)
  })
  
  #Runs "a" insilico command on the data.  Note that this is the default
  #and options will need to be added.
  getFit <- reactive({
    userData <- toAnalyze()
    
    #prevents NonElement problems
    if (!is.null(userData)) {
      burn <- round(input$simLength / 2)
     fit <- insilico(userData, subpop = NULL, HIV = "h", Malaria = "h", isNumeric = input$isNumeric,
                     length.sim = input$simLength, burnin = burn, thin = 10 , seed = 1, conv.csmf = 0.02,
                     InterVA.prior = TRUE, external.sep = TRUE, useProbbase = input$useProbbase,
                     keepProbbase = input$keepProbbase, datacheck = input$datacheck)
#      fit<- insilico(userData, subpop = NULL, HIV = "h", Malaria = "h", 
#                       length.sim = input$simLength, burnin = burn, thin = 10 , seed = 1,
#                       InterVA.prior = TRUE, external.sep = TRUE, keepProbbase.level = TRUE)
      return (fit)
    }
   })
  
  
  #Creates a summary of the data
  getSum <- reactive({
    getFit <- getFit()
    if (!is.null(getFit)) {  
      print(summary(getFit))
    }
  })
  
  output$downloadData <- downloadHandler(
      filename = "InSilicoVASummary.csv",
      content = function(file) {
        if (!is.null(getFit())){
          summary(getFit(), file = file)
        }
      }
  )
  output$mainPlot <- renderPlot({
    fit <- getFit()
    if (!is.null(fit)) {
      plot(fit);
    }
  })
})