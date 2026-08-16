<p align="center">
  <img src="web/public/logo.svg" width="96" alt="infinite-canvas logo">
</p>

<h1 align="center">无限画布 (Infinite Canvas)</h1>

<p align="center">
  <strong>AI 驱动的可视化创作工作台</strong>
</p>

<p align="center">
  <a href="#快速开始">快速开始</a> ·
  <a href="#核心功能">核心功能</a> ·
  <a href="#部署方案">部署方案</a> ·
  <a href="#技术架构">技术架构</a> ·
  <a href="#开发指南">开发指南</a> ·
  <a href="#贡献指南">贡献</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/React-19.2-61dafb?style=flat-square&logo=react" alt="React">
  <img src="https://img.shields.io/badge/TypeScript-5.8-3178c6?style=flat-square&logo=typescript" alt="TypeScript">
  <img src="https://img.shields.io/badge/Vite-7-646cff?style=flat-square&logo=vite" alt="Vite">
  <img src="https://img.shields.io/badge/License-MIT-f97316?style=flat-square" alt="License">
</p>

---

## 📖 简介

无限画布是一款**开源的 AI 辅助创作平台**，专为图片、视频创作和视觉方案探索设计。它将画布编排、AI 生成、参考图编辑、对话助手、提示词库和素材管理整合在同一个界面，让你可以连续迭代创作内容，构建完整的创意工作流。

### ✨ 特色

- 🎨 **无限画布** - 自由拖拽、缩放、连线，构建视觉化工作流
- 🤖 **AI 原生** - 支持文生图、图生图、视频生成、文本对话
- 🔌 **插件系统** - 动态加载远程插件，自定义画布节点类型
- 🛠️ **Canvas Agent** - 通过 MCP 协议连接 Codex/Claude，让 AI 操作画布
- 💾 **本地优先** - 数据完全存储在浏览器，无需后端服务器
- 🌐 **自定义接口** - 灵活适配各种 API 中转站和自建服务

---

## 🚀 快速开始

### 在线体验

