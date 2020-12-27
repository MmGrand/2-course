library(shiny)
library(shinythemes)
library(xlsx)
library(evaluate)
library(rsconnect)
PFP.z <- function(lp,hsn_fk,immlj,srb,glukoza,gallektin,fv,sad,gipoterios,timotoksikoz){
  return(1.82*lp + 0.41*hsn_fk + 0.003*gallektin + 0.06*fv - 0.02*sad - 9.74 - 0.01*immlj - 0.24*srb + 0.35*glukoza + 2.48*as.integer(gipoterios) + 1.72*as.integer(timotoksikoz))
}
PPG.z <-function(actr1.ct,hsn_stadia,sad,srb){
  return(-3.76 + 0.96*actr1.ct + 0.38* hsn_stadia + 0.01*sad + 0.16*srb)
}
PKE.z <- function(OH,hobl,dad,actr1.ct){
  return(3.09-0.44*OH-2.13*hobl-0.03*dad+0.56*actr1.ct)
}
PXSN.z <- function(lp,actr1.ct,kislota,kdr,chss){
  return(-13.04 + 1.35*lp-1.18*actr1.ct - 0.004*kislota - 1.15*kdr + 0.07*chss)
}
NPFP.z <- function(hsn_fk,kdr,fv,glukoza,gallektin,srb){
  return(26.22 + 3.24*hsn_fk - 2.01*kdr - 0.14*fv - 1.25*glukoza + 0.01*gallektin - 0.89*srb)
}
NPPG.z <-function(hsn_fk,gallektin,gipoterios,glukoza,fv,vozrast,lp){
  return(-4.62 + 2.66*hsn_fk + 0.05*gallektin - 2.70* as.integer(gipoterios) - 2.15*glukoza + 0.16*fv - 0.10*as.integer(vozrast) + 2.25*lp)
}
NPKE.z <- function(chss,glukoza,lpvp,skf){
  return(9.06 - 0.15*chss - 1.31*glukoza + 3.12*lpvp + 0.03*skf)
}
NPXSN.z <- function(sad,chss,nup){
  return(35.56 - 0.15*sad - 0.17*chss + 0.03*nup)
}
Calc.result <- function(Z){
  e <- 2.718
  return(100*round(((e^Z)/(1+e^Z)),3))
}
mInputNum <- function (inputId, label, value, min = NA, max = NA, step = NA, 
                       mColor = NULL,moninput=NULL, ...) 
{
  value <- restoreInput(id = inputId, default = value)
  inputTag <- tags$input(id = inputId, type = "number", class = "form-control", 
                         value = value,style = if (!is.null(mColor)) 
                           paste0("color: ", mColor, ";"))
  if (!is.na(min)) 
    inputTag$attribs$min = min
  if (!is.na(max)) 
    inputTag$attribs$max = max
  if (!is.na(step)) 
    inputTag$attribs$step = step
  div(class = "form-group shiny-input-container",
      tags$label(label, `for` = inputId), inputTag)
}



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