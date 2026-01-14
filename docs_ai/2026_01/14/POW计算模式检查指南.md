# POW 计算模式检查指南

## 🔍 如何检查当前使用的POW计算模式

### 方法1: 浏览器控制台命令

打开浏览器开发者工具控制台，输入：

```javascript
checkPOWMode()
```

**输出示例**:

#### WASM模式（高性能）

```
🚀 当前模式: WASM (高性能)
📦 WASM版本: 0.1.0
⚡ 预期性能: ~1-2秒 (80挑战)
```

#### Dart回退模式

```
🐌 当前模式: 纯Dart (回退模式)
⏱️ 预期性能: ~8-10秒 (80挑战)
```

### 方法2: 观察控制台启动日志

**WASM成功加载**:

```
✅ POW WASM module loaded (version: 0.1.0)
```

**WASM加载失败**:

```
⚠️ POW WASM module not available, will use fallback: [错误信息]
```

### 方法3: 观察实际验证时间

- **WASM模式**: 验证80个挑战通常在 **1-2秒**
- **Dart模式**: 验证80个挑战通常在 **8-10秒**

## 🐛 故障排查

### 问题: 显示"POWSolver not found in window"

**原因**: WASM模块加载了，但函数未暴露到全局作用域

**解决**:

1. 确认 `web/index.html` 已更新（包含 `window.POWSolver = ...`）
2. 刷新页面（Ctrl/Cmd + Shift + R 强制刷新）
3. 检查控制台是否有新的错误信息

### 问题: 显示"WASM module not available"

**原因**: WASM文件未加载或加载失败

**检查清单**:

- [ ] 文件存在: `web/wasm/pow_wasm_bg.wasm`
- [ ] 文件存在: `web/wasm/pow_wasm.js`
- [ ] 浏览器支持WASM (Chrome 57+, Firefox 52+, Safari 11+)
- [ ] 检查Network标签中WASM文件是否成功加载

**解决**:

```bash
# 重新构建WASM模块
cd wasm_pow
./build.sh
cd ..

# 重启Flutter Web
flutter run -d chrome
```

### 问题: 性能没有明显提升

**检查当前模式**:

```javascript
checkPOWMode()  // 确认是否使用WASM
```

如果显示Dart模式，说明WASM未正确启用。

## 📊 性能基准

| 模式   | 80挑战耗时 | 相对性能    |
|------|--------|---------|
| WASM | 1-2秒   | 基准 (最快) |
| Dart | 8-10秒  | 4-5x 慢  |
| JS   | 12-15秒 | 6-8x 慢  |

## 🔧 手动测试WASM

在控制台直接测试WASM功能：

```javascript
// 检查WASM是否可用
if (window.POWSolver) {
    // 创建求解器
    const solver = new POWSolver("test-cap-id", 4);

    // 计算单个挑战
    const solution = solver.solve_single(0);
    console.log('Solution:', solution);

    // 验证解决方案
    const isValid = verify_solution("test-cap-id", 0, solution, 4);
    console.log('Valid:', isValid);
} else {
    console.log('POWSolver不可用');
}
```

## 📝 实时监控

### 在计算过程中观察日志

**WASM模式**:

```
⚡ Using WASM implementation for POW computation
POW Progress: 1 / 80
POW Progress: 2 / 80
...
```

**Dart模式**:

```
⚠️ WASM computation failed: Exception: POWSolver not found in window, using fallback
POW Progress: 1 / 80
POW Progress: 2 / 80
...
```

## ✅ 验证WASM正常工作

运行以下命令检查所有状态：

```javascript
// 完整检查
console.log('WASM Ready:', window.__powWasmReady);
console.log('POWSolver Available:', typeof window.POWSolver);
console.log('Mode:', checkPOWMode());

// 如果都正常，应该显示：
// WASM Ready: true
// POWSolver Available: "function"
// Mode: "WASM"
```

## 🚀 切换到WASM模式

如果当前是Dart模式，按以下步骤切换：

1. **刷新页面**（F5 或 Cmd/Ctrl + R）
2. **清除缓存刷新**（Cmd/Ctrl + Shift + R）
3. **检查控制台**是否有错误
4. **运行检查命令**：`checkPOWMode()`
5. **测试验证**：点击POW验证按钮，观察耗时

## 📞 需要帮助？

如果遇到问题：

1. 运行 `checkPOWMode()` 并截图
2. 查看控制台完整日志
3. 检查Network标签中WASM文件加载状态
4. 提供以上信息寻求帮助

---

**快速命令**:

```javascript
checkPOWMode()  // 检查当前模式
```

