@echo off
%~dp0
set path=%~dp0


:ChoseClearType
color 0b
echo 	*****************************************************************************************
echo 	*											*
echo 	*				Select Cleanup Mode					*
echo 	*											*
echo 	*	1:Simple model.									*
echo 	*											*
echo 	*	2:Cache cleanup mode.								*
echo 	*											*
echo 	*	3:Minimalist model.(Need to rebuild Visual Studio project files)		*
echo 	*											*
echo 	*	4:Plug-in publishing model.(Will delete the source code.Careful operation)	*
echo 	*											*
echo 	*****************************************************************************************

set /p clearType=Select Cleanup Mode:

if %clearType% == 1 ( 
	goto ClearType1
) else if %clearType% == 2 ( 
	goto ClearType2
) else if %clearType% == 3 ( 
	goto ClearType3
) else if %clearType% == 4 ( 
	goto ClearType4
) else ( 
	echo *********************invalid inputs*********************
	goto ChoseClearType
)

:ClearType1
rem 简单清理模式:只清理 pdb文件和过期的Dll文件.不影响项目运行
echo 	-------------------------------------------------------------------------
echo 					Simple model
echo 	-------------------------------------------------------------------------
echo 					  files log
echo 					  ∨∨∨∨			 

set filesCount=0
set folderCount=0
for /r %path% %%s in (*.pdb) do (
   echo %%s 
   set /a filesCount+=1
   rem >> filelists.txt echo %%s
)

for /r %path% %%s in (*.dll) do (
	for /f "delims=- tokens=3" %%a in ("%%s") do (
		set "str2=%%~nxa"
		for /f "delims=. tokens=1" %%b in ("%%~nxa") do (
			echo %%s
			set /a filesCount+=1
			rem rem>> filelists.txt echo %%s
		)
	)
)

echo 					  ∧∧∧∧	
echo 					  files log
echo 	-------------------------------------------------------------------------
set /p choice=Please check the file log before operation. [Mode 1:Simple model](files: %filesCount%,folders:%folderCount% )(y.Yes n.No)
echo *********************Start Delete*********************
set filesCount2=0
set folderCount2=0
If /i %choice%==y (
	for /r %path% %%s in (*.pdb) do (
		
		del /f /s /q "%%s"
		set /a filesCount2+=1
	)
	for /r %path% %%s in (*.dll) do (
		for /f "delims=- tokens=3" %%a in ("%%s") do (
			set "str2=%%~nxa"
			for /f "delims=. tokens=1" %%b in ("%%~nxa") do (
				
				del /f /s /q "%%s"
				set /a filesCount2+=1
			)
		)
	)
) else (
    Exit
)

echo *********************Clean up the success(files: %filesCount2%/%filesCount%,folders:%folderCount2%/%folderCount% )*********************

pause
Exit


:ClearType2
rem 缓存清理模式:清理Intermediate Saved DerivedDataCache Developers 文件夹以及 pdb文件和过期的Dll文件,不影响项目运行
echo 	-------------------------------------------------------------------------
echo 					Cache cleanup mode
echo 	-------------------------------------------------------------------------
echo 					  files log
echo 					  ∨∨∨∨			 

set filesCount=0
set folderCount=0
for /r %path% %%s in (*.pdb) do (
   echo %%s 
   set /a filesCount+=1
   rem >> filelists.txt echo %%s
)

for /r %path% %%s in (*.dll) do (
	for /f "delims=- tokens=3" %%a in ("%%s") do (
		set "str2=%%~nxa"
		for /f "delims=. tokens=1" %%b in ("%%~nxa") do (
			echo %%s
			set /a filesCount+=1
			rem rem>> filelists.txt echo %%s
		)
	)
)


rem 将要删除的文件夹.
set folders=Intermediate Saved DerivedDataCache Developers

for /f "delims=" %%i in ('dir/ad/b/s %~d0') do (
	for %%f in (%folders%) do ( 
		if %%f equ %%~ni (
			echo %%i
			set /a folderCount+=1
			rem echo %%i>>filelists.txt
			rem echo %%~ni>>filelists.txt
		)
	)
)

echo 					  ∧∧∧∧	
echo 					  files log
echo 	-------------------------------------------------------------------------
set /p choice=Please check the file log before operation. [Mode 2:Cache cleanup mode](files: %filesCount%,folders:%folderCount% )(y.Yes n.No)
echo *********************Start Delete*********************
set filesCount2=0
set folderCount2=0
If /i %choice%==y (
	for /r %path% %%s in (*.pdb) do (
		
		del /f /s /q "%%s"
		set /a filesCount2+=1
	)
	for /r %path% %%s in (*.dll) do (
		for /f "delims=- tokens=3" %%a in ("%%s") do (
			set "str2=%%~nxa"
			for /f "delims=. tokens=1" %%b in ("%%~nxa") do (
				
				del /f /s /q "%%s"
				set /a filesCount2+=1
			)
		)
	)
	for /f "delims=" %%i in ('dir/ad/b/s %~d0') do (
		for %%f in (%folders%) do ( 
			if %%f equ %%~ni (
				echo %%i
				rd/s/q "%%i"
				set /a folderCount2+=1
				rem echo %%~ni>>filelists.txt
			)
		)
	)
) else (
    Exit
)

