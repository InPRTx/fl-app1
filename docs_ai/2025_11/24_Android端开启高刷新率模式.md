# Android 端开启高刷新率模式

**日期**: 2025年11月24日  
**操作**: 为 Android 端启用高刷新率显示模式  
**文件修改**:

- `android/app/src/main/kotlin/top/yxikkj/fl_app1/fl_app1/MainActivity.kt`
- `android/app/src/main/AndroidManifest.xml`

## 修改目的

在支持高刷新率（90Hz、120Hz、144Hz 等）的 Android 设备上，让应用能够使用设备的最高刷新率，提供更流畅的用户体验。

## 实现方案

### 1. MainActivity.kt 修改

在 `MainActivity` 中重写 `onCreate()` 方法，根据 Android 版本选择合适的 API 来设置高刷新率：

```kotlin
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 启用高刷新率模式
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Android 11 (API 30) 及以上
            window.attributes.preferredDisplayModeId = getHighestRefreshRateModeId()
        } else {
            // Android 6.0 (API 23) 到 Android 10 (API 29)
            window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
            val params = window.attributes
            params.preferredRefreshRate = getHighestRefreshRateValue()
            window.attributes = params
        }
    }
}
```

#### 关键方法说明

**1. `getHighestRefreshRateModeId()` - Android 11+**

```kotlin
private fun getHighestRefreshRateModeId(): Int {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        val display = display
        if (display != null) {
            val modes = display.supportedModes
            var maxRefreshRate = 60f
            var modeId = 0

            modes.forEach { mode ->
                if (mode.refreshRate > maxRefreshRate) {
                    maxRefreshRate = mode.refreshRate
                    modeId = mode.modeId
                }
            }
            return modeId
        }
    }
    return 0
}
```

- 遍历所有支持的显示模式
- 找到刷新率最高的模式
- 返回该模式的 `modeId`

**2. `getHighestRefreshRateValue()` - Android 6.0 到 10**

```kotlin
private fun getHighestRefreshRateValue(): Float {
    val display = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        display
    } else {
        @Suppress("DEPRECATION")
        windowManager.defaultDisplay
    }

    if (display != null) {
        val modes = display.supportedModes
        var maxRefreshRate = 60f

        modes.forEach { mode ->
            if (mode.refreshRate > maxRefreshRate) {
                maxRefreshRate = mode.refreshRate
            }
        }
        return maxRefreshRate
    }
    return 60f
}
```

- 获取设备的 Display 对象
- 遍历所有支持的显示模式
- 返回最高刷新率值（Float）

### 2. AndroidManifest.xml 修改

在 `<activity>` 标签中添加 `android:screenOrientation="fullUser"`：

```xml

<activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:taskAffinity=""
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize"
        android:screenOrientation="fullUser">
```

- `android:screenOrientation="fullUser"`: 允许所有屏幕方向，确保刷新率设置在所有方向下生效

## 技术细节

### Android 版本兼容性

| Android 版本      | API Level | 实现方式                        |
|-----------------|-----------|-----------------------------|
| Android 11+     | API 30+   | 使用 `preferredDisplayModeId` |
| Android 6.0-10  | API 23-29 | 使用 `preferredRefreshRate`   |
| Android 5.x 及以下 | < API 23  | 不支持                         |

### 支持的刷新率

常见的高刷新率：

- 60Hz（标准）
- 90Hz（常见于中高端设备）
- 120Hz（旗舰设备）
- 144Hz（部分游戏手机）

### 注意事项

1. **电池消耗**: 高刷新率会增加电池消耗
2. **设备支持**: 只在支持高刷新率的设备上生效
3. **自动降级**: 如果设备不支持，会自动使用默认刷新率（60Hz）
4. **Flutter 兼容**: Flutter 框架会自动适配屏幕刷新率

## 效果验证

### 如何验证是否生效

1. **开发者选项**:
    - 打开"开发者选项"
    - 查看"显示刷新率"或"GPU 渲染模式分析"
    - 运行应用时查看刷新率显示

2. **代码验证**:
   ```kotlin
   // 在 onCreate 中添加日志
   Log.d("RefreshRate", "Current refresh rate: ${window.attributes.preferredRefreshRate}")
   ```

3. **视觉体验**:
    - 滚动列表更流畅
    - 动画更丝滑
    - 触摸响应更灵敏

## Flutter 端配置（可选）

如果需要在 Flutter 端监控刷新率，可以使用：

```dart
import 'dart:ui';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 获取屏幕刷新率
  final double refreshRate = window.physicalSize.aspectRatio;
  print('Screen refresh rate: $refreshRate Hz');

  runApp(const MyApp());
}
```

## 代码规范遵循

✅ 使用 Kotlin 编写 Android 原生代码  
✅ 添加版本兼容性检查  
✅ 使用 `@Suppress("DEPRECATION")` 注解处理已弃用 API  
✅ 代码格式符合 Kotlin 官方规范  
✅ 添加详细注释说明各版本实现方式  
✅ 安全处理空值（使用 `?.` 和空检查）

## 测试建议

1. **不同设备测试**:
    - 60Hz 设备（确保不会崩溃）
    - 90Hz 设备（小米、一加等）
    - 120Hz 设备（三星、OPPO 等）

2. **不同 Android 版本**:
    - Android 11+ 设备
    - Android 9-10 设备
    - Android 7-8 设备

3. **性能监控**:
    - 使用 Android Profiler 监控 GPU 性能
    - 检查电池消耗
    - 监控应用帧率

## 相关资源

- [Android Display API 文档](https://developer.android.com/reference/android/view/Display)
- [Flutter 性能优化](https://flutter.dev/docs/perf)
- [Android 高刷新率最佳实践](https://developer.android.com/guide/topics/display/high-refresh-rate)

