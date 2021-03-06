library(shiny)
source("list1.R")

# Функция shinyServer() определяет логику отображения элементов
# графического интерфейса и обновления значений различных переменных:
shinyServer(function(input, output) {
  
  #   LP, IMMLG, KDR, FV, OX, LPVP, Gluk, Glek, NYP, SRB, MK, SKF, SAD, DAD, HSS, XSNFK, XSNstade, XOBL, HYPOTER, TIMOTOX, SDIA, FAT
  #tempData<-data.frame("retsediva_FP_EIT" = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PPovtGosp"        = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PCardEmb"         = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PXCH"             = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PmtRezFp"         = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PmtPovtGosp"      = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PmtCardEmb"       = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  ),
  #                     "PmtXCH"           = c(0 , 0    , 0  , 0 , 0 , 0   , 0   , 0   , 0  , 0  , 0 , 0  , 0  , 0  , 0  , 0    , 0       , 0   , 0      , 0      , 0   , 0  )
  #                     )
  
  
  observeEvent(input$confirmChoice, {
    if(input$password == "password") {
      tempData<-read.csv('tempData.csv')
      #tempRisk <- input$riskChoice
      #tempText <- renderPrint({tempRisk})
      #print(tempRisk)
      for(i in 1:22) {
        tempData[i, input$riskChoice] <- "0"
      } 
      for(i in 1:22) {
        for(val in input$predChoice) {
          if(val == pred[i]) {
            tempData[i, input$riskChoice] <- "1"
          }
        }
      }
      #print(tempData)
      write.csv(tempData, 'tempData.csv', row.names = FALSE)
    }
  })
  
  output$retsediva_FP_EIT <- renderUI({
    
    z=-9.74+1.82*input$LP+0.41*as.integer(input$XSNFK)-0.01*input$IMMLG-0.24*input$SRB+0.35*input$Gluk+0.003*input$Glek+0.06*input$FV-0.02*input$SAD+2.48*as.integer(input$HYPOTER)+1.72*as.integer(input$TIMOTOX)
    retsediva_FP_EIT=exp(z)/(exp(z)+1)
    textInput("retsediva_FP_EIT", "рецидива ФП в группе в группе ЭИТ", round(retsediva_FP_EIT,2))
  })
  
  output$PPovtGosp <- renderUI({
    
    z=-3.74+0.96*0.5+0.38*as.integer(input$XSNstade)+0.01*input$SAD+0.16*input$SRB
    PPovtGosp=exp(z)/(1+exp(z))
    textInput("PPovtGosp", "риск повторной госпитализации в группе ЭИТ", round(PPovtGosp,2))
  })
  
  output$PCardEmb <- renderUI({
    z=3.09-0.44*input$OX-2.13*as.integer(input$XOBL)-0.03*input$DAD+0.56*0.5
    PCardEmb=exp(z)/(1+exp(z))
    textInput("PCardEmb", "риск кардиоэмболии в группе в группе ЭИТ", round(PCardEmb,2))
  })
  
  output$PXCH <- renderUI({
    z=-13.04+1.35*input$LP-1.18*0.5-0.004*input$MK-1.15*input$KDR+0.07*input$HSS
    PXCH=exp(z)/(1+exp(z))
    textInput("PXCH", "риск ХСН в группе ЭИТ",  round(PXCH,2))
    
  })
  
  output$PmtRezFp <- renderUI({
    z=26.22+3.24*as.integer(input$XSNFK)-2.01*input$KDR-0.14*input$FV-1.25*input$Gluk+0.01*input$Glek-0.89*input$SRB
    PmtRezFp=exp(z)/(1+exp(z))
    textInput("PmtRezFp", "риск рецидивы ФП в группе МТ (без ЭИТ)", round(PmtRezFp,2))
    
  })
  
  output$PmtPovtGosp <- renderUI({
    z=-4.62+2.66*as.integer(input$XSNFK)+0.05*input$Glek-2.7*as.integer(input$HYPOTER)-2.15*input$Gluk+0.16*input$FV-0.10*input$voz+2.25*input$LP
    PmtPovtGosp=exp(z)/(1+exp(z))
    textInput("PmtPovtGosp", "риск повторной госпитализации в группе в группе МТ (без ЭИТ)", round(PmtPovtGosp,2))
    
  })
  
  output$PmtCardEmb <- renderUI({
    z=9.06-0.15*input$HSS-1.31*input$Gluk+3.12*input$LPVP+0.03*input$SKF
    PmtCardEmb=exp(z)/(1+exp(z))
    textInput("PmtCardEmb", "риск кардиоэмболии в группе МТ (без ЭИТ)", round(PmtCardEmb,2))  
    
  })
  
  output$PmtXCH <- renderUI({
    z=35.56-0.15*input$SAD-0.17*input$HSS+0.03*input$NYP
    PmtXCH=exp(z)/(1+exp(z))
    textInput("PmtXCH", "риск ХСН в группе МТ (без ЭИТ)",  round(PmtXCH,2)) 
    
  })
  
})
