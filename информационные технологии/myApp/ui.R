library(shiny)
library(shinythemes)
library(xlsx)
library(evaluate)
library(rsconnect)

source('calc.R')
shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  tags$head(tags$script(src = "colorInput.js")),
  navbarPage(img(src = "logo.png",
                 height = 40, 
                 width = 35),
             selected = "Главная",
             tabPanel("Файл", icon = icon("file"),
                      downloadButton("downloadData","Сохранить файл")),
             tabPanel("Главная", 
                      icon = icon("home"), 
                      tabsetPanel(type = "tabs",
                                  tabPanel("Пациент",
                                           icon = icon("user"),
                                           fluidRow(
                                             column(3, textInput("familiya", label = h3("Фамилия"), placeholder = "Введите фамилию", width = 200)),
                                             column(3, textInput("imya", label = h3("Имя"), placeholder = "Введите имя", width = 200)),
                                             column(3, textInput("otchestvo", label = h3("Отчество"), placeholder = "Введите отчество", width = 200)),
                                             column(3, mInputNum("vozrast",label = h3("Возраст"), value = 57.5,mColor = 'gray',moninput='OnInputvozrast (event)')))),
                                  tabPanel("Эхо КГ",icon = icon("heartbeat"),
                                           fluidRow(
                                             column(3, mInputNum("lp",label = h3("ЛП"),value = 4.6,moninput='OnInputLP (event)',mColor = 'gray')),
                                             column(3, mInputNum("immlj",label = h3("ИММЛЖ"),value = 124.0,moninput='OnInputIMMLJ (event)',mColor = 'gray')),
                                             column(3, mInputNum("kdr",label = h3("КДР"),value = 5.8,moninput='OnInputKDR (event)',mColor = 'gray')),
                                             column(3, mInputNum("fv",label = h3("ФВ"),value = 59,moninput='OnInputFV (event)',mColor = 'gray'))
                                             )),
                                  tabPanel("Биохимические показатели",
                                           icon = icon("flask"),
                                           fluidRow(
                                             column(3, br(), mInputNum("holesterin",label = h3("Общий холестирин"),value = 4.97,moninput = 'OnInputholesterin (event)',mColor = 'gray')),
                                             column(3, br(), mInputNum("lpvp",label = h3("ЛПВП"),value = 1.42,moninput = 'OnInputlpvp (event)',mColor = 'gray')),
                                             column(3, br(), mInputNum("glukoza",label = h3("Глюкоза"),value = 5.93,moninput = 'OnInputglukoza (event)',mColor = 'gray')),
                                             column(3, br(), mInputNum("gallektin",label = h3("Галлектин"),value = 16.34,moninput = 'OnInputgallektin (event)',mColor = 'gray')),
                                             column(3, mInputNum("nup",label = h3("НУП"),value = 98.7,moninput = 'OnInputnup (event)',mColor = 'gray')),
                                             column(3, mInputNum("srb",label = h3("СРБ"),value = 5.6,moninput = 'OnInputsrb (event)',mColor = 'gray')),
                                             column(3, mInputNum("kislota",label = h3("Мочевая кислота"),value = 234.1,moninput = 'OnInputkislota (event)',mColor = 'gray')),
                                             column(3, mInputNum("skf",label = h3("СКФ"),value = 70.4,moninput = 'OnInputskf (event)',mColor = 'gray'))
                                             )),
                                  tabPanel("Гемодинамические показатели",
                                           icon = icon("tint"),
                                           fluidRow(
                                             column(6, mInputNum("sad",label = h3("САД"),value = 152.0,moninput = 'OnInputsad (event)',mColor = 'gray'),
                                                    mInputNum("dad",label = h3("ДАД"),value = 80.0,moninput = 'OnInputdad (event)',mColor = 'gray'),
                                                    mInputNum("chss",label = h3("ЧСС"),value = 73.0,moninput = 'OnInputchss (event)',mColor = 'gray')),
                                             column(6, sliderInput("hsn_fk", label = h3("ХСН ФК"), min = 0, max = 4, value = 2),
                                                    sliderInput("hsn_stadiya", label = h3("ХСН стадия"), min = 0, max = 3, value = 1))
                                             )),
                                  tabPanel("Коморбидные заболевания",
                                           icon = icon("notes-medical"),
                                           fluidRow(
                                             column(2, checkboxInput("hobl", label = "ХОБЛ", value = FALSE)),
                                             column(2, checkboxInput("gipoterios", label = "Гипотериоз", value = FALSE)),
                                             column(2, checkboxInput("timotoksikoz", label = "Тимотоксикоз", value = FALSE)),
                                             column(2, checkboxInput("diabet", label = "Сахарный диабет", value = FALSE)),
                                             column(2, checkboxInput("ojirenie", label = "Абдоминальное ожирение", value = FALSE))
                                             )),
                                  tabPanel("Прогноз",icon = icon("file-medical"),
                                           fluidRow(
                                             column(2,"     "),
                                             column(2,"ФП"),
                                             column(2,"Повторная госпитализация"),
                                             column(1,""),
                                             column(2,"Кардиоэмболия"),
                                             column(1,""),
                                             column(2,"ХСН")),
                                           fluidRow(
                                             column(2,"ЭИТ"),
                                             column(2,uiOutput("PFP")),
                                             column(2,uiOutput("PPG")),
                                             column(1,""),
                                             column(2,uiOutput("PKE")),
                                             column(1,""),
                                             column(2,uiOutput("PXSN"))),
                                           fluidRow(
                                             column(2,"Без ЭИТ"),
                                             column(2,uiOutput("NPFP")),
                                             column(2,uiOutput("NPPG")),
                                             column(1,""),
                                             column(2,uiOutput("NPKE")),
                                             column(1,""),
                                             column(2,uiOutput("NPXSN"))
                                           ),
                                           actionButton("SETDEFOULT","Сбросить данные")
                                  ))),
             tabPanel("Помощь", icon = icon("hands-helping"),
                      h3("Программа представляет собой калькулятор для расчета вероятности осложнений при лечении фибрилляции предсердий."),
                      h3('Вы можете скачать прогноз во вкладке Файл : Скачать файл'),
                      h3('Предварительно убедитесь что ввели Ф.И.О пациента.'),
                      h3("При выходе за 99% всех значений текст изменит цвет на красный.",style = "color:red;"),
                      h3("При выходе за 50% всех значений текст изменит цвет на светло оранжевым.",style = "color:#FFA500;")),
             tabPanel("О приложении", icon = icon("info"),
                      h4("Приложение создал студент гр. ИА-732 Наискулов Дмитрий Александрович"), 
                      img(src = "big_1503101090_image.jpg",
                          height = 500, 
                          width = 700)))
))