访问 [https://huabu.aiba.hk](https://huabu.aiba.hk) 立即开始使用

### 本地运行

**前置要求**
- Node.js 18+ 或 Bun 1.0+
- 现代浏览器（Chrome、Firefox、Edge、Safari）

**安装步骤**

```bash
# 克隆仓库
git clone https://github.com/your-repo/infinite-canvas.git
cd infinite-canvas/web

# 安装依赖（使用 Bun，更快）
bun install

# 启动开发服务器
bun run dev

# 或使用 npm
npm install
npm run dev
```

访问 `http://localhost:5173` 即可开始使用。

### Docker 部署

```bash
# 克隆仓库
git clone https://github.com/your-repo/infinite-canvas.git
cd infinite-canvas

# 启动服务
docker compose up -d

# 访问 http://localhost:3000
```

---

## 🎯 核心功能

### 1. 无限画布系统

- **多画布项目管理** - 创建多个独立画布项目
- **节点系统** - 图片、文本、配置、视频、音频、分组等节点类型
- **连接系统** - 通过连线建立节点间的数据流关系
- **交互操作** - 拖拽、缩放、框选、复制粘贴、撤销重做
- **小地图导航** - 快速浏览和定位画布内容
- **背景主题** - 点阵、网格、线条等多种背景样式

### 2. AI 创作能力

**图片生成**
- 文生图 (Text-to-Image)
- 图生图 (Image-to-Image)
- 图片编辑 (Inpainting/Outpainting)
- 批量生成
- 参考图系统

**视频生成**
- 文生视频
- 图生视频
- 自定义分辨率和时长

**音频生成**
- 文字转语音 (TTS)
- 多种音色选择
- 支持多种音频格式

**文本对话**
- 流式响应
- 多模态输入（文本 + 图片）
- 上下文记忆

### 3. 画布助手 (Canvas Agent)

通过本地 Canvas Agent 连接 Codex/Claude Code，让 AI 通过自然语言操作画布：

```
你: "创建一个图片生成流程，生成一只猫"
AI: 自动创建提示词节点 → 配置节点 → 图片节点，并连接它们
```

**特性**
- MCP 协议集成
- 24+ 画布操作工具
- 自动化工作流构建
- Skill 提炼和复用

### 4. 插件系统

**官方插件**
- HTML 节点 - 渲染 HTML 内容
- Markdown 节点 - 渲染 Markdown 文档
- SVG 节点 - 渲染 SVG 图形
- 全景图节点 - 360° 全景图查看器

**自定义插件**
- 使用 TypeScript SDK 开发
- 动态加载和热更新
- 隔离的存储空间
- 完整的 React Hooks 支持

### 5. 提示词库

- 连接多个 GitHub 开源提示词项目
- 自动缓存到 IndexedDB
- 分类浏览和搜索
- 一键应用到画布

### 6. 素材管理

- 本地素材库
- 图片、视频、音频管理
- 生成历史记录
- 资源引用追踪

---

## 🏗️ 技术架构

### 前端技术栈

- **框架**: React 19.2 + TypeScript 5.8
- **构建工具**: Vite 7
- **路由**: React Router 7
- **状态管理**: Zustand 5
- **UI 组件**: Ant Design 6 + Tailwind CSS 4
- **数据查询**: TanStack Query 5
- **本地存储**: IndexedDB (localForage)
- **国际化**: i18next + react-i18next
- **动画**: motion 12

### Canvas Agent 技术栈

- **运行时**: Node.js 18+
- **语言**: TypeScript 5
- **Web 服务**: Express 5
- **MCP SDK**: @modelcontextprotocol/sdk 1.12
- **Codex SDK**: @openai/codex 0.146
- **日志**: winston 3
- **验证**: zod 3

### 架构特点

**无服务器前端**
- 纯静态部署，无需后端
- 浏览器直连 AI API
- IndexedDB 本地存储
- 资源垃圾回收机制

**本地 Agent 架构**
```
浏览器 (Web)
    ↓ HTTP/SSE
Canvas Agent (本地服务)
    ↓ stdio/MCP
Codex / Claude Code
```

**插件系统**
- 动态模块加载
- React 单例共享
- 命名空间隔离
- 类型安全的 SDK

---

## 📦 部署方案

### 方案 1: 静态托管

构建静态文件并部署到任意静态托管服务：

```bash
cd web
bun install
bun run build
# dist/ 目录即为构建产物
```

支持的平台：
- Vercel
- Netlify
- Cloudflare Pages
- GitHub Pages
- 阿里云 OSS
- 腾讯云 COS

### 方案 2: Docker

```bash
# 构建镜像
docker build -t infinite-canvas .

# 运行容器
docker run -d -p 3000:3000 infinite-canvas
```

### 方案 3: Docker Compose

```bash
# 启动
docker compose up -d

# 停止
docker compose down

# 查看日志
docker compose logs -f
```

### 环境变量配置

创建 `.env` 文件：

```env
# 基础路径（如果部署在子路径）
VITE_BASE=/

# 插件注册表 URL（自托管插件）
VITE_PLUGIN_REGISTRY_URL=https://your-domain.com/plugins.json

# 开发插件（逗号分隔的 URL）
VITE_DEV_PLUGINS=http://localhost:8080/plugin.js

# 分析工具
VITE_ANALYTICS_GA4_ID=G-XXXXXXXXXX
VITE_ANALYTICS_BAIDU_ID=xxxxxxxx
```

---

## 🛠️ 开发指南

### 项目结构

```
infinite-canvas/
├── web/                      # 前端应用
│   ├── src/
│   │   ├── components/       # 组件
│   │   │   ├── canvas/       # 画布组件
│   │   │   ├── agent/        # Agent 组件
│   │   │   ├── layout/       # 布局组件
│   │   │   └── ui/           # 基础 UI
│   │   ├── pages/            # 页面
│   │   ├── stores/           # 状态管理
│   │   ├── lib/              # 核心库
│   │   ├── services/         # API 服务
│   │   ├── hooks/            # 自定义 Hooks
│   │   ├── types/            # 类型定义
│   │   └── i18n/             # 国际化
│   ├── public/               # 静态资源
│   └── vite.config.ts        # Vite 配置
├── canvas-agent/             # Canvas Agent
│   └── src/
│       ├── server/           # HTTP/MCP 服务
│       ├── agent/            # Codex 集成
│       ├── canvas/           # 画布工具
│       └── skills/           # Skill 管理
├── plugins/                  # 插件生态
│   ├── canvas/               # 画布节点插件
│   │   ├── sdk/              # 插件 SDK
│   │   ├── html/             # HTML 插件
│   │   ├── markdown/         # Markdown 插件
│   │   └── ...
│   └── infinite-canvas/      # Codex app 插件
├── docs/                     # 文档站点
├── docker-compose.yml        # Docker Compose 配置
├── Dockerfile                # Docker 镜像配置
└── README.md                 # 项目文档
```

### 开发命令

```bash
# 前端开发
cd web
bun run dev          # 启动开发服务器
bun run build        # 构建生产版本
bun run preview      # 预览构建产物
bun run lint         # 代码检查
bun run type-check   # 类型检查

# Canvas Agent 开发
cd canvas-agent
bun run dev          # 启动开发服务器
bun run build        # 构建
bun run mcp          # 启动 MCP 服务器

# 插件开发
cd plugins/canvas/your-plugin
bun run dev          # 开发模式
bun run build        # 构建插件
```

### 开发插件

**1. 创建插件项目**

```bash
cd plugins/canvas
mkdir my-plugin
cd my-plugin
bun init
```

**2. 安装 SDK**

```bash
bun add @infinite-canvas/plugin-sdk
```

**3. 编写插件**

```typescript
// src/index.ts
import { definePlugin } from '@infinite-canvas/plugin-sdk';

export default definePlugin({
  id: 'my-plugin',
  name: 'My Plugin',
  version: '1.0.0',
  nodes: [{
    type: 'my-plugin:custom',
    title: '自定义节点',
    icon: '🎨',
    defaultSize: { width: 400, height: 300 },
    Content: ({ node, ctx }) => {
      return (
        <div>
          <h3>{node.title}</h3>
          <p>{node.metadata?.content || '空内容'}</p>
        </div>
      );
    }
  }]
});
```

**4. 构建和测试**

```bash
bun run build
# 在 web/.env 中添加
# VITE_DEV_PLUGINS=http://localhost:8080/plugin.js
```

### API 文档

详细的 API 文档请参考：
- [插件 SDK 文档](./plugins/canvas/sdk/README.md)
- [Canvas Agent API](./canvas-agent/README.md)
- [画布节点操作手册](./docs/content/docs/canvas/canvas-node-manual.mdx)

---

## 🔧 配置说明

### AI API 配置

首次使用需要配置 AI API：

1. 点击右上角 **设置图标**
2. 填入以下信息：
   - **Base URL**: API 端点地址
   - **API Key**: 你的 API 密钥
   - **模型列表**: 选择或添加模型

**支持的 API 格式**
- OpenAI 标准格式
- Gemini API
- Ark API
- 自定义脚本

### 自定义 API 调用

如果默认接口调用方式不适配你的 API，可以编写自定义脚本：

```javascript
// 图片生成脚本示例
const response = await http.post('/your-endpoint', {
  prompt: prompt,
  model: model,
  size: params.size,
  // ... 其他参数
});

// 返回格式
return {
  images: response.data.images.map(img => img.url)
};
```

### Canvas Agent 配置

**启动 Canvas Agent**

```bash
cd canvas-agent
bun run start
```

默认配置：
- 端口: 17371
- Token: 自动生成
- 监听: 127.0.0.1（仅本地）

**连接到浏览器**

1. Canvas Agent 启动后会显示连接 URL
2. 在浏览器中点击右上角 **Agent 图标**
3. 输入连接 URL 和 Token
4. 点击连接

---

## 🤝 贡献指南

欢迎所有形式的贡献！

### 如何贡献

1. **Fork 项目**
2. **创建特性分支** (`git checkout -b feature/AmazingFeature`)
3. **提交更改** (`git commit -m 'Add some AmazingFeature'`)
4. **推送到分支** (`git push origin feature/AmazingFeature`)
5. **开启 Pull Request**

### 代码规范

- 使用 TypeScript
- 遵循 ESLint 配置
- 使用 Prettier 格式化代码
- 编写清晰的 commit 信息

### 报告问题

发现 Bug 或有功能建议？请[创建 Issue](https://github.com/your-repo/infinite-canvas/issues)

---

## 📄 开源协议

本项目采用 [MIT License](LICENSE) 开源协议。

**这意味着你可以：**
- ✅ 商业使用
- ✅ 修改代码
- ✅ 分发
- ✅ 私有使用

**前提是：**
- 📝 保留版权声明
- 📝 包含许可证副本

---

## 🙏 致谢

- [React](https://react.dev/) - UI 框架
- [Vite](https://vitejs.dev/) - 构建工具
- [Ant Design](https://ant.design/) - UI 组件库
- [Zustand](https://zustand.docs.pmnd.rs/) - 状态管理
- [TanStack Query](https://tanstack.com/query) - 数据查询
- [Model Context Protocol](https://modelcontextprotocol.io/) - MCP 协议

---

## 📞 联系方式

- **官网**: [https://www.aiba.hk](https://www.aiba.hk)
- **邮箱**: support@aiba.hk
- **QQ 群**: [加入交流群](#)

---

## ⭐ Star History

如果这个项目对你有帮助，请给它一个 Star ⭐

---

<p align="center">
  Made with ❤️ by Infinite Canvas Team
</p>

<p align="center">
  Copyright © 2024 Infinite Canvas. All rights reserved.
</p>
