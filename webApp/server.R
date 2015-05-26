library(shiny)
library(InSilicoVA)
library(InterVA4)

# change maximum upload size
options(shiny.maxRequestSize=30*1024^2)

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
    
  })
  
  #Runs insilico method on the data.
  getFit <- reactive({ 
    #get user's data
    userData <- toAnalyze()
    
    #get the optional, user-provided cond prob
    userBase <- isolate(input$customProbbase)
    if (is.null(userBase) | isolate(input$defaultCondProb)) {
      userBase = NULL
    } else {
      userBase = read.csv(userBase$datapath)
    }
        
    #prevents NonElement problems
    if (!is.null(userData)) {
      burn <- round(isolate(input$simLength) / 2)
      fit <- insilico(userData, subpop = NULL, isNumeric = isolate(input$isNumeric), 
                      length.sim = isolate(input$simLength), burnin = burn, thin = 10, auto.length = isolate(input$autoLength),
                      conv.csmf = 0.02, external.sep = isolate(input$externalSep),
                      useProbbase = isolate(input$useProbbase),
                      keepProbbase.level = isolate(input$keepProbbase), cond.prob.touse = userBase,
                      datacheck = isolate(input$datacheck), seed = isolate(input$seed))
    }
  })
  
  
  #allows user to download a summary csv
  output$downloadData <- downloadHandler(
    filename = "InSilicoVASummary.csv",
    content = function(file) {
      if (!is.null(getFit())){
        summary.insilico(getFit(), file = file)
      }
    }
  )

  #renders the output for InterVA 
  output$InterVAPlot <- renderPlot({
    input$InterVAProcess
    print("here we are")
    userData <- isolate(input$readIn)
    
    if (is.null(userData))
      return (NULL)
    print("got the data")
    curr <- read.csv(userData$datapath)
    
    temp <- InterVA(curr, HIV = "h", Malaria = "v")
    Population.summary(temp$VA, type = "bar", main = "InterVA plot")
  })
  
  #renders the plot for InSilicoVA
  output$mainPlot <- renderPlot({
    if (!is.null(getFit())) {
      plot(getFit(), title = "Top CSMF Distribution using InSilicoVA");
    }
  })
})