@echo off
REM 快速发布新版本并触发 GitHub Actions 构建镜像
setlocal enabledelayedexpansion

echo ========================================
echo   Infinite Canvas 版本发布工具
echo ========================================
echo.

REM 检查是否有未提交的更改
git status -s > nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 无法检查 git 状态
    pause
    exit /b 1
)

for /f %%i in ('git status -s') do (
    echo 错误: 有未提交的更改
    echo.
    git status -s
    echo.
    echo 请先提交所有更改:
    echo   git add .
    echo   git commit -m "your message"
    pause
    exit /b 1
)

REM 读取当前版本
set /p CURRENT_VERSION=<VERSION
echo 当前版本: %CURRENT_VERSION%
echo.

REM 询问新版本号
echo 请输入新版本号 (格式: v0.15.2)
set /p NEW_VERSION="新版本: "

REM 简单验证版本号格式
echo %NEW_VERSION% | findstr /r "^v[0-9]*\.[0-9]*\.[0-9]*$" >nul
if %errorlevel% neq 0 (
    echo 错误: 版本号格式不正确，应该是 vX.Y.Z 格式
    pause
    exit /b 1
)

echo.
echo 准备发布新版本:
echo   当前版本: %CURRENT_VERSION%
echo   新版本:   %NEW_VERSION%
echo.

REM 确认
set /p CONFIRM="确认发布? (y/n): "
if /i not "%CONFIRM%"=="y" (
    echo 已取消
    pause
    exit /b 0
)

echo.
echo 开始发布流程...
echo.

REM 1. 更新 VERSION 文件
echo 1. 更新 VERSION 文件
echo %NEW_VERSION%> VERSION
git add VERSION
git commit -m "chore: bump version to %NEW_VERSION%"

REM 2. 推送到 GitHub
echo 2. 推送代码到 GitHub
git push origin main

REM 3. 创建并推送标签
echo 3. 创建并推送标签
git tag %NEW_VERSION%
git push origin %NEW_VERSION%

echo.
echo ========================================
echo   ✓ 发布完成！
echo ========================================
echo.
echo GitHub Actions 正在自动构建 Docker 镜像...
echo.
echo 查看构建进度:
echo   https://github.com/cnxmu/infinite_canvas/actions
echo.
echo 构建完成后，镜像将推送到:
echo   ghcr.io/cnxmu/infinite_canvas:%NEW_VERSION%
echo   ghcr.io/cnxmu/infinite_canvas:latest
echo.
echo 使用镜像:
echo   docker pull ghcr.io/cnxmu/infinite_canvas:latest
echo   docker run -d -p 3000:3000 ghcr.io/cnxmu/infinite_canvas:latest
echo.
pause
