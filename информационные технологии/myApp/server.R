library(shiny)
library(xlsx)
library(evaluate)
library(rsconnect)

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