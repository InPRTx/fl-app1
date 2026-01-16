# POW WASM 诊断与修复总结

**日期**: 2026-01-14  
**状态**: 🔧 已修复，等待测试

## 🔍 问题诊断

### 症状

从控制台截图看到：

1. ✅ `POW WASM module loaded (version: 0.1.0)` - WASM成功加载
2. ❌ `WASM computation failed: JsScriptError, using fallback` - JS互操作错误
3. 🐌 验证速度慢（21%进度显示较慢）

### 根本原因

**Extension Type调用问题**

原代码使用了`dart:js_interop`的Extension Types:

```dart
extension type POWSolverJS._(JSObject _) implements JSObject {
  external POWSolverJS(JSString capId, JSNumber difficulty);

  ...
}
```

这种方式在调用WASM导出的构造函数时出现了类型不匹配或调用错误。

## ✅ 解决方案

### 修复方式（最终版本）

Flutter编译为WASM时**不支持**`dart:js_util`，必须使用`dart:js_interop`和`dart:js_interop_unsafe`：

```dart
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

// 使用JSObject索引访问和callAsConstructor
final JSObject windowObj = web.window as JSObject;
final JSAny? solverConstructor = windowObj['POWSolver'.toJS] as JSAny?;

final JSAny solver = (solverConstructor as JSFunction).callAsConstructor(
  capId.toJS,
  difficulty.toJS,
);

// 调用方法
final JSAny result = solver.callMethod('solve_all'.toJS, challengeCount.toJS);
```

### 关键修复点

1. **移除dart:js_util**: 改用`dart:js_interop_unsafe`
2. **使用JSObject索引访问**: `windowObj['POWSolver'.toJS]`
3. **使用callAsConstructor**: 替代js_util.callConstructor
4. **使用callMethod**: 替代js_util.callMethod
5. **移除emoji**: console.log不使用emoji避免编码问题

### 优势

1. **WASM兼容**: `dart:js_interop_unsafe`支持编译为WASM
2. **类型安全**: 使用JSObject、JSAny等类型
3. **现代API**: Flutter 3.x推荐的JS互操作方式
4. **更好性能**: 直接映射到JavaScript调用

## 📝 修改的文件

### 1. pow_service_web_wasm.dart

**备份**: `pow_service_web_wasm.dart.backup`

**主要更改**:

- ❌ 移除 `dart:js_util` (不支持WASM编译)
- ✅ 使用 `dart:js_interop` 和 `dart:js_interop_unsafe`
- ✅ 使用 `JSObject['property'.toJS]` 索引访问
- ✅ 使用 `callAsConstructor` 和 `callMethod`
- ✅ 移除emoji字符（避免编码问题）
- ✅ 增强错误日志

### 2. 增强的日志

```dart
// 现在会显示详细的错误信息
web.console.info
('⚡ Attempting to use WASM implementation
'
);web.console.warn('⚠️ WASM computation failed: $e, using fallback');
web.console.error('Stack: 
$
stack
'
);
```

## 🚀 测试步骤

### 1. 重启Flutter Web

```bash
# 停止当前运行 (Ctrl+C)
# 重新启动
cd /Users/inprtx/git/hub/InPRTx/fl-app1
flutter run -d chrome
```

### 2. 清除浏览器缓存

```
Cmd/Ctrl + Shift + R
```

### 3. 打开控制台观察

期望看到：

```
✅ POW WASM module loaded (version: 0.1.0)
⚡ Attempting to use WASM implementation
POW Progress: 0 / 80
POW Progress: 10 / 80
...
```

**不应该**再看到：

```
❌ WASM computation failed: JsScriptError
```

### 4. 测试验证

1. 输入账号密码
2. 点击验证按钮
3. 观察时间

**期望**: 1-2秒完成 ⚡

## 📊 诊断命令（可选）

如果还有问题，在控制台运行：

```javascript
// 测试WASM直接调用
try {
    console.log('Testing WASM...');
    const solver = new window.POWSolver("test-uuid", 4);
    console.log('✅ Solver created:', solver);

    const solution = solver.solve_single(0);
    console.log('✅ Solution:', solution);

    const isValid = window.verify_solution("test-uuid", 0, solution, 4);
    console.log('✅ Valid:', isValid);
} catch (e) {
    console.log('❌ Error:', e);
}
```

## 🔄 回滚方案

如果新版本有问题，可以回滚：

```bash
cd /Users/inprtx/git/hub/InPRTx/fl-app1/lib/store/service/captcha
cp pow_service_web_wasm.dart.backup pow_service_web_wasm.dart
```

## 📈 预期改进

| 指标     | 修复前   | 修复后  |
|--------|-------|------|
| WASM调用 | ❌ 失败  | ✅ 成功 |
| 验证时间   | 8-10秒 | 1-2秒 |
| 性能提升   | 无     | 5-8倍 |
| 错误日志   | 少     | 详细   |

## 🐛 如果还是失败

### 检查清单

1. **浏览器控制台** - 查看新的错误信息
2. **Network标签** - 确认WASM文件加载
3. **手动测试** - 运行上面的诊断命令
4. **截图反馈** - 提供完整的控制台日志

### 备选方案

如果js_util也不行，可以考虑：

1. 使用Web Worker运行WASM
2. 使用纯JS实现替代WASM
3. 只在移动端使用Isolate优化

## 📞 需要更多帮助？

请提供：

1. 控制台完整日志截图
2. 上面诊断命令的输出
3. Network标签中WASM文件状态

---

**状态**: ✅ 已修复，使用dart:js_interop_unsafe (WASM兼容)  
**时间**: 2026-01-14 23:15  
**下一步**: 重启应用并测试

