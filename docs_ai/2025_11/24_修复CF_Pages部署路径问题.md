# 修复 CF Pages 部署路径问题

**日期**: 2025年11月24日  
**操作**: 修复 Cloudflare Pages 部署路径访问问题并优化部署策略

## 问题描述

在 Cloudflare Pages 上访问应用时，资源文件（如 `flutter_bootstrap.js`）无法正确加载。

### 原因分析

1. 原构建配置使用 `--base-href "/v3/"`
2. CF Pages 将应用部署在根路径 `/`
3. 导致浏览器尝试从 `/v3/flutter_bootstrap.js` 加载资源
4. 但实际文件位于根路径 `/flutter_bootstrap.js`
5. 结果：404 错误，应用无法启动

## 解决方案

创建两个独立的构建版本，**CF Pages 作为默认部署**：

### 1. CF Pages 版本（base-href: /）- 默认

- 用于 Cloudflare Pages 部署
- 资源路径：`/xxx`
- 部署策略：**所有分支都推送到对应分支名**
- 示例：`main` → `main`，`feature/xxx` → `feature/xxx`

### 2. GitHub 版本（base-href: /v3/）- 仅特定分支

- 用于 GitHub Pages 部署
- 资源路径：`/v3/xxx`
- 部署策略：
    - **dev 分支**：除 main 外的所有分支都推送到这里
    - **main-base 分支**：只有 main 分支推送到这里

## 修改内容

### 工作流文件修改

文件：`.github/workflows/deploy-web.yml`

#### 1. 构建两个版本

```yaml
# CF Pages 版本（默认）
- name: Build web for CF Pages (default, with / base-href)
  run: flutter build web --release --wasm --base-href "/"

# GitHub 版本（仅特定分支需要）
- name: Build web for GitHub (with /v3/ base-href, only for dev/main-base)
  if: github.ref == 'refs/heads/main' || github.ref != 'refs/heads/main'
  run: flutter build web --release --wasm --base-href "/v3/" --output build/web-github
```

#### 2. 部署策略

**CF Pages 版本部署（所有分支）**：

```yaml
- name: Commit and push (CF Pages version)
  run: |
    cd target-repo
    # 部署到与源分支同名的分支
    git checkout -B ${{ github.ref_name }}
    git add .
    git commit -m "Deploy CF Pages from branch ${{ github.ref_name }}"
    git push -f origin ${{ github.ref_name }}
```

**GitHub 版本部署（仅 dev 和 main-base）**：

```yaml
# 非 main 分支 → dev
- name: Commit and push (GitHub version - dev branch)
  if: github.ref != 'refs/heads/main'
  run: |
    cd target-repo
    git checkout -B dev
    git add .
    git commit -m "Deploy GitHub version from branch ${{ github.ref_name }}"
    git push -f origin dev

# main 分支 → main-base
- name: Commit and push (GitHub version - main-base branch)
  if: github.ref == 'refs/heads/main'
  run: |
    cd target-repo
    git checkout -B main-base
    git add .
    git commit -m "Deploy GitHub version from main"
    git push -f origin main-base
```

## 部署流程示例

### 示例 1: 推送到 main 分支

1. ✅ 构建 CF Pages 版本（base-href: /）
2. ✅ 推送到目标仓库的 `main` 分支
3. ✅ 构建 GitHub 版本（base-href: /v3/）
4. ✅ 推送到目标仓库的 `main-base` 分支

**结果**：

- CF Pages 使用 `main` 分支（根路径）
- GitHub Pages 使用 `main-base` 分支（/v3/ 路径）

### 示例 2: 推送到 feature/test 分支

1. ✅ 构建 CF Pages 版本（base-href: /）
2. ✅ 推送到目标仓库的 `feature/test` 分支
3. ✅ 构建 GitHub 版本（base-href: /v3/）
4. ✅ 推送到目标仓库的 `dev` 分支

**结果**：

- CF Pages 可以预览 `feature/test` 分支
- GitHub Pages 的 `dev` 分支包含最新的非 main 分支代码

## 使用方法

### Cloudflare Pages 配置

1. **Production 分支**: 选择 `main`
2. **Preview branches**: 选择 `All branches` 或具体分支模式
3. **Build settings**:
    - Framework preset: `None`
    - Build command: （留空）
    - Build output directory: `/`

### GitHub Pages 配置

1. **Production**: 使用 `main-base` 分支
2. **Development**: 使用 `dev` 分支
3. 基础路径：`/v3/`

## 分支说明

### 目标仓库分支结构

| 源分支         | CF Pages 分支 | GitHub 版本分支 | 说明                       |
|-------------|-------------|-------------|--------------------------|
| main        | main        | main-base   | 生产环境                     |
| dev         | dev         | dev         | 开发环境（dev 分支自己推送）         |
| feature/xxx | feature/xxx | dev         | 功能分支（所有非 main 分支都推到 dev） |
| hotfix/yyy  | hotfix/yyy  | dev         | 修复分支（所有非 main 分支都推到 dev） |

### 访问地址

- **CF Pages Production**: `https://your-project.pages.dev/`（从 main 分支）
- **CF Pages Preview**: `https://branch-name.your-project.pages.dev/`（从对应分支）
- **GitHub Pages Production**: `https://username.github.io/v3/`（从 main-base 分支）
- **GitHub Pages Development**: `https://username.github.io/v3/`（从 dev 分支）

## 优势

1. ✅ **CF Pages 优先**：默认构建 CF Pages 版本，适配根路径部署
2. ✅ **分支隔离**：每个源分支在 CF Pages 都有独立的预览环境
3. ✅ **简化 GitHub 版本**：只维护 2 个分支（main-base 和 dev）
4. ✅ **灵活预览**：可以在 CF Pages 上预览任意功能分支
5. ✅ **减少构建**：GitHub 版本只在必要时构建（实际上总是构建，但逻辑清晰）

## 注意事项

1. ✅ CF Pages 使用原分支名，方便预览
2. ✅ GitHub 版本只有 `dev` 和 `main-base` 两个分支
3. ✅ 所有非 main 分支的代码都会合并到 `dev` 分支
4. ✅ `main` 分支的 GitHub 版本在 `main-base` 分支
5. ⚠️ 确保 CF Pages 和 GitHub Pages 项目都已正确配置分支

## 相关链接

- Cloudflare Pages 文档: https://developers.cloudflare.com/pages/
- Flutter Web 部署指南: https://docs.flutter.dev/deployment/web

