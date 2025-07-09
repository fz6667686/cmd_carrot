#NoEnv
#SingleInstance, Force
SetBatchLines, -1

; Создаем GUI для командной строки
Gui, Add, Edit, vUserInput w400 r1, Введите команду...
Gui, Add, Button, Default gExecuteCommand, Выполнить
Gui, Add, ListBox, vOutput w400 r10, Результат выполнения команд:
Gui, Show,, AHK Командная строка
return

ExecuteCommand:
    Gui, Submit, NoHide
    GuiControl,, UserInput  ; Очищаем поле ввода
    
    ; Добавляем ввод пользователя в историю
    GuiControl,, Output, % "> " . UserInput . "||"
    
    ; Обрабатываем команды
    if (UserInput = "help") {
        GuiControl,, Output, % "Доступные команды: help, time, exit, calc X+Y||"
    }
    else if (UserInput = "time") {
        FormatTime, CurrentTime,, HH:mm:ss
        GuiControl,, Output, % "Текущее время: " . CurrentTime . "||"
    }
    else if (UserInput = "exit") {
        ExitApp
    }
    else if (InStr(UserInput, "calc ")) {
        Expression := SubStr(UserInput, 6)
        try {
            Result := eval(Expression)
            GuiControl,, Output, % Expression . " = " . Result . "||"
        }
        catch {
            GuiControl,, Output, % "Ошибка вычисления: " . Expression . "||"
        }
    }
    else {
        GuiControl,, Output, % "Неизвестная команда: " . UserInput . "||"
    }
return

GuiClose:
    ExitApp

; Простая функция вычисления (осторожно с безопасностью!)
eval(Expr) {
    return, % Expr
}