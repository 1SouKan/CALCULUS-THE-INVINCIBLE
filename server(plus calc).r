library(shiny)
 
 # Функция shinyServer() определяет логику отображения элементов
 # графического интерфейса и обновления значений различных переменных:
 shinyServer(function(input, output) {
         
   output$retsediva_FP_EIT <- renderUI({
    
      z=-9.74+1.82*input$LP+0.41*as.integer(input$XSNFK)-0.01*input$IMMLG-0.24*input$SRB+0.35*input$Gluk+0.003*input$Glek+0.06*input$FV-0.02*input$SAD+2.48*as.integer(input$HYPOTER)+1.72*as.integer(input$TIMOTOX)
      retsediva_FP_EIT=exp(z)/(exp(z)+1)
       numericInput("retsediva_FP_EIT", "рецидива ФП в группе в группе ЭИТ", retsediva_FP_EIT)
   })
  
   output$PPovtGosp <- renderUI({
     
     z=-3.74+0.96*0.5+0.38*as.integer(input$XSNstade)+0.01*input$SAD+0.16*input$SRB
     PPovtGosp=exp(z)/(1+exp(z))
     numericInput("PPovtGosp", "риск повторной госпитализации в группе ЭИТ", PPovtGosp)
   })
   
   output$PCardEmb <- renderUI({
     z=3.09-0.44*input$OX-2.13*as.integer(input$XOBL)-0.03*input$DAD+0.56*0.5
     PCardEmb=exp(z)/(1+exp(z))
     numericInput("PCardEmb", "риск кардиоэмболии в группе в группе ЭИТ", PCardEmb)
   })
   
   output$PXCH <- renderUI({
     z=-13.04+1.35*input$LP-1.18*0.5-0.004*input$MK-1.15*input$KDR+0.07*input$HSS
     PXCH=exp(z)/(1+exp(z))
     numericInput("PXCH", "риск ХСН в группе ЭИТ",  PXCH)
     
   })
   
   output$PmtRezFp <- renderUI({
     z=26.22+3.24*as.integer(input$XSNFK)-2.01*input$KDR-0.14*input$FV-1.25*input$Gluk+0.01*input$Glek-0.89*input$SRB
     PmtRezFp=exp(z)/(1+exp(z))
     numericInput("PmtRezFp", "риск рецидивы ФП в группе МТ (без ЭИТ)", PmtRezFp)
     
   })
   
   output$PmtPovtGosp <- renderUI({
     z=-4.62+2.66*as.integer(input$XSNFK)+0.05*input$Glek-2.7*as.integer(input$HYPOTER)-2.15*input$Gluk+0.16*input$FV-0.10*input$voz+2.25*input$LP
     PmtPovtGosp=exp(z)/(1+exp(z))
     numericInput("PmtPovtGosp", "риск повторной госпитализации в группе в группе МТ (без ЭИТ)", PmtPovtGosp)
     
   })
   
   output$PmtCardEmb <- renderUI({
     z=9.06-0.15*input$HSS-1.31*input$Gluk+3.12*input$LPVP+0.03*input$SKF
     PmtCardEmb=exp(z)/(1+exp(z))
     numericInput("PmtCardEmb", "риск кардиоэмболии в группе МТ (без ЭИТ)", PmtCardEmb)  
     
   })
   
   output$PmtXCH <- renderUI({
     z=35.56-0.15*input$SAD-0.17*input$HSS+0.03*input$NYP
     PmtXCH=exp(z)/(1+exp(z))
     numericInput("PmtXCH", "риск ХСН в группе МТ (без ЭИТ)",  PmtXCH) 
     
   })
   
})


