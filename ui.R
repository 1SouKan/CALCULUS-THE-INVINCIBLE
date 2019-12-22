library(shiny)
library(shinythemes)
#library(xlsx)
library(evaluate)
library(rsconnect)

source("list1.R")

shinyUI(fluidPage(
  
  # theme = shinytheme("united"), Не вставялйте это говно, оно перекрывает наши стили
  includeCSS("styles.css"),
  
  # includeCSS("styles.css"), Зачем вы два раза ее прописали?
  
  # Название приложения
  headerPanel("Calculator"),
  
  #theme = shinytheme("flatly"),
  tags$head(tags$script(src = "colorInput.js")),
  
  
  navbarPage(img(src = "logo.png",
             height = 40, 
             width = 35),
             selected = "Главная",
             
    tabPanel("Файл", icon = icon("file"),
             downloadButton("downloadData","Сохранить файл")
            ),                      
    tabPanel("Главная", icon = icon("home"), 
             tabsetPanel(type = "tabs",
                               
             tabPanel("Пациент",
                      icon = icon("user"),
                                           
                      tags$div(class = "predicts", id = "PRED",
                               h1("Предикторы"), # Note the ,
                                                    
                               tags$div(class = "predictGroup", id = "age",
                                        textInput("familiya",
                                                  label = h3("Фамилия"),
                                                  placeholder = "Введите фамилию",
                                                  width = 200),
                                        
                                        textInput("imya",
                                                  label = h3("Имя"),
                                                  placeholder = "Введите имя",
                                                  width = 200),
                                        
                                        textInput("otchestvo",
                                                  label = h3("Отчество"),
                                                  placeholder = "Введите отчество",
                                                  width = 200),
                                        
                                        numericInput("voz", # Name
                                                     "Возраст:", # Label
                                                     35),
                                        
                                        #selectInput("EIT", #Name
                                        #            "ЭИТ", #Label
                                        #             choices=c("0","1"))
                                        #),
                               )
                      ),#конец tabPanel "Пациент"
                                
                                  
                                  
                                  
                                  
             tabPanel("Эхо КГ",icon = icon("heartbeat"),
                      tags$div(class = "predictGroup", id = "ECG",
                             h2("Эхо КГ"),
                             numericInput("LP",    "ЛП:",    3.5),
                             numericInput("IMMLG", "ИММЛЖ:", 57 ),
                             numericInput("KDR",   "КДР:",   4.3),
                             numericInput("FV",    "ФВ:",    40 )
                             ),
                    ),#конец tabPanel "Эхо ЭКГ"
                                  
                      
                      
             tabPanel("Биохимические показатели",
                      icon = icon("flask"),
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
                      ),#конец tabPanel "Биохимические показатели"
                                  
                      
                      
             tabPanel("Гемодинамические показатели",
                      icon = icon("tint"),
                      tags$div(class = "predictGroup", id = "EDV",
                               h2("Гемодинамические показатели"),
                               numericInput("SAD", "САД:", 102.5),
                               numericInput("DAD", "ДАД:", 48   ),
                               numericInput("HSS", "ЧСС:", 52   ),
                               selectInput("XSNFK",    "Выберите категорию ХСН ФК:", choices = c("0", "1", "2", "3", "4")),
                               selectInput("XSNstade", "Выберите стадию ХСН:",       choices = c("0", "1", "2", "3"))
                               ),
                      ),#конец tabPanel "Гемодинамические показатели"
                                  
                      
             tabPanel("Коморбидные заболевания",
                      icon = icon("notes-medical"),
                                           
                      tags$div(class = "predictGroup", id = "CP",
                               h2("Коморбидные заболевания"),
                               selectInput("XOBL",    "ХОБЛ:",                   choices = c("0", "1")),
                               selectInput("HYPOTER", "Гипотериоз:",             choices = c("0", "1")),
                               selectInput("TIMOTOX", "Тимотоксикоз:",           choices = c("0", "1")),
                               selectInput("SDIA",    "Сахарный диабет:",        choices = c("0", "1")),
                               selectInput("FAT",     "Абдоминальное ожирение:", choices = c("0", "1")),
                               ),   
                      ),#конец tabPanel "Коморбидные заболевания"
                                  
             tabPanel("Прогноз",icon = icon("file-medical"),
                      actionButton("SETDEFOULT","Сбросить данные"),
                      
                      tags$div(class = "risks", id = "risksOut",
                                                    
                      tabPanel("ЭИТ",
                               uiOutput("retsediva_FP_EIT"),
                               uiOutput("PPovtGosp"       ),
                               uiOutput("PCardEmb"        ),
                               uiOutput("PXCH"            ),
                      ),
                                                   
                      tabPanel("Без ЭИТ",
                               uiOutput("PmtRezFp"        ),
                               uiOutput("PmtPovtGosp"     ),
                               uiOutput("PmtCardEmb"      ),
                               uiOutput("PmtXCH"          )
                               )
                      )
                      )#конец tabPanel "Прогноз"
             
             
             )# конец tabsetPanel
             ),#конец tabPanel(2) "Главная"
             
    tabPanel("Администрирование", icon = icon("black-tie")
             tags$div(id = "admoon", 
                      fluidRow(
                        column (width = 4,
                                selectInput       ("riskChoice"   , "Выберите риск:"      , risk),
                                passwordInput     ("password"     , "Введите пароль:"           ),
                                actionButton      ("confirmChoice", "Подтвердите выбор"         )
                                ),
                        column (width = 4,
                                checkboxGroupInput("predChoice"   , "Выберите предикторы:", pred)
                                )
                         )
                   )      
             ),        
             
    tabPanel("Помощь", icon = icon("hands-helping"),
             h3("Программа представляет собой калькулятор для расчета вероятности осложнений при лечении фибрилляции предсердий."),
             h3('Вы можете скачать прогноз во вкладке Файл : Скачать файл'),
             h3('Предварительно убедитесь что ввели Ф.И.О пациента.'),
             h3("При выходе за 99% всех значений текст изменит цвет на красный.",style = "color:red;"),
             h3("При выходе за 50% всех значений текст изменит цвет на светло оранжевым.",style = "color:#FFA500;")
             ),
             
    tabPanel("О приложении", icon = icon("info"),
             h4("Приложение создала бригада лучших специалистов по лени университета СибГУЧИ"), 
             img(src = "https://leonardo.osnova.io/ccbb85d2-b01a-0a0d-7c83-b0560821e630/-/resize/800/-/progressive/yes/",
                 height = 500,
                 width = 700)
            )
    
    )  # конец navbarPage
))
