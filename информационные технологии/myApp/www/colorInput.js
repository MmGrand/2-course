function OnInputAge (event) {
    var ul = document.getElementById("Age");
    if(event.target.value<79.5 && event.target.value>63) ul.style = "color:#FFA500;"; //100%max && 50%max
    if(event.target.value<63 && event.target.value>52) ul.style = "color:black;";     //50%max && 50%min
    if(event.target.value>79.5||event.target.value<35.5) ul.style = "color:red;";     //100%max || 100%min
}
//50% 4.4–5.0; 100% 3.5–5.9
function OnInputLP (event) {
    var ul = document.getElementById("LP");
    if(event.target.value<5.9 && event.target.value>5) ul.style = "color:#FFA500;";
    if(event.target.value<5 && event.target.value>4.4) ul.style = "color:black;";
    if(event.target.value>5.9||event.target.value<3.5) ul.style = "color:red;";
     ul.step = 0.1;
}
//50% 108 – 142; 99% 57 – 199
function OnInputIMMLJ (event) {
    var ul = document.getElementById("IMMLJ");
    if(event.target.value<199 && event.target.value>142) ul.style = "color:#FFA500;";
    if(event.target.value<142 && event.target.value>108) ul.style = "color:black;";
    if(event.target.value>199||event.target.value<57) ul.style = "color:red;";
     ul.step = 2;
}
//50% 5.5 – 6.3; 100% 4.3 – 7.5
function OnInputKDR (event) {
    var ul = document.getElementById("KDR");
    if(event.target.value<7.5 && event.target.value>6.3) ul.style = "color:#FFA500;";
    if(event.target.value<5.5 && event.target.value>4.3) ul.style = "color:black;";
    if(event.target.value>7.5||event.target.value<4.3) ul.style = "color:red;";
     ul.step = 0.1;
}
//50% 55 – 65; 100%	40 – 80
function OnInputFV (event) {
    var ul = document.getElementById("FV");
    if(event.target.value<80 && event.target.value>65) ul.style = "color:#FFA500;";
    if(event.target.value<65 && event.target.value>55) ul.style = "color:black;";
    if(event.target.value>80||event.target.value<40) ul.style = "color:red;";
     ul.step = 2;
}
//50% 3.93 – 5.68; 100%	1.30 – 2.63
function OnInputOH (event) {
    var ul = document.getElementById("OH");
    if(event.target.value<2.63 && event.target.value>5.68) ul.style = "color:#FFA500;";
    if(event.target.value<5.68 && event.target.value>3.93) ul.style = "color:black;";
    if(event.target.value>2.63||event.target.value<1.3) ul.style = "color:red;";
     ul.step = 0.1;
}
//1.22 – 1.72	0.47 – 2.47
function OnInputLPVP (event) {
    var ul = document.getElementById("LPVP");
    if(event.target.value<2.47 && event.target.value>1.72) ul.style = "color:#FFA500;";
    if(event.target.value<1.72 && event.target.value>1.22) ul.style = "color:black;";
    if(event.target.value>2.47||event.target.value<0.47) ul.style = "color:red;";
     ul.step = 0.1;
}
//5.35 – 6.57	3.52 – 8.40
function OnInputGLUKOZA (event) {
    var ul = document.getElementById("GLUKOZA");
    if(event.target.value<8.40 && event.target.value>6.57) ul.style = "color:#FFA500;";
    if(event.target.value<6.57 && event.target.value>5.35) ul.style = "color:black;";
    if(event.target.value>8.40||event.target.value<3.52) ul.style = "color:red;";
     ul.step = 0.1;
}
//11.45 – 52.8	0 – 114.83
function OnInputGALLEKTIN (event) {
    var ul = document.getElementById("GALLEKTIN");
    if(event.target.value<114.83 && event.target.value>52.8) ul.style = "color:#FFA500;";
    if(event.target.value<52.8 && event.target.value>11.45) ul.style = "color:black;";
    if(event.target.value>114.83||event.target.value<0) ul.style = "color:red;";
     ul.step = 5;
}
//56.75 – 134.15	0 – 250.3
function OnInputNUP (event) {
    var ul = document.getElementById("NUP");
    if(event.target.value<250.3 && event.target.value>134.15) ul.style = "color:#FFA500;";
    if(event.target.value<134.15 && event.target.value>56.75) ul.style = "color:black;";
    if(event.target.value>250.3||event.target.value<0) ul.style = "color:red;";
     ul.step = 5;
}
//4.5 – 6.7	1.2 – 10.0
function OnInputSRB (event) {
    var ul = document.getElementById("SRB");
    if(event.target.value<10 && event.target.value>6.7) ul.style = "color:#FFA500;";
    if(event.target.value<6.7 && event.target.value>4.5) ul.style = "color:black;";
    if(event.target.value>10||event.target.value<1.2) ul.style = "color:red;";
}
//134.0 – 395.0	0 – 786.5
function OnInputMC (event) {
    var ul = document.getElementById("MK");
    if(event.target.value<786.5 && event.target.value>395) ul.style = "color:#FFA500;";
    if(event.target.value<395 && event.target.value>134) ul.style = "color:black;";
    if(event.target.value>786.5||event.target.value<0) ul.style = "color:red;";
     ul.step = 5;
}
//55.52 – 80.0	18.8 – 116.72
function OnInputSKF (event) {
    var ul = document.getElementById("SKF");
    if(event.target.value<116.72 && event.target.value>80) ul.style = "color:#FFA500;";
    if(event.target.value<80 && event.target.value>55.52) ul.style = "color:black;";
    if(event.target.value>116.72||event.target.value<18.8) ul.style = "color:red;";
}
//140.0 – 165.0	102.5 – 202.5
function OnInputSAD (event) {
    var ul = document.getElementById("SAD");
    if(event.target.value<202.5 && event.target.value>165) ul.style = "color:#FFA500;";
    if(event.target.value>202.5||event.target.value<140.0) ul.style = "color:red;";
    if(event.target.value<165 && event.target.value>102.5) ul.style = "color:black;";
}
//72.0 – 88.0	48 – 112
function OnInputDAD (event) {
    var ul = document.getElementById("DAD");
    if(event.target.value<112 && event.target.value>88.0) ul.style = "color:#FFA500;";
    if(event.target.value<88.0 && event.target.value>72.0) ul.style = "color:black;";
    if(event.target.value>112||event.target.value<48) ul.style = "color:red;";
}
//67.0 – 77.00	52 – 92
function OnInputCSS (event) {
    var ul = document.getElementById("CSS");
    if(event.target.value<92 && event.target.value>77) ul.style = "color:#FFA500;";
    if(event.target.value<77 && event.target.value>67) ul.style = "color:black;";
    if(event.target.value>92||event.target.value<52) ul.style = "color:red;";
}