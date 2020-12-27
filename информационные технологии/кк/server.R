library(shiny)
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



shinyServer(function(input, output, session) {
  actr1.ct = 0.5
  dataCalculations <- reactive({
    r.PFP <- Calc.result(PFP.z(as.numeric(input$lp),as.numeric(input$hsn_fk),as.numeric(input$immlj),as.numeric(input$srb),as.numeric(input$glukoza),as.numeric(input$gallektin),as.numeric(input$fv),as.numeric(input$sad),input$gipoterios,input$timotoksikoz))
    r.PPG <- Calc.result(PPG.z(actr1.ct,as.numeric(input$hsn_stadiya),as.numeric(input$sad),as.numeric(input$srb)))
    r.PKE <- Calc.result(PKE.z(as.numeric(input$holesterin),as.numeric(input$hobl),as.numeric(input$dad),actr1.ct))
    r.PXSN <- Calc.result(PXSN.z(as.numeric(input$lp),actr1.ct,as.numeric(input$kislota),as.numeric(input$kdr),as.numeric(input$chss)))
    r.NPFP <- Calc.result(NPFP.z(as.numeric(input$hsn_fk),as.numeric(input$kdr),as.numeric(input$fv),as.numeric(input$glukoza),as.numeric(input$gallektin),as.numeric(input$srb)))
    r.NPPG <- Calc.result(NPPG.z(as.numeric(input$hsn_fk),as.numeric(input$gallektin),as.numeric(input$gipoterios),as.numeric(input$glukoza),as.numeric(input$fv),as.numeric(input$vozrast),as.numeric(input$lp)))
    r.NPKE <- Calc.result(NPKE.z(as.numeric(input$chss),as.numeric(input$glukoza),as.numeric(input$lpvp),as.numeric(input$skf)))
    r.NPXSN <- Calc.result(NPXSN.z(as.numeric(input$sad),as.numeric(input$chss),as.numeric(input$nup))) 
    mResults <- c(r.PFP,r.PPG,r.PKE,r.PXSN,r.NPFP,r.NPPG,r.NPKE,r.NPXSN)
    return(mResults)
  })
  output$PFP<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[1],x[5],"PFP")
  })
  output$PPG<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[2],x[6],"PPG")
  })
  output$PKE<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[3],x[7],"PKE")
  })
  output$PXSN<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[4],x[8],"PXSN")
  })
  output$NPFP<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[5],x[1],"NPPG")
  })
  output$NPPG<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[6],x[2],"NPPG")
  })
  output$NPKE<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[7],x[3],"NPKE")
  })
  output$NPXSN<- renderUI({
    x <- dataCalculations()
    color.Comparison(x[8],x[4],"NPXSN")
  })
  observeEvent(input$SETDEFOULT, {
    updateTextInput(session, inputId = "familiya",value = "")
    updateTextInput(session, inputId = "imya",value = "")
    updateTextInput(session, inputId = "otchestvo",value = "")
    updatemmInputNum(session, inputId = "vozrast",value = 57.5)
    updatemmInputNum(session, inputId = "lp",value = 4.6)
    updatemmInputNum(session, inputId = "immlj",value = 124)
    updatemmInputNum(session, inputId = "kdr",value = 5.8)
    updatemmInputNum(session, inputId = "fv",value = 59)
    updatemmInputNum(session, inputId = "holisterin",value = 4.97)
    updatemmInputNum(session, inputId = "lpvp",value = 1.42)
    updatemmInputNum(session, inputId = "glukoza",value = 5.93)
    updatemmInputNum(session, inputId = "gallektin",value = 16.34)
    updatemmInputNum(session, inputId = "nup",value = 98.7)
    updatemmInputNum(session, inputId = "srb",value = 5.6)
    updatemmInputNum(session, inputId = "kislota",value = 234.1)
    updatemmInputNum(session, inputId = "skf",value = 70.4)
    updatemmInputNum(session, inputId = "sad",value = 152)
    updatemmInputNum(session, inputId = "dad",value = 80)
    updatemmInputNum(session, inputId = "chss",value = 73)
    updateSelectInput(session, inputId = "hsn_fk",selected = 2)
    updateSelectInput(session, inputId = "hsn_stadiya",selected = 1)
    updateCheckboxInput(session, inputId = "hobl",value =FALSE)
    updateCheckboxInput(session, inputId = "gipoterios",value =FALSE)
    updateCheckboxInput(session, inputId = "timotoksikoz",value =FALSE)
    updateCheckboxInput(session, inputId = "diabet",value =FALSE)
    updateCheckboxInput(session, inputId = "ojirenie",value =FALSE)
  })
  output$downloadData <- downloadHandler(
    filename = function() {
      paste0(as.character(input$familiya), ".xlsx")
    },
    content = function(file) {
      if(""!=input$familiya&""!=input$imya&""!=input$otchestvo){
        x <-dataCalculations()
        a <- data.frame(a = c("Фамилия","Имя","Фамилия","Возраст","","","","",""),
                        b = c(as.character(input$familiya),as.character(input$imya), as.character(input$otchestvo),input$vozrast,"","","","",""),
                        c= c("Эхо КГ:","ЛП","ИММЛЖ","КДР","ФВ","","","",""),
                        e= c("",input$lp,input$immlj,input$kdr,input$fv,"","","",""),
                        g= c("Биохимические показатели:","Общий холестирин","ЛПВП","Глюкоза","Галлектин","НУП","СРБ","Мочевая кислота","СКФ"),
                        h= c("",input$holesterin,input$lpvp,input$glukoza,input$gallektin,input$nup,input$srb,input$kislota,input$skf),
                        j= c("Гемодинамические показатели:","САД","ДАД","ЧСС","ХСН ФК","ХСН стадия","","",""),
                        k= c("",input$sad,input$dad,input$chss,input$hsn_fk,input$hsn_stadiya,"","",""),
                        m= c("Коморбидные заболевания:","ХОБЛ","Гипотериоз","Тимотоксикоз","Сахарный диабет","Абдоминальное ожирение","","",""),
                        o= c("",input$hobl,input$gipoterios,input$timotoksikoz,input$diabet,input$ojirenie,"","",""),
                        q= c("Прогноз:","","ФП","Повторная госпитализация","Кардиоэмбология","ХСН","","",""),
                        r= c("","ЭИТ",x[1],x[2],x[3],x[4],"","",""),
                        s= c("","Без ЭИТ",x[5],x[6],x[7],x[8],"","",""),
                        fix.empty.names = FALSE
        )                                                                                                                                                                             
        wb <- createWorkbook(type = "xlsx")
        sheet_data1 <- createSheet(wb, sheetName = "Data")
        addDataFrame(a, sheet_data1, startRow=1, startColumn=1)
        saveWorkbook(wb, file)
      } else {
        messageError()
      }
    }
  )
  messageError<- function(){
    session$sendCustomMessage(type = 'testmessage',
                              message = 'Не заполненны данные Ф.И.О')
  }
  color.Comparison <- function(num,num2,dev.class)
  {
    mcolor <- "red"
    number = as.numeric(num)
    number2 = as.numeric(num2)
    if(number > number2)
    {
      mcolor = "red"
    } else {
      mcolor = "green"
    }
    if((100*round(number/100,2))==100){
      number="> 99" 
    } else {
      if((100*round(number/100,2))==0){
        number="< 1"
      }
    }
    result = tagList(
      tags$style(paste0('div.',dev.class,'{color:',mcolor,';}')),
      tags$div(class = paste(as.character(dev.class)),
               tags$p(paste(number,"%")))
    )
    return(result)
  }
}

)
updatemmInputNum <- function(session, inputId, label = NULL, value = NULL, min = NULL, 
                             max = NULL, step = NULL) 
{ 
  message <- dropNulls(list(label = label, value = value, 
                            min = min, max = max, step = step)) 
  session$sendInputMessage(inputId, message) 
} 
dropNulls <- function (x) 
{ 
  x[!vapply(x, is.null, FUN.VALUE = logical(1))] 
}