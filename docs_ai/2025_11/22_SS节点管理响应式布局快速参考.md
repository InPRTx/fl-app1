# SS 节点管理 - 响应式布局快速参考

## 屏幕尺寸对应表

| 设备类型        | 宽度范围            | 显示模式         | 列数    | 每列宽度范围        | 卡片高度          |
|-------------|-----------------|--------------|-------|---------------|---------------|
| 📱 手机       | < 640px         | ListView     | 1     | 100%          | 自动            |
| 📱 手机横屏     | 640-800px       | GridView     | 2     | 280-380px     | 210-285px     |
| 📱 大屏手机     | 800-1000px      | GridView     | 2     | 380-480px     | 285-360px     |
| **⏺ 小平板**   | **1000-1200px** | **GridView** | **2** | **480-580px** | **360-435px** |
| 💻 平板横屏     | 1200-1280px     | GridView     | 2     | 580-620px     | 435-465px     |
| 🖥️ 24" 显示器 | 1280-1400px     | GridView     | 3     | 400-450px     | 300-337px     |
| 🖥️ 27" 显示器 | 1400-1800px     | GridView     | 3     | 450-580px     | 337-435px     |
| **🖥️ 超宽屏** | **1800-2000px** | **GridView** | **4** | **430-490px** | **322-367px** |
| 🖥️ 4K 显示器  | 2000+px         | GridView     | 4     | 490+px        | 367+px        |

## 核心断点

```dart
// 定义
static const double _tabletBreakpoint = 640; // 平板起点
static const double _desktopBreakpoint = 1280; // 桌面起点
static const double _largeDesktopBreakpoint = 1800; // 超大起点
static const double _cardMinWidth = 350; // 卡片最小宽度
```

## 列数计算规则

### 规则 1: 超大屏幕 (>= 1800px)

```
可用宽度 = 屏幕宽度 - 32
计算列数 = floor(可用宽度 / 350)

如果 计算列数 >= 4 → 显示 4 列
否则 → 降级为 3 列
```

**示例:**

- 1800px: (1800-32)/350 = 5.04 → 显示 4 列 ✅
- 2000px: (2000-32)/350 = 5.62 → 显示 4 列 ✅
- 1400px: (1400-32)/350 = 3.91 → 显示 3 列（未达4列） ✅

### 规则 2: 桌面屏幕 (1280-1799px)

```
可用宽度 = 屏幕宽度 - 32
计算列数 = floor(可用宽度 / 350)

如果 计算列数 >= 3 → 显示 3 列
否则 → 降级为 2 列
```

**示例:**

- 1280px: (1280-32)/350 = 3.57 → 显示 3 列 ✅
- 1050px: (1050-32)/350 = 2.91 → 显示 2 列（不足3列） ✅
- 1400px: (1400-32)/350 = 3.91 → 显示 3 列 ✅

### 规则 3: 平板设备 (640-1279px)

```
始终显示 2 列
```

**示例:**

- 640px: 显示 2 列 ✅
- 800px: 显示 2 列 ✅
- 1000px: 显示 2 列 ✅

### 规则 4: 移动设备 (< 640px)

```
显示 ListView 单列
```

## 实现代码

```dart
int _calculateGridCrossAxisCount(double width) {
  final double availableWidth = width - 32;

  if (width >= _largeDesktopBreakpoint) {
    final int cols = (availableWidth / _cardMinWidth).floor();
    return cols >= 4 ? 4 : 3;
  } else if (width >= _desktopBreakpoint) {
    final int cols = (availableWidth / _cardMinWidth).floor();
    return cols >= 3 ? 3 : 2;
  } else {
    return 2;
  }
}
```

## 使用方式

```dart
if (isTablet) {
final int crossAxisCount = _calculateGridCrossAxisCount(width);
// GridView 使用 crossAxisCount
} else {
// ListView 用于移动设备
}
```

## 边界情况处理

| 屏幕宽度   | 场景              | 计算结果           | 处理         |
|--------|-----------------|----------------|------------|
| 1050px | desktop 范围但宽度不足 | (1018/350)=2.9 | 显示 2 列 ✅   |
| 1750px | 接近但未达超大         | (1718/350)=4.9 | 显示 3 列 ✅   |
| 1800px | 刚好超大            | (1768/350)=5.0 | 显示 4 列 ✅   |
| 640px  | 平板边界            | 固定返回 2         | 显示 2 列 ✅   |
| 639px  | 刚好是移动           | 不计算            | ListView ✅ |

## 调试技巧

### 1. 查看当前列数

```dart
print
('Width: 
$width, Columns: ${_calculateGridCrossAxisCount(width)}');
```

### 2. 测试不同宽度

```dart
// 在 Flutter DevTools 中调整窗口宽度查看效果
// 或使用设备模拟器的旋转功能
```

### 3. 验证卡片宽度

```dart
// 期望卡片宽度 = (屏幕宽度 - 32 - 间距) / 列数
// 1800px: (1768 - 12) / 4 = 438.5px (符合) ✅
// 1050px: (1018 - 12) / 2 = 503px (符合) ✅
```

## 常见问题

### Q1: 为什么 1050px 不显示 3 列？

A: 因为 (1050-32)/350 = 2.9，不足 3 列的最低要求。显示 3 列会让卡片宽度只有 ~319px，小于最小宽度 350px。

### Q2: 为什么使用 350px 作为最小宽度？

A: 卡片需要足够空间显示所有内容：

- 标题文本: ~100px
- 状态 Badge: ~80px
- 信息行: 标签 ~70px + 值可变
- 按钮区: 两个按钮各 ~160px
- 总计: 约 350px 较为合理

### Q3: 如何修改最小宽度？

A: 修改常量 `_cardMinWidth`，然后重新测试所有断点确保工作正常。

### Q4: 为什么不用百分比宽度而用 350px？

A: 固定最小宽度比例更好控制，避免屏幕太小时卡片变得无法阅读。

## 性能优化

- ✅ 计算只在 LayoutBuilder 约束变化时执行
- ✅ 列数计算是 O(1) 操作
- ✅ 无额外内存占用
- ✅ GridView 使用虚拟滚动，大列表性能良好

## 扩展建议

1. **动画效果**: 使用 `TweenAnimationBuilder` 实现列数变化的平滑过渡
2. **响应式字体**: 根据屏幕宽度动态调整卡片内文本大小
3. **触摸优化**: 在平板设备增加更大的按钮点击区域
4. **配置化**: 将所有断点值提取到配置文件

---

**最后更新**: 2025-11-22  
**版本**: v1.0

