#!/bin/bash
# 快速发布新版本并触发 GitHub Actions 构建镜像

set -e

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Infinite Canvas 版本发布工具${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 检查是否有未提交的更改
if [[ -n $(git status -s) ]]; then
    echo -e "${RED}错误: 有未提交的更改${NC}"
    echo ""
    git status -s
    echo ""
    echo "请先提交所有更改："
    echo "  git add ."
    echo "  git commit -m 'your message'"
    exit 1
fi

# 读取当前版本
CURRENT_VERSION=$(cat VERSION | tr -d '[:space:]')
echo -e "${BLUE}当前版本: ${CURRENT_VERSION}${NC}"
echo ""

# 询问新版本号
echo -e "${YELLOW}请输入新版本号 (格式: v0.15.2)${NC}"
read -p "新版本: " NEW_VERSION

# 验证版本号格式
if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}错误: 版本号格式不正确，应该是 vX.Y.Z 格式${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}准备发布新版本:${NC}"
echo "  当前版本: ${CURRENT_VERSION}"
echo "  新版本:   ${NEW_VERSION}"
echo ""

# 确认
read -p "确认发布? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}已取消${NC}"
    exit 0
fi

echo ""
echo -e "${BLUE}开始发布流程...${NC}"
echo ""

# 1. 更新 VERSION 文件
echo -e "${GREEN}1. 更新 VERSION 文件${NC}"
echo "$NEW_VERSION" > VERSION
git add VERSION
git commit -m "chore: bump version to ${NEW_VERSION}"

# 2. 推送到 GitHub
echo -e "${GREEN}2. 推送代码到 GitHub${NC}"
git push origin main

# 3. 创建并推送标签
echo -e "${GREEN}3. 创建并推送标签${NC}"
git tag $NEW_VERSION
git push origin $NEW_VERSION

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✓ 发布完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "GitHub Actions 正在自动构建 Docker 镜像..."
echo ""
echo "查看构建进度:"
echo "  https://github.com/cnxmu/infinite_canvas/actions"
echo ""
echo "构建完成后，镜像将推送到:"
echo "  ghcr.io/cnxmu/infinite_canvas:${NEW_VERSION}"
echo "  ghcr.io/cnxmu/infinite_canvas:latest"
echo ""
echo "使用镜像:"
echo "  docker pull ghcr.io/cnxmu/infinite_canvas:latest"
echo "  docker run -d -p 3000:3000 ghcr.io/cnxmu/infinite_canvas:latest"
echo ""
