#Persistent  ; Keep this script running until the user explicitly exits it.
SetTimer, ShowProcesses, 10000  ; Run the "ShowProcesses" subroutine every 10 second (10000 ms).

Gui, Add, ListView, w500 h400 vMyListView, Process Name|Process ID  ; Create a ListView control in the GUI.
Gui, Add, Button, gCloseProcess, Close Selected Process  ; Add a button to close a process.

Gui, Show,, Process List  ; Show the GUI.

return ; Ends the auto-execute section of the script. Any lines below this one will not be automatically executed when the script starts.

ShowProcesses:
GuiControl, -Redraw, MyListView  ; Temporarily disable redrawing of the ListView control for performance.

LV_Delete()  ; Clear the ListView control.

for Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
{
    LV_Add("", Process.Name, Process.ProcessId)  ; Add a row to the ListView control.
}

GuiControl, +Redraw, MyListView  ; Re-enable redrawing of the ListView control.

return ; Ends the auto-execute section of the script. Any lines below this one will not be automatically executed when the script starts.

; This function is used to close a process or a window
CloseProcess:
    ; Get the name of the process from the list view
    LV_GetText(ProcessName, LV_GetNext(), 1)
    ; Get the ID of the process from the list view
    LV_GetText(ProcessID, LV_GetNext(), 2)
    ; Check if the process name exists
    if (ProcessName) {
        ; Check if the process exists
        Process, Exist, %ProcessName%
        ; If the process exists
        if (ErrorLevel != 0) {
            ; Try to close the process using its ID
            Process, Close, %ProcessID%
            ; If the process was successfully closed
            if (ErrorLevel = 0) {
                MsgBox The process %ProcessName% has been closed.
            }
            ; If the process could not be closed
            else {
                MsgBox The process %ProcessName% cannot be closed.
            }
        }
        ; If the process does not exist, check if a window with that name exists
        else {
            IfWinExist %ProcessName%
            {
                ; Try to close the window
                WinClose %ProcessName%
                ; If the window was successfully closed
                if ErrorLevel = 0 {
                    MsgBox The window %ProcessName% has been closed.
                }
                ; If the window could not be closed
                else {
                    MsgBox The window %ProcessName% cannot be closed.
                }
            }
            ; If neither a process nor a window with that name exists
            IfWinNotExist
            {
                MsgBox The process or window %ProcessName% does not exist.
            }
        }
    

return  ; Ends the auto-execute section of the script. Any lines below this one will not be automatically executed when the script starts.

GuiClose:  ; This is an event that gets triggered when the user closes the GUI (Graphical User Interface).
ExitApp  ; This command exits the script. It's used here to end the script when the GUI is closed.


/*
This script is written in AutoHotkey language. 
It’s used to close a specific process or window based on its name. 
It first tries to close it as a process, and if it doesn’t exist as a process, it tries to close it as a window.
 If neither exists, it shows a message box stating that neither a process nor a window with that name exists.
*/