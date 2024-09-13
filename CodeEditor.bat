@echo off
title Custom Code Editor - Create Your Own Language and Code
color 0E
:: Set colors: 0 for Black background and E for Light Yellow text

:: File paths and variables
set "appDir=%~dp0"
set "sourceFile=%~dp0App_Source.txt"
set "customLangFile=%~dp0custom_language.txt"
set "customCodeFile=%~dp0custom_code_format.txt"
set "currentFile="
set "qrCodeLink=https://github.com/Arthur398-star-of-coding/Money-management-system"

:: Welcome message
:menu
cls
echo ========================================
echo          Custom Code Editor
echo ========================================
echo 1. Write Code
echo 2. Run Code
echo 3. Open Script or Folder
echo 4. Create Custom Language Format
echo 5. Use Custom Language
echo 6. Generate Code with AI
echo 7. Exit
echo ========================================
set /p option=Choose an option (1, 2, 3, 4, 5, 6, 7): 

if "%option%"=="1" goto write_code
if "%option%"=="2" goto run_code
if "%option%"=="3" goto open_scripts
if "%option%"=="4" goto create_custom_language_format
if "%option%"=="5" goto use_custom_language
if "%option%"=="6" goto generate_code
if "%option%"=="7" goto exit

:: Option 1: Write code
:write_code
cls
echo Write Code
echo ---------------------------------
set /p filename=Enter filename (e.g., script.bat, code.cpp): 
set "currentFile=%appDir%%filename%"
echo Writing to %currentFile%...
echo Type your code below. When done, type 'save' to save the file.

:: Capture user input for the code
:input_loop
set /p codeLine=:
if "%codeLine%"=="save" goto save_code
echo %codeLine% >> "%currentFile%"
goto input_loop

:: Save the code to the file
:save_code
echo File saved successfully as %currentFile%.
pause
goto menu

:: Option 2: Run code
:run_code
cls
if "%currentFile%"=="" (
    echo No file selected. Please write a script first.
    pause
    goto menu
)
echo Running %currentFile%...
if "%currentFile:~-4%"==".bat" (
    call "%currentFile%"
) else if "%currentFile:~-4%"==".cpp" (
    g++ "%currentFile%" -o "%currentFile%.exe" && "%currentFile%.exe"
) else (
    echo Cannot run this file. Please use .bat or .cpp.
)
pause
goto menu

:: Option 3: Open script or folder
:open_scripts
cls
echo Open Script or Folder
echo -----------------------
set /p fileToOpen=Enter script name or folder path: 
if exist "%fileToOpen%" (
    start "" "%fileToOpen%"
    echo Opened successfully.
) else (
    echo File or folder does not exist.
)
pause
goto menu

:: Option 4: Create custom language format
:create_custom_language_format
cls
echo Create Custom Language Format
echo ------------------------------
echo Define the syntax for your custom language.
echo Example: greet -> echo Hello, World!
echo Use the format [command] -> [translation].
echo Type 'done' when finished.

if exist "%customLangFile%" del "%customLangFile%"
if exist "%customCodeFile%" del "%customCodeFile%"

:: Input custom language definitions
:custom_format_input
set /p customFormat=Enter custom command format:
if "%customFormat%"=="done" goto custom_format_done
echo %customFormat% >> "%customLangFile%"
goto custom_format_input

:custom_format_done
echo Custom language format saved.
pause
goto menu

:: Option 5: Use custom language
:use_custom_language
cls
if not exist "%customLangFile%" (
    echo No custom language format defined yet.
    pause
    goto menu
)
echo Using Custom Language
echo ----------------------
echo Type your code in the custom language format.
echo Type 'save' to save and run.
set /p filename=Enter filename for custom code (e.g., custom.txt): 
set "currentFile=%appDir%%filename%"
echo Writing to %currentFile%...

:custom_code_input
set /p customCode=:
if "%customCode%"=="save" goto run_custom_code
echo %customCode% >> "%currentFile%"
goto custom_code_input

:: Run custom code
:run_custom_code
cls
echo Translating and Running Custom Language Code...
for /f "tokens=*" %%i in (%customLangFile%) do (
    set "line=%%i"
    set "command=!line:~0,5!"
    set "translation=!line:~6!"
    call set "%command%"="%translation%"
)
for /f "tokens=*" %%i in (%currentFile%) do (
    call %%i
)
pause
goto menu

:: Option 6: AI-generated code
:generate_code
cls
echo AI Code Generator
echo ----------------------
echo Choose a language for AI-generated code:
echo 1. Batch
echo 2. C++
set /p langChoice=Select (1 or 2): 
if "%langChoice%"=="1" (
    echo @echo off >> "%appDir%ai_generated.bat"
    echo echo This is an AI-generated Batch script. >> "%appDir%ai_generated.bat"
    echo pause >> "%appDir%ai_generated.bat"
    set "currentFile=%appDir%ai_generated.bat"
    echo AI-generated Batch script saved as ai_generated.bat.
) else if "%langChoice%"=="2" (
    echo #include <iostream> >> "%appDir%ai_generated.cpp"
    echo using namespace std; >> "%appDir%ai_generated.cpp"
    echo int main() { cout << "AI-generated C++ code." << endl; return 0; } >> "%appDir%ai_generated.cpp"
    set "currentFile=%appDir%ai_generated.cpp"
    echo AI-generated C++ code saved as ai_generated.cpp.
)
pause
goto menu

:: Option 7: Exit
:exit
cls
echo Exiting and saving all files...
if exist "%currentFile%" echo Last edited file: %currentFile%
pause
exit /b
