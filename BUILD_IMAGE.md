# 创建预构建镜像完整指南

本指南介绍如何创建和发布你自己的 Docker 预构建镜像到 GitHub Container Registry (GHCR)。

---

## 🎯 方式 1：GitHub Actions 自动构建（推荐）

### 优势
- ✅ 完全自动化，无需本地构建
- ✅ 支持多架构（amd64 + arm64）
- ✅ 免费使用 GitHub 资源
- ✅ 与代码仓库同步

### 前置条件

1. **启用 GitHub Actions**
   - 进入你的仓库：https://github.com/cnxmu/infinite_canvas
   - Settings → Actions → General
   - 确保 "Allow all actions and reusable workflows" 已启用

2. **配置 Packages 权限**
   - Settings → Actions → General
   - 滚动到 "Workflow permissions"
   - 选择 "Read and write permissions"
   - 勾选 "Allow GitHub Actions to create and approve pull requests"
   - 点击 Save

### 构建步骤

#### 方法 A：打 Git 标签触发构建

```bash
# 1. 进入项目目录
cd "E:\Users\cnxmu\Documents\kaifa\无限画布下游"

# 2. 确保代码已提交
git status

# 3. 创建版本标签（使用 VERSION 文件中的版本）
git tag v0.15.1

# 4. 推送标签到 GitHub
git push origin v0.15.1

# GitHub Actions 会自动开始构建！
```

#### 方法 B：手动触发构建

1. 访问 https://github.com/cnxmu/infinite_canvas/actions
2. 点击左侧 "Docker image"
3. 点击右侧 "Run workflow"
4. 选择 main 分支
5. 点击 "Run workflow"

### 查看构建进度

1. 访问 https://github.com/cnxmu/infinite_canvas/actions
2. 点击最新的 "Docker image" 工作流
3. 等待构建完成（大约 5-10 分钟）

### 构建完成后

镜像会被推送到：
```
ghcr.io/cnxmu/infinite_canvas:v0.15.1
ghcr.io/cnxmu/infinite_canvas:latest
```

### 使用你的镜像

**方式 1：docker compose**

修改 `docker-compose.yml`：
```yaml
services:
  app:
    image: ghcr.io/cnxmu/infinite_canvas:latest
    # 注释掉本地构建
    # build:
    #   context: .
    #   dockerfile: Dockerfile
```

然后运行：
```bash
docker compose pull
docker compose up -d
```

**方式 2：docker run**
```bash
docker pull ghcr.io/cnxmu/infinite_canvas:latest
docker run -d -p 3000:3000 ghcr.io/cnxmu/infinite_canvas:latest
```

---

## 🛠️ 方式 2：本地构建并推送

如果你想手动控制构建过程：

### 前置条件

1. **安装 Docker Desktop**
   - Windows: https://www.docker.com/products/docker-desktop

2. **登录 GitHub Container Registry**
   ```bash
   # 创建 GitHub Personal Access Token
   # 访问: https://github.com/settings/tokens
   # 点击 "Generate new token (classic)"
   # 勾选: write:packages, read:packages, delete:packages
   # 复制生成的 token
   
   # 使用 token 登录
   echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u cnxmu --password-stdin
   ```

### 构建步骤

#### 使用构建脚本（推荐）

**Windows 用户：**
```bash
# 运行构建脚本
build.bat

# 按提示选择是否推送到 Docker Hub（选 n）
# 然后手动推送到 GHCR
docker tag cnxmu/infinite-canvas:latest ghcr.io/cnxmu/infinite_canvas:latest
docker tag cnxmu/infinite-canvas:v0.15.1 ghcr.io/cnxmu/infinite_canvas:v0.15.1
docker push ghcr.io/cnxmu/infinite_canvas:latest
docker push ghcr.io/cnxmu/infinite_canvas:v0.15.1
```

**Linux/Mac 用户：**
```bash
# 给脚本执行权限
chmod +x build.sh

# 运行构建脚本
./build.sh

# 推送到 GHCR
docker tag cnxmu/infinite-canvas:latest ghcr.io/cnxmu/infinite_canvas:latest
docker tag cnxmu/infinite-canvas:v0.15.1 ghcr.io/cnxmu/infinite_canvas:v0.15.1
docker push ghcr.io/cnxmu/infinite_canvas:latest
docker push ghcr.io/cnxmu/infinite_canvas:v0.15.1
```

#### 手动构建命令

```bash
# 读取版本号
VERSION=$(cat VERSION)

# 构建镜像
docker build -t ghcr.io/cnxmu/infinite_canvas:${VERSION} .
docker build -t ghcr.io/cnxmu/infinite_canvas:latest .

# 推送到 GHCR
docker push ghcr.io/cnxmu/infinite_canvas:${VERSION}
docker push ghcr.io/cnxmu/infinite_canvas:latest
```

---

## 🐙 方式 3：Docker Hub（可选）

如果你也想发布到 Docker Hub：

### 前置条件

1. **注册 Docker Hub 账号**
   - 访问：https://hub.docker.com/signup

2. **本地登录**
   ```bash
   docker login
   # 输入 Docker Hub 用户名和密码
   ```

