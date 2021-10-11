@ECHO OFF

REM Lloyd Alex Porter
REM StudentID: 2007666
REM Parameter to File Batch Script, for MOD003218 Operating Systems

REM Checks whether any parameters are passed,
REM controls whether program runs or not.
IF [%1]==[] (
@ECHO No arguments supplied,
@ECHO program is dependant on parameters/arguments.
EXIT /B 0
) ELSE (
GOTO function_programBeginsPartOne
)

REM Exit the program.
:function_exitProgram
@ECHO.
@ECHO Thank you for using this program.
EXIT /B 0


REM Append to File
:function_appendToFilePartOne
@ECHO.
@ECHO Appending parameters to file...
FOR /F "tokens=2" %%i IN ('date /t') DO SET dateNow=%%i
SET timeNow=%time:~0,-3%
@ECHO %dateNow%@%timeNow% - %userName%: >> %fileName%
:function_appendToFilePartTwo
IF [%1]==[] (
GOTO function_appendToFilePartThree
) ELSE (
@ECHO %1 >> %fileName%
SHIFT
GOTO function_appendToFilePartTwo
)
:function_appendToFilePartThree
@ECHO. >> %fileName%
@ECHO Successfully appended to file.
GOTO function_exitProgram


REM More Options for the User
:function_moreOptions
@ECHO.
@ECHO What would you like to do instead?
@ECHO 1) Append to File
@ECHO 2) Change Save File
@ECHO 3) Cancel
SET answerOptions=
SET /P answerOptions="#? "
IF /I "%answerOptions%" == "1" (
GOTO function_appendToFilePartOne
) ELSE IF /I "%answerOptions%" == "2" (
@ECHO.
@ECHO Choose a new file name.
GOTO function_nameOfFile
) ELSE IF /I "%answerOptions%" == "3" (
@ECHO.
GOTO function_exitProgram
) ELSE (
GOTO function_moreOptions
)


REM Ask what to do when file exists
:function_whenFileExistsPartOne
@ECHO.
@ECHO Do you want to overwrite the existing file?
@ECHO 1) Yes
@ECHO 2) More Options
@ECHO 3) Cancel
SET answerOverwrite=
SET /P answerOverwrite="#? "
IF /I "%answerOverwrite%" == "1" (
DEL %fileName%
GOTO function_writeToFilePartOne
) ELSE IF /I "%answerOverwrite%" == "2" (
GOTO function_moreOptions
) ELSE IF /I "%answerOverwrite%" == "3" (
@ECHO.
GOTO function_exitProgram
) ELSE (
GOTO function_whenFileExistsPartOne
)


REM Write each Parameter to a File
:function_writeToFilePartOne
@ECHO.
@ECHO Writing parameters to file...
FOR /F "tokens=2" %%i IN ('date /t') DO SET dateNow=%%i
SET timeNow=%time:~0,-3%
@ECHO %dateNow%@%timeNow% - %userName%: > %fileName%
:function_writeToFilePartTwo
IF [%1]==[] (
GOTO function_writeToFilePartThree
) ELSE (
@ECHO %1 >> %fileName%
SHIFT
GOTO function_writeToFilePartTwo
)
:function_writeToFilePartThree
@ECHO. >> %fileName%
@ECHO Successfully written to file.
GOTO function_exitProgram


REM Does File already exist?
:function_checkFileExistance
IF exist "%CD%\%fileName%" (
@ECHO.
@ECHO %fileName% already exists.
GOTO function_whenFileExistsPartOne
)
GOTO function_writeToFilePartOne


REM What to name the File
:function_nameOfFile
@ECHO.
@ECHO What do you want to name the file? (exclude .txt)
SET fileName=
SET /P fileName="File name: "
IF [%fileName%]==[] GOTO function_nameOfFile
SETLOCAL ENABLEDELAYEDEXPANSION
SET fileName=!fileName: =%_!
IF [%fileName%]==[] GOTO function_nameOfFile
SET fileName=%fileName%.txt
GOTO function_checkFileExistance


REM Gets the users name
:function_usersName
@ECHO.
@ECHO What is your name?
SET userName=
SET /P "userName=User: "
IF [%userName%]==[] GOTO function_usersName
SETLOCAL ENABLEDELAYEDEXPANSION
SET userName=!userName: =%_!
IF [%userName%]==[] GOTO function_usersName
GOTO function_nameOfFile


REM Beginning of the Program
:function_programBeginsPartOne
@ECHO.
@ECHO Welcome, this program saves parameters to a file.
:function_programBeginsPartTwo
@ECHO.
@ECHO Do you want to save parameters to a file?
@ECHO 1) Yes
@ECHO 2) No
SET answerSave=
SET /P answerSave="#? "
IF /I "%answerSave%" == "1" (
GOTO function_usersName
) ELSE IF /I "%answerSave%" == "2" (
GOTO function_exitProgram
) ELSE (
GOTO function_programBeginsPartTwo
)
