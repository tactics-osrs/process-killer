# process-killer



This script is written in AutoHotkey language. It uses WMI (Windows Management Instrumentation) to close a specific process or window based on its name. It first tries to close it as a process, and if it doesn’t exist as a process, it tries to close it as a window. If neither exists, it shows a message box stating that neither a process nor a window with that name exists. It should correctly populate the list for you to select and close processes every 10 seconds (10000 ms this can be edited in the .ahk file which is easily navigated due to Comment lines on each function.)


Please note that some system processes may not be able to be closed for security reasons. 


Always be careful when closing processes as it can lead to system instability.


I've added a .EXE version of the .AHK file (compiled) so this script can be used without the need to download Auto-Hotkey.
You can download Auto-Hotkey here https://www.autohotkey.com/
