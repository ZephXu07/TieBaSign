@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 获取当前日期并格式化为YYYY/MM/DD
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value ^| findstr LocalDateTime') do set datetime=%%I
set "date=%datetime:~0,4%/%datetime:~4,2%/%datetime:~6,2%"

:: 定义 README.md 文件路径
set "readme=README.md"

:: 临时文件路径
set "tempfile=tempfile.tmp"

:: 删除最后一行并添加新的内容
(for /f "delims=" %%A in (%readme%) do (
    set "lastline=%%A"
    echo !lastline!
)) > "%tempfile%"

:: 删除最后一行
set "skip=1"
(for /f "delims=" %%A in (%tempfile%) do (
    if !skip! neq 0 (set "skip=0") else echo %%A
)) > "%readme%"

:: 添加新的内容
echo 5. commit %date% >> "%readme%"

:: 删除临时文件
del "%tempfile%"

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
