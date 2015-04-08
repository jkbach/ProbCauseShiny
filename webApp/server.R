library(shiny)
library(InSilicoVA)

shinyServer(function(input, output) {
  
  output$mainPlot <- renderPlot({
    #Get user's data from input
    userData <- input$readIn
    
    #prevent bad file error, continue when data is added
    if (is.null(userData))
      return (NULL)
    
    #load the data so it can be manipulated, save to variable
    dataName<- load(userData$datapath)
    toAnalyze <- get(dataName)
    
    #run the no-argument insilico on the user's data 
    fit1 <- insilico(toAnalyze$data, subpop = NULL, HIV = "h", Malaria = "h", 
                     length.sim = 400, burnin = 200, thin = 10 , seed = 1,
                     InterVA.prior = TRUE, external.sep = TRUE, keepProbbase.level = TRUE)
   
    # default plot   
    plot(fit1)
    
  })
})