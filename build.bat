@echo off
REM infinite-canvas Docker 镜像构建脚本 (Windows)

echo ========================================
echo   构建 Infinite Canvas Docker 镜像
echo ========================================
echo.

REM 读取版本号
set /p VERSION=<VERSION
echo 当前版本: %VERSION%
echo.

REM 镜像名称
set IMAGE_NAME=cnxmu/infinite-canvas

REM 构建镜像
echo 开始构建镜像...
docker build -t %IMAGE_NAME%:%VERSION% .
docker build -t %IMAGE_NAME%:latest .

echo.
echo ✓ 镜像构建完成！
echo.
echo 镜像列表:
docker images | findstr infinite-canvas
echo.

REM 可选：推送到 Docker Hub
set /p PUSH="是否推送到 Docker Hub? (y/n): "
if /i "%PUSH%"=="y" (
    echo 推送镜像到 Docker Hub...
    docker push %IMAGE_NAME%:%VERSION%
    docker push %IMAGE_NAME%:latest
    echo ✓ 推送完成！
)

echo.
echo ========================================
echo   构建完成！
echo ========================================
echo.
echo 使用方式:
echo   docker run -d -p 3000:3000 %IMAGE_NAME%:latest
echo   或
echo   docker compose up -d
echo.
pause
