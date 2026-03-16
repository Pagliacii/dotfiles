#Requires AutoHotKey v2.0
#SingleInstance Force ; Skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

;
; This function pops up the input box to ask user to enter some Unicode to input the corresponding
; character into the current input area.
;
getUnicodeFromInputBox()
{
    Sleep(10)
    Code := InputBox("Enter a Unicode", "AutoHotkey", "W320 H112")
    Send("{U+%Code%}")
}

;
; This function checks if the specified name process exists
; and returns the unique ID (HWND) of the first matching window.
;
processExist(name) {
    DetectHiddenWindows True
    existed := WinExist("ahk_exe" name)
    DetectHiddenWindows False
    Return existed
}

registerTrayMenuItems() {
    Tray := A_TrayMenu
    Tray.Insert(Tray.Default, "Edit via NeoVIM", editViaEditor)
    Tray.Insert(Tray.Default, "Edit via VSCode", editViaEditor)
    Tray.Insert(Tray.Default, "Edit via Sublime Text 3", editViaEditor)
    Tray.Insert(Tray.Default)
    Tray.Insert(Tray.Default, "Open dotfiles folder", openDotfilesFolder)
    Tray.Insert(Tray.Default)
    Tray.Default := "Edit via NeoVIM"
}

editViaEditor(ItemName, ItemPos, MyMenu) {
    FoundPos := RegExMatch(ItemName, "Edit via (.+?)$", &Matched)
    if FoundPos = 0 {
        MsgBox("Invalid menu item: " ItemName, "Warning", "O Iconx")
        return
    }
    Switch Matched[1] {
    Case "NeoVIM": runInWezterm(Format('nvim "{1}"', A_ScriptFullPath))
    Case "Sublime Text 3": Run(Format('subl "{1}"', A_ScriptFullPath), , "Hide")
    Case "VSCode": Run(Format('{1} "{2}"', getScoopAppPath("vscode", "code.cmd"), A_ScriptFullPath), , "Hide")
    Default:
        MsgBox("Unknown editor: " Matched[1], "Warning", "O Iconx")
    }
}

getScoopAppPath(AppName, ExecutableFile := "") {
    Scoop := EnvGet("SCOOP")
    if !FileExist(Scoop) {
        Scoop := "D:\Scoop"
    }
    if ExecutableFile = "" {
        ExecutableFile := AppName ".exe"
    }
    FilePath := Format("{1}\shims\{2}", Scoop, ExecutableFile)
    if FileExist(FilePath) {
        return FilePath
    }
    FilePath := Format("{1}\apps\{2}\current\bin\{3}", Scoop, AppName, ExecutableFile)
    if FileExist(FilePath) {
        return FilePath
    }
    return Format("{1}\apps\{2}\current\{3}", Scoop, AppName, ExecutableFile)
}

runInWezterm(Command := "") {
    if Command = "" {
        Run(getScoopAppPath("wezterm"), , "Hide")
    } else {
        Run(Format("{1} start -- {2}", getScoopAppPath("wezterm"), Command), , "Hide")
    }
}

openDotfilesFolder(ItemName, ItemPos, MyMenu) {
    runInWezterm(Format("nvim E:\github\Pagliacii\dotfiles"))
}

; Main
SetKeyDelay(75)
registerTrayMenuItems()

; KeyMaps
^!t::runInWezterm()
CapsLock & x::getUnicodeFromInputBox()

