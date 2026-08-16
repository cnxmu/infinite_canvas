#!/bin/bash
# infinite-canvas Docker 镜像构建脚本

set -e

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  构建 Infinite Canvas Docker 镜像${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 读取版本号
VERSION=$(cat VERSION | tr -d '[:space:]')
echo -e "${GREEN}当前版本: ${VERSION}${NC}"
echo ""

# 镜像名称
IMAGE_NAME="cnxmu/infinite-canvas"

# 构建镜像
echo -e "${BLUE}开始构建镜像...${NC}"
docker build -t ${IMAGE_NAME}:${VERSION} .
docker build -t ${IMAGE_NAME}:latest .

echo ""
echo -e "${GREEN}✓ 镜像构建完成！${NC}"
echo ""
echo -e "${BLUE}镜像列表:${NC}"
docker images | grep infinite-canvas || echo "无镜像"
echo ""

# 可选：推送到 Docker Hub
read -p "是否推送到 Docker Hub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${BLUE}推送镜像到 Docker Hub...${NC}"
    docker push ${IMAGE_NAME}:${VERSION}
    docker push ${IMAGE_NAME}:latest
    echo -e "${GREEN}✓ 推送完成！${NC}"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  构建完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "使用方式:"
echo "  docker run -d -p 3000:3000 ${IMAGE_NAME}:latest"
echo "  或"
echo "  docker compose up -d"
