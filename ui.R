library(shiny)
 
# Функция shinyUI() задает структуру пользовательского интерфейса:
shinyUI(
 fluidPage(

theme = shinytheme("united"),
  includeCSS("styles.css"),
  
  includeCSS("styles.css"),
  
  # Название приложения
  headerPanel("Calculator"),
 
  # Функция, определяющая структуру боковой панели приложения:
  sidebarPanel( 
   tags$div(class = "risks", id = "risksOut", 
     uiOutput("retsediva_FP_EIT"),
     uiOutput("PPovtGosp"       ),
     uiOutput("PCardEmb"        ),
     uiOutput("PXCH"            ),
     uiOutput("PmtRezFp"        ),
     uiOutput("PmtPovtGosp"     ),
     uiOutput("PmtCardEmb"      ),
     uiOutput("PmtXCH"          )
    ),

   width = 3,
  ),
 
  # Функция, определяющая структуру основного окна приложения:
  mainPanel(    
   tags$div(class = "predicts", id = "PRED",
    h1("Предикторы"), # Note the ,
    
    tags$div(class = "predictGroup", id = "age",
     numericInput("voz", # Name
      "Возраст:", # Label
      35),
    ),

    tags$div(class = "predictGroup", id = "ECG",
      h2("Эхо КГ"),
      numericInput("LP",    "ЛП:",    3.5),
      numericInput("IMMLG", "ИММЛЖ:", 57 ),
      numericInput("KDR",   "КДР:",   4.3),
      numericInput("FV",    "ФВ:",    40 )
     ),
    
    tags$div(class = "predictGroup", id = "BCV",
      h2("Биохимические показатели"),
      numericInput("OX",   "Общий холестерин:", 1.30),
      numericInput("LPVP", "ЛПВП:",             0.47),
      numericInput("Gluk", "Глюкоза:",          3.52),
      numericInput("Glek", "Галлектин:",        0   ),
      numericInput("NYP",  "НУП:",              0   ),
      numericInput("SRB",  "СРБ:",              1.2 ),
      numericInput("MK",   "Мочевая кислота:",  0   ),
      numericInput("SKF",  "СКФ:",              18.8)
     ), 
    
    tags$div(class = "predictGroup", id = "EDV",
      h2("Гемодинамические показатели"),
      numericInput("SAD", "САД:", 102.5),
      numericInput("DAD", "ДАД:", 48   ),
      numericInput("HSS", "ЧСС:", 52   ),
      
      selectInput("XSNFK",    "Выберите категорию ХСН ФК:", choices = c("0", "1", "2", "3", "4")),
      selectInput("XSNstade", "Выберите стадию ХСН:",       choices = c("0", "1", "2", "3"))
    ),
    
    tags$div(class = "predictGroup", id = "CP",
      h2("Коморбидные заболевания"),
      selectInput("XOBL",    "ХОБЛ:",                   choices = c("0", "1")),
      selectInput("HYPOTER", "Гипотериоз:",             choices = c("0", "1")),
      selectInput("TIMOTOX", "Тимотоксикоз:",           choices = c("0", "1")),
      selectInput("SDIA",    "Сахарный диабет:",        choices = c("0", "1")),
      selectInput("FAT",     "Абдоминальное ожирение:", choices = c("0", "1")),
    ),
   ),         
  )
 )
)

