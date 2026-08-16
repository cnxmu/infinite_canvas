@echo off
REM 清理远程旧标签并推送新版本
setlocal enabledelayedexpansion

echo ========================================
echo   清理旧标签并发布 v1.0.0
echo ========================================
echo.

echo 步骤 1: 推送代码和新标签
echo.

REM 推送代码
git push origin main
if %errorlevel% neq 0 (
    echo 错误: 推送代码失败，请检查网络连接
    pause
    exit /b 1
)

REM 推送新标签
git push origin v1.0.0
if %errorlevel% neq 0 (
    echo 错误: 推送标签失败
    pause
    exit /b 1
)

echo.
echo 步骤 2: 删除远程旧标签
echo.

REM 删除旧标签（分批进行，避免超时）
echo 删除 v0.15.x 和 v0.14.x 标签...
git push origin --delete v0.15.1 v0.15.0 v0.14.0 2>nul

echo 删除 v0.13.x 和 v0.12.x 标签...
git push origin --delete v0.13.0 v0.12.1 v0.12.0 2>nul

echo 删除 v0.11.x 到 v0.8.x 标签...
git push origin --delete v0.11.0 v0.10.0 v0.9.0 v0.8.2 v0.8.1 v0.8.0 2>nul

echo 删除 v0.7.x 到 v0.4.x 标签...
git push origin --delete v0.7.1 v0.7.0 v0.6.0 v0.5.0 v0.4.0 2>nul

echo 删除 v0.3.x 到 v0.0.x 标签...
git push origin --delete v0.3.0 v0.2.5 v0.2.4 v0.2.3 v0.2.2 v0.2.1 v0.2.0 2>nul

echo 删除剩余旧标签...
git push origin --delete v0.1.1 v0.0.9 v0.0.8 v0.0.7 v0.0.6 v0.0.5 2>nul
git push origin --delete v0.0.4 v0.0.3 v0.0.2 v.0.1.0 2>nul

echo.
echo ========================================
echo   ✓ 发布完成！
echo ========================================
echo.
echo 新版本已发布:
echo   https://github.com/cnxmu/infinite_canvas/releases/tag/v1.0.0
echo.
echo 查看所有 Releases:
echo   https://github.com/cnxmu/infinite_canvas/releases
echo.
echo GitHub Actions 构建镜像:
echo   https://github.com/cnxmu/infinite_canvas/actions
echo.
pause
