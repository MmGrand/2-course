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



