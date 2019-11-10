library(shiny)
 
# Функция shinyUI() задает структуру пользовательского интерфейса:
 
shinyUI(fluidPage(
 
  # Название приложения
  headerPanel("Calculator"),
 
  # Функция, определяющая структуру боковой панели приложения:
  sidebarPanel(),
 
  # Функция, определяющая структуру основного окна приложения:
  mainPanel(
h1("Предикторы"), # Note the ,
numericInput("voz", # Name
"Возраст:", 
35),
h2("Эхо КГ"),
numericInput("LP", # Name
"ЛП:", # Label
3.5),
numericInput("IMMLG", # Name
"ИММЛЖ:", # Label
57),
numericInput("KDR", # Name
"КДР:", # Label
4.3),
numericInput("FV", # Name
"ФВ:", # Label
40),

h2("Биохимические показатели"),
numericInput("OX", # Name
"Общий холестерин:", # Label
1.30),
numericInput("LPVP", # Name
"ЛПВП:", # Label
0.47),
numericInput("Gluk", # Name
"Глюкоза:", # Label
3.52),
numericInput("Glek", # Name
"Галлектин:", # Label
0),
numericInput("NYP", # Name
"НУП:", # Label
0),
numericInput("SRB", # Name
"СРБ:", # Label
1.2),
numericInput("MK", # Name
"Мочевая кислота:", # Label
0),
numericInput("SKF", # Name
"СКФ:", # Label
18.8),

h2("Гемодинамические показатели"),
numericInput("SAD", # Name
"САД:", # Label
102.5),
numericInput("DAD", # Name
"ДАД:", # Label
48),
numericInput("HSS", # Name
"ЧСС:", # Label
52),
selectInput("XSNFK", # Name
"Выберите категорию ХСН ФК:", # Label
choices = c("0", "1", "2", "3", "4")),
selectInput("XSN stade", # Name
"Выберите стадию ХСН:", # Label
choices = c("0", "1", "2", "3")),

h2("Коморбидные заболевания"),
selectInput("XOBL", # Name
"ХОБЛ:", # Label
choices = c("0", "1")),
selectInput("HYPOTER", # Name
"Гипотериоз:", # Label
choices = c("0", "1")),
selectInput("TIMOTOX", # Name
"Тимотоксикоз:", # Label
choices = c("0", "1")),
selectInput("SDIA", # Name
"Сахарный диабет:", # Label
choices = c("0", "1")),
selectInput("FAT", # Name
"Абдоминальное ожирение:", # Label
choices = c("0", "1")),

submitButton("Load Preview Data") # Update data
)

 
))

