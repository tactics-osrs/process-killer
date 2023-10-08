#Persistent  ; Keep this script running until the user explicitly exits it.
SetTimer, ShowProcesses, 10000  ; Run the "ShowProcesses" subroutine every 10 second (10000 ms).

Gui, Add, ListView, w500 h400 vMyListView, Process Name|Process ID  ; Create a ListView control in the GUI.
Gui, Add, Button, gCloseProcess, Close Selected Process  ; Add a button to close a process.

Gui, Show,, Process List  ; Show the GUI.
return

ShowProcesses:
GuiControl, -Redraw, MyListView  ; Temporarily disable redrawing of the ListView control for performance.

LV_Delete()  ; Clear the ListView control.

for Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
{
    LV_Add("", Process.Name, Process.ProcessId)  ; Add a row to the ListView control.
}

GuiControl, +Redraw, MyListView  ; Re-enable redrawing of the ListView control.
return

CloseProcess:
LV_GetText(ProcessName, LV_GetNext(), 1)
LV_GetText(ProcessID, LV_GetNext(), 2)
if (ProcessName) {
    Process, Exist, %ProcessName%
    if (ErrorLevel != 0) {
        Process, Close, %ProcessID%
        if (ErrorLevel = 0) {
            MsgBox The process %ProcessName% has been closed.
        }
        else {
            MsgBox The process %ProcessName% cannot be closed.
        }
    }
    else {
        IfWinExist %ProcessName%
        {
            WinClose %ProcessName%
            if ErrorLevel = 0 {
                MsgBox The window %ProcessName% has been closed.
            }
            else {
                MsgBox The window %ProcessName% cannot be closed.
            }
        }
        IfWinNotExist
        {
            MsgBox The process or window %ProcessName% does not exist.
        }
    }

return

GuiClose:  ; The user closed the GUI.
ExitApp  ; Exit the script
