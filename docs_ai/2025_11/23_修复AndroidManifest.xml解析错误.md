# 修复 AndroidManifest.xml 解析错误

## 问题描述

在编译时遇到以下错误：

```
Error parsing LocalFile: '/Users/inprtx/git/hub/InPRTx/fl-app1/android/app/src/main/AndroidManifest.xml' 
Please ensure that the android manifest is a valid XML document and try again.
```

## 问题原因

在 `AndroidManifest.xml` 文件的第 9 行，XML 注释被错误地放置在 `<activity>` 标签的属性列表中间：

```xml

<activity
        android:name=".MainActivity"
        android:exported="true"
        <!-- 这里不能放注释！ -->
        android:launchMode="singleTask"
        ...>
```

**XML 规范**: 在 XML 中，注释 `<!-- -->` 不能放置在标签的属性列表中间。注释只能放在以下位置：

- 标签外部（标签之前或之后）
- 标签内容中（开始标签和结束标签之间）

## 解决方案

将注释移到 `<activity>` 标签之前：

```xml
<!-- 
使用 singleTask 而非 singleTop 的原因:
- singleTask: 确保应用在单一任务栈中运行，返回键可以在应用内导航
- 移除 taskAffinity: 避免创建新的任务栈导致返回键直接退出应用
详见: docs_ai/2025_11/23_路由系统重写修复Android返回和Web刷新问题.md
-->
<activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTask"
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize">
```

## 修复文件

- `/android/app/src/main/AndroidManifest.xml`

## 验证

修复后，XML 文件符合 XML 规范，可以正常解析和编译。

## 注意事项

在编辑 Android 配置文件时，请注意：

1. **XML 注释位置**: 注释不能放在标签属性列表中
2. **XML 格式验证**: 可以使用 IDE 的 XML 验证功能检查语法
3. **注释规范**: 虽然注释有助于说明配置用途，但必须放在正确的位置

## 时间

2025年11月23日