### 构建并推送

```bash
# 构建镜像
docker build -t cnxmu/infinite-canvas:v0.15.1 .
docker build -t cnxmu/infinite-canvas:latest .

# 推送到 Docker Hub
docker push cnxmu/infinite-canvas:v0.15.1
docker push cnxmu/infinite-canvas:latest
```

### 使用 Docker Hub 镜像

修改 `docker-compose.yml`：
```yaml
services:
  app:
    image: cnxmu/infinite-canvas:latest
```

---

## 📋 快速开始步骤总结

**最简单的方式（推荐新手）：**

```bash
# 1. 配置 GitHub Actions 权限（一次性）
# Settings → Actions → General → Read and write permissions

# 2. 打标签并推送
cd "E:\Users\cnxmu\Documents\kaifa\无限画布下游"
git tag v0.15.1
git push origin v0.15.1

# 3. 等待 5-10 分钟，GitHub 自动构建

# 4. 使用镜像
docker pull ghcr.io/cnxmu/infinite_canvas:latest
docker run -d -p 3000:3000 ghcr.io/cnxmu/infinite_canvas:latest
```

---

## 🔍 验证镜像

### 查看你的镜像

访问：https://github.com/cnxmu?tab=packages

你应该能看到 `infinite_canvas` 包。

### 拉取并测试

```bash
# 拉取镜像
docker pull ghcr.io/cnxmu/infinite_canvas:latest

# 查看镜像信息
docker images | grep infinite_canvas

# 运行测试
docker run -d -p 3000:3000 --name test ghcr.io/cnxmu/infinite_canvas:latest

# 访问 http://localhost:3000 测试

# 清理
docker stop test
docker rm test
```

---

## 🎯 镜像可见性设置

默认情况下，GHCR 镜像是私有的。如果你想让别人也能使用：

### 设置为公开

1. 访问：https://github.com/cnxmu?tab=packages
2. 点击 `infinite_canvas` 包
3. 点击右侧 "Package settings"
4. 滚动到 "Danger Zone"
5. 点击 "Change visibility"
6. 选择 "Public"
7. 输入包名确认

现在任何人都可以拉取你的镜像：
```bash
docker pull ghcr.io/cnxmu/infinite_canvas:latest
```

---

## 🔄 更新镜像

每次代码更新后：

### 方法 1：更新版本号
```bash
# 1. 修改 VERSION 文件
echo "v0.15.2" > VERSION

# 2. 提交更改
git add VERSION
git commit -m "chore: bump version to v0.15.2"
git push

# 3. 打标签
git tag v0.15.2
git push origin v0.15.2

# GitHub Actions 自动构建新版本
```

### 方法 2：仅更新 latest
```bash
# 1. 提交代码更改
git add .
git commit -m "feat: your changes"
git push

# 2. 手动触发构建
# 访问 https://github.com/cnxmu/infinite_canvas/actions
# 点击 "Docker image" → "Run workflow"
```

---

## 🐛 常见问题

### 1. GitHub Actions 构建失败

**检查权限**：
- Settings → Actions → General
- 确保 "Read and write permissions" 已启用

**查看错误日志**：
- Actions → 点击失败的工作流 → 查看详细日志

### 2. 镜像拉取失败（403 Forbidden）

**原因**：镜像是私有的

**解决**：
- 设置镜像为公开（见上文）
- 或者登录后拉取：
  ```bash
  echo YOUR_TOKEN | docker login ghcr.io -u cnxmu --password-stdin
  docker pull ghcr.io/cnxmu/infinite_canvas:latest
  ```

### 3. 构建时间过长

**正常情况**：
- 首次构建：5-10 分钟
- 后续构建（有缓存）：3-5 分钟

**如果超过 15 分钟**：
- 检查 Actions 日志
- 可能是网络问题，重新运行工作流

### 4. 多架构支持

默认 GitHub Actions 会构建：
- linux/amd64（Intel/AMD 处理器）
- linux/arm64（Apple Silicon、ARM 服务器）

如果只需要 amd64：
- 编辑 `.github/workflows/docker-image.yml`
- 删除 arm64 相关的 matrix 配置

---

## 📚 参考文档

- [GitHub Packages 文档](https://docs.github.com/en/packages)
- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker 多架构构建](https://docs.docker.com/build/building/multi-platform/)

---

## ✅ 推荐工作流

**开发阶段**：
```bash
# 使用本地构建
docker compose up -d --build
```

**发布版本**：
```bash
# 1. 更新版本号
echo "v1.0.0" > VERSION
git add VERSION
git commit -m "chore: release v1.0.0"

# 2. 打标签
git tag v1.0.0
git push origin main
git push origin v1.0.0

# 3. GitHub 自动构建并推送镜像
# ghcr.io/cnxmu/infinite_canvas:v1.0.0
# ghcr.io/cnxmu/infinite_canvas:latest
```

**生产部署**：
```yaml
# docker-compose.yml
services:
  app:
    image: ghcr.io/cnxmu/infinite_canvas:v1.0.0  # 使用固定版本
```

这样既保证了版本可追溯，又方便了部署管理！🚀
