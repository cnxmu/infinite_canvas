# Docker 镜像使用指南

本指南介绍如何构建和使用你自己的 Infinite Canvas Docker 镜像。

## 📋 方式对比

| 方式 | 优点 | 适用场景 |
|------|------|---------|
| **本地构建** | 最简单，无需额外配置 | 本地开发和测试 |
| **Docker Hub** | 可以在任何地方拉取使用 | 生产部署，多机部署 |
| **GHCR** | 与 GitHub 仓库集成 | 开源项目，CI/CD |

---

## 🚀 方式 1：本地构建（推荐新手）

### 快速开始

```bash
# 进入项目目录
cd "E:\Users\cnxmu\Documents\kaifa\无限画布下游"

# 使用 docker compose 构建并启动
docker compose up -d --build

# 访问 http://localhost:3000
```

### 常用命令

```bash
# 查看运行状态
docker compose ps

# 查看日志
docker compose logs -f

# 停止服务
docker compose down

# 重新构建
docker compose up -d --build
```

---

## 🏗️ 方式 2：手动构建镜像

### Windows 用户

双击运行 `build.bat` 或在命令行执行：

```cmd
build.bat
```

### Linux/Mac 用户

```bash
chmod +x build.sh
./build.sh
```

### 手动构建命令

```bash
# 读取版本号
VERSION=$(cat VERSION)

# 构建镜像
docker build -t cnxmu/infinite-canvas:${VERSION} .
docker build -t cnxmu/infinite-canvas:latest .

# 查看构建的镜像
docker images | grep infinite-canvas
```

### 运行自己的镜像

```bash
# 运行容器
docker run -d \
  --name infinite-canvas \
  -p 3000:3000 \
  --restart unless-stopped \
  cnxmu/infinite-canvas:latest

# 查看日志
docker logs -f infinite-canvas

# 停止容器
docker stop infinite-canvas
docker rm infinite-canvas
```

---

## 📤 方式 3：推送到 Docker Hub（推荐生产环境）

### 前置准备

1. 注册 Docker Hub 账号：https://hub.docker.com
2. 本地登录

```bash
docker login
# 输入用户名和密码
```

### 构建并推送

```bash
# 构建镜像
docker build -t cnxmu/infinite-canvas:latest .

# 推送到 Docker Hub
docker push cnxmu/infinite-canvas:latest

# 如果需要版本号
VERSION=$(cat VERSION)
docker build -t cnxmu/infinite-canvas:${VERSION} .
docker push cnxmu/infinite-canvas:${VERSION}
```

### 在其他机器上使用

```bash
# 直接拉取并运行
docker run -d -p 3000:3000 cnxmu/infinite-canvas:latest

# 或修改 docker-compose.yml
services:
  app:
    image: cnxmu/infinite-canvas:latest
    ports:
      - "3000:3000"
```

---

## 🐙 方式 4：推送到 GitHub Container Registry

### 优势
- 与 GitHub 仓库深度集成
- 支持私有镜像
- 自动化 CI/CD

### 手动推送

```bash
# 登录 GHCR
echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u cnxmu --password-stdin

# 构建镜像
docker build -t ghcr.io/cnxmu/infinite_canvas:latest .

# 推送镜像
docker push ghcr.io/cnxmu/infinite_canvas:latest
```

### 使用 GitHub Actions 自动构建

项目已包含 `.github/workflows/docker-image.yml`，每次推送到 main 分支会自动构建并推送镜像。

**设置步骤**：

1. 进入 GitHub 仓库 → Settings → Actions → General
2. 确保启用 "Read and write permissions"
3. 推送代码即可触发自动构建

```bash
git push origin main
# GitHub Actions 会自动构建并推送到 ghcr.io/cnxmu/infinite_canvas
```

---

## 🔧 自定义配置

### 环境变量

修改 `docker-compose.yml`：

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      # Google Analytics
      ANALYTICS_GA4_ID: G-XXXXXXXXXX
      # 百度统计
      ANALYTICS_BAIDU_ID: xxxxxxxxxxxx
    ports:
      - "3000:3000"
```

### 自定义端口

```yaml
ports:
  - "8080:3000"  # 外部访问 8080，内部还是 3000
```

### 数据持久化（可选）

如果需要持久化数据：

```yaml
services:
  app:
    volumes:
      - ./data:/app/data
```

---

## 📊 镜像管理

### 查看本地镜像

```bash
docker images | grep infinite-canvas
```

### 删除旧镜像

```bash
# 删除特定镜像
docker rmi cnxmu/infinite-canvas:v1.0.0

# 清理所有未使用的镜像
docker image prune -a
```

### 查看镜像大小

```bash
docker images cnxmu/infinite-canvas
```

---

## 🐛 常见问题

### 1. 构建失败

```bash
# 清理 Docker 缓存后重试
docker builder prune -a
docker compose build --no-cache
```

### 2. 端口被占用

```bash
# 修改 docker-compose.yml 中的端口
ports:
  - "3001:3000"  # 使用 3001 端口
```

### 3. 推送到 Docker Hub 失败

```bash
# 确保已登录
docker login

# 检查镜像名称格式
# 正确: cnxmu/infinite-canvas:latest
# 错误: infinite-canvas:latest
```

### 4. 镜像太大

当前镜像大小约 50-100MB（使用多阶段构建已优化）

如需进一步优化：
- 使用 `.dockerignore` 排除不必要的文件
- 使用 Alpine 基础镜像

---

## 📚 推荐工作流

### 开发阶段
```bash
# 使用本地构建，快速迭代
docker compose up -d --build
```

### 测试阶段
```bash
# 构建特定版本
docker build -t cnxmu/infinite-canvas:test .
docker run -d -p 3000:3000 cnxmu/infinite-canvas:test
```

### 生产部署
```bash
# 推送到 Docker Hub
docker push cnxmu/infinite-canvas:v1.0.0
docker push cnxmu/infinite-canvas:latest

# 在生产服务器上
docker pull cnxmu/infinite-canvas:latest
docker compose up -d
```

---

## 🎯 总结

| 场景 | 推荐方式 | 命令 |
|------|---------|------|
| 本地开发 | docker compose | `docker compose up -d --build` |
| 生产部署 | Docker Hub | `docker pull cnxmu/infinite-canvas:latest` |
| 自动化 | GitHub Actions | 推送代码自动构建 |

选择适合你的方式即可！🚀