echo *********************Clean up the success(files: %filesCount2%/%filesCount%,folders:%folderCount2%/%folderCount% )*********************

pause
Exit



:ClearType3
rem 极简模式:只保留项目必须的文件.
echo 	-------------------------------------------------------------------------
echo 					Minimalist model
echo 	-------------------------------------------------------------------------
echo 					  files log
echo 					  ∨∨∨∨			 

set filesCount=0
set folderCount=0


rem 将要删除的文件夹.
set folders=Binaries Intermediate DerivedDataCache Saved Script Developers

for /f "delims=" %%i in ('dir/ad/b/s %~d0') do (
	for %%f in (%folders%) do ( 
		if %%f equ %%~ni (
			echo %%i
			set /a folderCount+=1
			rem echo %%i>>filelists.txt
			rem echo %%~ni>>filelists.txt
		)
	)
)

echo 					  ∧∧∧∧	
echo 					  files log
echo 	-------------------------------------------------------------------------
set /p choice=Please check the file log before operation. [Mode 3:Minimalist model](files: %filesCount%,folders:%folderCount% )(y.Yes n.No)
echo *********************Start Delete*********************
set filesCount2=0
set folderCount2=0
If /i %choice%==y (

	for /f "delims=" %%i in ('dir/ad/b/s %~d0') do (
		for %%f in (%folders%) do ( 
			if %%f equ %%~ni (
				echo %%i
				rd/s/q "%%i"
				set /a folderCount2+=1
				rem echo %%~ni>>filelists.txt
			)
		)
	)
) else (
    Exit
)

echo *********************Clean up the success(files: %filesCount2%/%filesCount%,folders:%folderCount2%/%folderCount% )*********************

pause
Exit


:ClearType4
rem 插件发布模式:清理Intermediate Saved DerivedDataCache Developers Source 文件夹以及 pdb文件和过期的Dll文件,不影响项目运行
echo 	-------------------------------------------------------------------------
echo 					Plug-in publishing model
echo 	-------------------------------------------------------------------------
echo 					  files log
echo 					  ∨∨∨∨			 

set filesCount=0
set folderCount=0
for /r %path% %%s in (*.pdb) do (
   echo %%s 
   set /a filesCount+=1
   rem >> filelists.txt echo %%s
)

for /r %path% %%s in (*.dll) do (
	for /f "delims=- tokens=3" %%a in ("%%s") do (
		set "str2=%%~nxa"
		for /f "delims=. tokens=1" %%b in ("%%~nxa") do (
			echo %%s
			set /a filesCount+=1
			rem rem>> filelists.txt echo %%s
		)
	)
)


rem 将要删除的文件夹.
set folders=Intermediate Saved DerivedDataCache Developers Source

for /f "delims=" %%i in ('dir/ad/b/s %~d0') do (
	for %%f in (%folders%) do ( 
		if %%f equ %%~ni (
			echo %%i
			set /a folderCount+=1
			rem echo %%i>>filelists.txt
			rem echo %%~ni>>filelists.txt
		)
	)
)

echo 					  ∧∧∧∧	
echo 					  files log
echo 	-------------------------------------------------------------------------
set /p choice=Please check the file log before operation. [Mode 4:Plug-in publishing model](files: %filesCount%,folders:%folderCount% )(Will delete the source code.Can't undo!)(y.Yes n.No)
echo *********************Start Delete*********************
set filesCount2=0
set folderCount2=0
If /i %choice%==y (
	for /r %path% %%s in (*.pdb) do (
		
		del /f /s /q "%%s"
		set /a filesCount2+=1
	)
	for /r %path% %%s in (*.dll) do (
		for /f "delims=- tokens=3" %%a in ("%%s") do (
			set "str2=%%~nxa"
			for /f "delims=. tokens=1" %%b in ("%%~nxa") do (
				
				del /f /s /q "%%s"
				set /a filesCount2+=1
			)
		)
	)
	for /f "delims=" %%i in ('dir/ad/b/s %~d0') do (
		for %%f in (%folders%) do ( 
			if %%f equ %%~ni (
				echo %%i
				rd/s/q "%%i"
				set /a folderCount2+=1
				rem echo %%~ni>>filelists.txt
			)
		)
	)
) else (
    Exit
)

echo *********************Clean up the success(files: %filesCount2%/%filesCount%,folders:%folderCount2%/%folderCount% )*********************

pause
Exit