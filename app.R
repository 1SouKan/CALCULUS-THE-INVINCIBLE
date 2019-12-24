library(shiny)

myData <- read.csv2('I:\\InfTech\\newShit\\calculusTheShitty\\Для оценки прогрессирования ФП.csv')
myDataHead <- head(myData, 0)
predChoiceFV <- list()

ui <- fluidPage(

    headerPanel("Calculator"),

    navbarPage(
        tabPanel("superFix"),
        tabPanel("Choose",
            fluidRow(
                column( width = 4,
                        checkboxGroupInput("resikChoice", "Choose risk", myDataHead[30]),
                        checkboxGroupInput("predChoice", "Choose predictors", colnames(myDataHead[1:length(myDataHead)-1]))
                ),
                column( width = 4,
                        passwordInput("password", "Password"),
                        actionButton("confirmChoice", "Confirm Choice")
                )
            )
        ),
        
        tabPanel("Input",
                 fluidRow(
                     column(width = 4,
                        textInput("familiya" , label = h2("Фамилия") , placeholder = "Введите фамилию" ),
                        textInput("imya"     , label = h2("Имя")     , placeholder = "Введите имя"     ),
                        textInput("otchestvo", label = h2("Отчество"), placeholder = "Введите отчество"),
                        numericInput("Возраст", "Возраст:", 35     ),
                        selectInput ("Пол"    , "Пол:"    , c(1, 2))
                     ),
                     column(width = 4,
                            numericInput("ОХ",   "Общий холестерин:", 1.30),
                            numericInput("ЛПНП", "ЛПНП:",             0.47),
                            numericInput("ТГ", "ТГ:", 1.7),
                            numericInput("ЛПВП", "ЛПВП:",             0.47),
                            numericInput("Глюкоза.ммоль.л", "Глюкоза:", 3.52),
                            numericInput("Калий.ммоль.л",   "Калий:",   3.52),
                            numericInput("Мочевина",   "Мочевина:",     3.52),
                            numericInput("Креатин.мкмоль.л",   "Креатин:",   3.52),
                            numericInput("СКФ",  "СКФ:",              18.8),
                            numericInput("СРБ",  "СРБ:",              1.2 ),
                            numericInput("Фибриноген",  "Фибриноген:", 1.2 ),
                            numericInput("MK",   "Мочевая кислота:",  0   ),
                            numericInput("NTproBNP", "NTproBNP",       4 )
                     ),
                     column(width = 4,
                            numericInput("Галлектин.3", "Галлектин:",  0   ),
                            selectInput("ХСН.стадия", "Выберите стадию ХСН:",       choices = c("0", "1", "2", "3")),
                            selectInput("ХСН.ФК",     "Выберите категорию ХСН ФК:", choices = c("0", "1", "2", "3", "4")),
                            selectInput("Терапия",     "Терапия:", choices = c("1", "2")),
                            numericInput("ИММЛЖ", "ИММЛЖ:", 57 ),
                            numericInput("САД", "САД:", 102.5),
                            numericInput("ДАД", "ДАД:", 48   ),
                            numericInput("ЧСС", "ЧСС:", 52   ),
                            numericInput("ЛП",    "ЛП:",    3.5),
                            
                            numericInput("КДР",   "КДР:",   4.3),
                            numericInput("ФВ",    "ФВ:",    40 ),
                            numericInput("Длительность.АГ",  "Длительность АГ:",    0   ),
                            )
                    
                 )
        ),
        
        tabPanel("Calculate",
            fluidRow(
                column(width = 3,
                    actionButton("do", "DO!")
                ),
                column(width = 3,
                    h3("dependencies:"),
                    uiOutput("dependenciesOut", width = 900),
                    h3("risk:"),
                    uiOutput("riskOut")
                )
            )
        )
    )
)


server <- function(input, output) {
    
   #Сейчас не выполняет никакой функции кроме умозрительной
   observeEvent(input$confirmChoice, {
       #if(input$password == "password"){
           #predChoiceFV <- list()
           predChoiceFV <- input$predChoice
           print(predChoiceFV)
           print(input$predChoice)
       #}
   })

    observeEvent(input$do, {
        pr <- paste(input$predChoice, collapse = "+")
        print(pr)
        frm <- as.formula(paste(colnames(myDataHead[30]), "~", pr))
        print(frm)
        glmData <- glm(frm, binomial, myData)
        print(glmData)
        #output$dependenciesOut <- renderText({
        #    glmData.coef
        #})
        prMass <- c()
        print(length(input$predChoice))
        for(i in input$predChoice) {
            j <- as.vector(i)
            prMass <- c(prMass, input$j)
            print(j)
            print(input$j)
        }
        print(as.vector(prMass))
        finData <- predict(glmData, "response", prMass)
        print(finData)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
