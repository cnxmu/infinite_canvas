# 清理旧标签并发布 v1.0.0 指南

由于从原作者仓库 fork 过来，所有旧的标签（v0.0.2 到 v0.15.1）都显示原作者的名字。

## ✅ 已完成的操作

1. ✅ 删除所有本地旧标签（34个）
2. ✅ 更新版本号为 v1.0.0
3. ✅ 创建新的 v1.0.0 标签（带详细说明）
4. ✅ 提交更改到本地仓库

## 🚀 下一步：推送到 GitHub

**等待网络恢复后，运行以下脚本：**

```cmd
push-v1.bat
```

这个脚本会：
1. 推送代码到 GitHub
2. 推送新的 v1.0.0 标签
3. 删除所有远程旧标签（v0.x.x）

## 📝 手动操作步骤（如果脚本失败）

### 步骤 1：推送代码和新标签

```bash
cd "E:\Users\cnxmu\Documents\kaifa\无限画布下游"

# 推送代码
git push origin main

# 推送新标签
git push origin v1.0.0
```

### 步骤 2：删除远程旧标签

**方式 A：使用 GitHub 网页（推荐，更稳定）**

1. 访问：https://github.com/cnxmu/infinite_canvas/tags
2. 点击每个旧标签旁边的 "..." 按钮
3. 选择 "Delete tag"
4. 确认删除

**方式 B：使用命令行（分批执行）**

```bash
# 批次 1: v0.15.x - v0.12.x
git push origin --delete v0.15.1 v0.15.0 v0.14.0 v0.13.0 v0.12.1 v0.12.0

# 批次 2: v0.11.x - v0.8.x
git push origin --delete v0.11.0 v0.10.0 v0.9.0 v0.8.2 v0.8.1 v0.8.0

# 批次 3: v0.7.x - v0.4.x
git push origin --delete v0.7.1 v0.7.0 v0.6.0 v0.5.0 v0.4.0

# 批次 4: v0.3.x - v0.2.x
git push origin --delete v0.3.0 v0.2.5 v0.2.4 v0.2.3 v0.2.2 v0.2.1 v0.2.0

# 批次 5: v0.1.x - v0.0.x
git push origin --delete v0.1.1 v0.0.9 v0.0.8 v0.0.7 v0.0.6 v0.0.5
git push origin --delete v0.0.4 v0.0.3 v0.0.2 v.0.1.0
```

## 🎯 完成后

### 查看结果

1. **Releases 页面**：https://github.com/cnxmu/infinite_canvas/releases
   - 应该只显示 v1.0.0
   - 创建者显示为你的名字（cnxmu）

2. **Tags 页面**：https://github.com/cnxmu/infinite_canvas/tags
   - 应该只显示 v1.0.0

3. **GitHub Actions**：https://github.com/cnxmu/infinite_canvas/actions
   - v1.0.0 标签会触发自动构建
   - 镜像推送到 `ghcr.io/cnxmu/infinite_canvas:v1.0.0`

### 创建 Release 说明

访问：https://github.com/cnxmu/infinite_canvas/releases/new

- Tag: v1.0.0
- Title: Release v1.0.0
- Description:

```markdown
## 🎉 首个正式版本

基于 [infinite-canvas](https://github.com/basketikun/infinite-canvas) 项目进行二次开发和定制。

### ✨ 主要特性

- **无限画布系统** - 自由拖拽、缩放、连线，构建视觉化工作流
- **AI 原生** - 支持文生图、图生图、视频生成、音频生成
- **Canvas Agent** - 通过 MCP 协议连接 Codex/Claude Code
- **插件系统** - 动态加载远程插件，自定义节点类型
- **提示词库** - 连接 GitHub 开源提示词项目
- **素材管理** - 本地素材库和生成历史

### 🔧 本版本定制内容

- 删除 GitHub 链接和版本检查功能
- 更新文档链接为 API 平台 (https://www.aiba.hk)
- 全面重写 README.md
- 替换所有镜像地址为自己的仓库
- 优化项目结构和配置

### 📦 Docker 镜像

```bash
docker pull ghcr.io/cnxmu/infinite_canvas:v1.0.0
docker run -d -p 3000:3000 ghcr.io/cnxmu/infinite_canvas:v1.0.0
```

### 📚 文档

- [README.md](https://github.com/cnxmu/infinite_canvas/blob/main/README.md)
- [DOCKER.md](https://github.com/cnxmu/infinite_canvas/blob/main/DOCKER.md)

### 🙏 致谢

感谢 [basketikun](https://github.com/basketikun) 的原始项目。
```

## 🐛 常见问题

### Q: 为什么要删除旧标签？
A: 旧标签保留了原作者的创建信息，删除后重新创建的标签才会显示你的名字。

### Q: 删除标签会影响代码吗？
A: 不会。标签只是指向特定提交的引用，删除标签不会删除代码或提交历史。

### Q: 如果删除标签失败怎么办？
A: 可以使用 GitHub 网页界面手动删除，更稳定。

### Q: v1.0.0 会触发 GitHub Actions 构建吗？
A: 会的。推送标签后会自动触发 `.github/workflows/docker-image.yml`，构建多架构 Docker 镜像。

## 📞 需要帮助？

如果遇到问题，请检查：
1. 网络连接是否正常
2. GitHub 权限是否正确配置
3. Git 用户信息是否设置：
   ```bash
   git config user.name "cnxmu"
   git config user.email "your-email@example.com"
   ```
