RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Display_Switch\Current_Value, Current_Value, 0

loop{

Process, Exist, remoting_desktop.exe

if(ErrorLevel > 0){

RegRead, TF, HKEY_CURRENT_USER\Software\Display_Switch\Current_Value, Current_Value

if (TF = 1){
fileAppend(0)
run(1)
} else {
fileAppend(1)
run(0)
}

fileAppend(tf) { 
RegAppend(tf)
}

RegAppend(tf) {
RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Display_Switch\Current_Value, Current_Value, %tf%
}

run(command){
if (command = 1){
run, %comspec% /c %windir%\System32\DisplaySwitch.exe /internal,,hide
} else if (command = 0) {
run, %comspec% /c %windir%\System32\DisplaySwitch.exe /extend,,hide
}
}
}
sleep 750
}