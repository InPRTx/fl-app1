# GitHub Actions 自动部署 Flutter Web

## 日期

2025年11月08日

## 功能描述

创建 GitHub Actions 工作流，自动编译 Flutter Web 项目并将构建产物推送到独立的部署仓库。

## 工作流配置

### 文件位置

`.github/workflows/deploy-web.yml`

### 触发方式

#### 1. 自动触发

- 当代码推送到 `main` 分支时自动执行

#### 2. 手动触发

- 在 GitHub 仓库页面：Actions → Deploy Flutter Web → Run workflow
- 使用 "Use workflow from" 下拉框选择任意分支
- 点击 "Run workflow" 按钮执行

## 工作流程

### 步骤说明

1. **Checkout source repository**
    - 检出源代码
    - 支持手动指定分支或使用触发分支

2. **Setup Flutter**
    - 安装 Flutter SDK
    - 版本：3.35.7
    - 渠道：stable
    - 启用缓存加速构建

3. **Get dependencies**
    - 执行 `flutter pub get` 获取依赖

4. **Build web**
    - 执行 `flutter build web --release --wasm`
    - 使用 WebAssembly 渲染器
    - 生成优化的生产构建

5. **Setup SSH key**
    - 从 GitHub Secrets 读取私钥
    - 设置 SSH 密钥用于访问目标仓库
    - 添加 GitHub 到 known_hosts

6. **Clone target repository**
    - 克隆目标部署仓库 `git@github.com:MaoMoLab/fl-app1-web.git`
    - 配置 Git 用户信息

7. **Copy build files**
    - 清空目标仓库
    - 复制 `build/web/*` 所有文件到目标仓库

8. **Commit and push**
    - 添加所有更改
    - 提交信息包含分支名和 commit SHA
    - 推送到 main 或 master 分支

9. **Cleanup SSH key**
    - 清理 SSH 私钥（无论成功或失败都执行）

## GitHub Secrets 配置

### 必需的密钥

#### DEPLOY_SSH_KEY

这是用于访问目标仓库的 SSH 私钥。

**设置步骤：**

1. **生成 SSH 密钥对**
   ```bash
   ssh-keygen -t ed25519 -C "github-actions@deploy" -f ~/.ssh/deploy_key
   ```

2. **添加公钥到目标仓库**
    - 复制公钥内容：
      ```bash
      cat ~/.ssh/deploy_key.pub
      ```
    - 访问 `https://github.com/MaoMoLab/fl-app1-web`
    - Settings → Deploy keys → Add deploy key
    - 粘贴公钥内容
    - ✅ 勾选 "Allow write access"

3. **添加私钥到源仓库 Secrets**
    - 复制私钥内容：
      ```bash
      cat ~/.ssh/deploy_key
      ```
    - 访问源仓库 Settings → Secrets and variables → Actions
    - New repository secret
    - Name: `DEPLOY_SSH_KEY`
    - Value: 粘贴完整的私钥内容（包括 BEGIN 和 END 行）

## 构建配置

### Flutter 版本

- **版本**: 3.35.7
- **渠道**: stable
- **缓存**: 启用（加速后续构建）

### Web 构建选项

- **模式**: Release（生产优化）
- **渲染器**: WebAssembly (`--wasm`)
- **输出目录**: `build/web/`

## 手动执行示例

### 场景 1: 编译 main 分支

1. 进入 Actions 标签
2. 选择 "Deploy Flutter Web"
3. 点击 "Run workflow"
4. "Use workflow from" 下拉框选择：`main`
5. 点击绿色的 "Run workflow" 按钮

### 场景 2: 编译开发分支

1. 进入 Actions 标签
2. 选择 "Deploy Flutter Web"
3. 点击 "Run workflow"
4. "Use workflow from" 下拉框选择：`dev` 或 `new-featrue`
5. 点击绿色的 "Run workflow" 按钮

### 场景 3: 编译功能分支

1. 进入 Actions 标签
2. 选择 "Deploy Flutter Web"
3. 点击 "Run workflow"
4. "Use workflow from" 下拉框选择：`feature/my-new-feature`
5. 点击绿色的 "Run workflow" 按钮

## 提交信息格式

```
Deploy from branch {分支名} - commit {commit SHA}
```

**示例：**

- `Deploy from branch main - commit a1b2c3d4e5f6...`
- `Deploy from branch dev - commit 1a2b3c4d5e6f...`
- `Deploy from branch new-featrue - commit 9f8e7d6c5b4a...`

## 目标仓库

- **仓库地址**: `git@github.com:MaoMoLab/fl-app1-web.git`
- **访问方式**: SSH（使用 Deploy Key）
- **推送分支**: main 或 master（自动检测）

## 安全特性

1. **SSH 密钥管理**
    - 密钥存储在 GitHub Secrets（加密）
    - 临时写入文件系统（权限 600）
    - 执行后立即清理（`if: always()`）

2. **Git 配置**
    - 使用 GitHub Actions 机器人身份
    - 邮箱：`github-actions[bot]@users.noreply.github.com`

3. **推送保护**
    - 仅在有变更时才提交
    - 使用 `git diff --staged --quiet` 检查

## 优化建议

### 性能优化

- ✅ 启用 Flutter 缓存
- ✅ 使用 WebAssembly 渲染器（更好的性能）

### 可选改进

1. **添加构建通知**
   ```yaml
   - name: Notify on success
     if: success()
     run: echo "部署成功！"
   ```

2. **添加构建时间记录**
   ```yaml
   - name: Record build time
     run: echo "BUILD_TIME=$(date)" >> build/web/build-info.txt
   ```

3. **添加版本标记**
   ```yaml
   - name: Add version tag
     run: echo "${{ github.sha }}" > build/web/VERSION
   ```

## 故障排查

### 问题 1: SSH 认证失败

**原因**: Deploy Key 未正确配置  
**解决**:

1. 检查公钥是否添加到目标仓库
2. 确认 "Allow write access" 已勾选
3. 验证私钥格式完整（包括头尾）

### 问题 2: Flutter 构建失败

**原因**: 依赖问题或代码错误  
**解决**:

1. 本地执行 `flutter pub get`
2. 本地执行 `flutter build web --release --wasm`
3. 修复错误后再次推送

### 问题 3: 目标仓库推送失败

**原因**: 权限不足或分支保护  
**解决**:

1. 确认 Deploy Key 有写权限
2. 检查目标仓库是否有分支保护规则

### 问题 4: 分支不存在

**原因**: 手动输入了不存在的分支名  
**解决**:

1. 检查分支名拼写
2. 确认分支已推送到远程

## 监控与日志

- 所有执行日志可在 Actions 标签查看
- 每个步骤都有详细的输出
- 失败时会显示错误信息

## 文件清单

### 新增文件

- `.github/workflows/deploy-web.yml` - GitHub Actions 工作流配置

## 使用限制

- GitHub Actions 免费额度：公开仓库无限制
- 私有仓库：每月 2000 分钟免费
- 构建时间：约 3-5 分钟/次

## 最佳实践

1. ✅ 仅在 main 分支自动部署
2. ✅ 其他分支使用手动触发
3. ✅ 提交信息包含分支和 commit 信息
4. ✅ 构建前先获取最新依赖
5. ✅ 使用 WebAssembly 优化性能
6. ✅ 构建后立即清理敏感信息

## 注意事项

⚠️ **重要提醒**:

- 请勿将 SSH 私钥提交到代码仓库
- 确保目标仓库已创建并可访问
- 首次执行前请确认所有 Secrets 已配置
- WebAssembly 需要支持的浏览器（Chrome 94+, Firefox 95+, Safari 16.4+）

