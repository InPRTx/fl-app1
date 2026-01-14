# POW WASM - 快速开始

## 🚀 5分钟快速集成

### 前提条件

- ✅ Rust已安装
- ✅ wasm-pack已安装

如果没有，运行：

```bash
# 安装Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 安装wasm-pack
cargo install wasm-pack
```

### 一键构建

```bash
cd wasm_pow
./build.sh
```

### 验证集成

运行Flutter Web:

```bash
cd ..
flutter run -d chrome
```

打开浏览器控制台，应该看到：

```
✅ POW WASM module loaded
```

### 测试性能

在登录页面点击"验证"按钮，查看POW计算时间：

- **使用WASM**: ~2-3秒 ⚡
- **回退Dart**: ~8-10秒 🐌

## 📝 检查清单

- [ ] WASM模块编译成功
- [ ] `web/wasm/pow_wasm_bg.wasm` 文件存在
- [ ] `web/wasm/pow_wasm.js` 文件存在
- [ ] 浏览器控制台显示 "POW WASM module loaded"
- [ ] 验证码计算时间明显缩短

## 🐛 常见问题

### Q: 控制台显示 "using fallback"

**A**: WASM未正确加载。检查：

1. 文件是否存在于`web/wasm/`
2. 浏览器是否支持WASM
3. 检查控制台的具体错误信息

### Q: 编译失败

**A**: 确保已安装：

- Rust (rustc --version)
- wasm-pack (wasm-pack --version)

### Q: 性能没有提升

**A**:

1. 确认WASM已加载（控制台日志）
2. 使用硬件性能较好的设备
3. 使用Chrome/Edge浏览器（WASM优化最好）

## 📊 性能对比示例

### 测试环境

- CPU: Apple M1
- Browser: Chrome 120
- Challenge: 80次，难度4

### 实测结果

| 实现   | 耗时   | 提升     |
|------|------|--------|
| WASM | 2.3s | -      |
| Dart | 8.7s | 3.8x 慢 |

## ✨ 完成！

现在你的Web应用已经集成了高性能WASM POW验证码计算。

详细文档请参考 `POW_WASM集成指南.md`

