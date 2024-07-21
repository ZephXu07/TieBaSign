@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 获取当前日期并格式化为YYYY/MM/DD
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value ^| findstr LocalDateTime') do set datetime=%%I
set "date=%datetime:~0,4%/%datetime:~4,2%/%datetime:~6,2%"

:: 定义要追加内容的文件路径
set "logfile=自动提交log.txt"

:: 追加日期到文件
echo %date% >> "%logfile%"

:: Git 自动提交和推送
echo 添加所有修改的文件到暂存区...
git add .

echo 提交修改到本地仓库...
git commit -m "自动提交 %date%"

echo 推送修改到远程仓库...
git push

echo 操作完成。

endlocal
pause
