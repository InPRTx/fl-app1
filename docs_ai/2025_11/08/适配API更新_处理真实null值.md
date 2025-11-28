# 适配 API 更新 - 处理真实 null 值

**日期**: 2025年11月08日  
**操作**: 适配更新后的 API，处理真实的 null 值，简化连接限速显示

## 问题描述

API 更新后，以下字段发生了变化：

1. **node_speed_limit**: 现在是 `String?` 类型，支持真实的 null 值，单位已经是 Mbps（0.01 Mbps 精度）
2. **auto_reset_day**: 现在是 `int?` 类型，支持真实的 null 值
3. **auto_reset_bandwidth**: 现在是 `String?` 类型，支持真实的 null 值

需要修改前端代码以适配这些变化。

## 修改内容

### 1. 移除连接限速的双输入框

**文件**: `/lib/component/low_admin/editable_user_old_service_card_component.dart`

#### 修改前

- 连接限速使用双输入框（人类可读 + 原始字节数）
- 需要将字节转换为 Mbps

#### 修改后

- 连接限速使用单个输入框，直接输入 Mbps
- API 已经使用 Mbps 单位，不需要转换
- 支持小数输入（如 0.01 Mbps）

**代码变化**：

```dart
// 移除 _nodeSpeedLimitHumanController
late final TextEditingController _nodeSpeedLimitRawController;

// 编辑模式：单个输入框
TextField
(
controller: _nodeSpeedLimitRawController,
decoration: const InputDecoration(
labelText: '连接限速 (Mbps)',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.speed),
helperText: '单位: Mbps，支持小数，留空为不限速',
),
keyboardType: const TextInputType.numberWithOptions(decimal: true),
enabled:
!
_isSaving
,
)
```

### 2. 处理真实的 null 值

#### 初始化 Controller

**node_speed_limit (String?)**:

```dart

final speedLimitMbps = service?.nodeSpeedLimit;
_nodeSpeedLimitRawController.text = speedLimitMbps?.toString
() ?? '
';
```

**auto_reset_day (int?)**:

```dart
_autoResetDayController.text = service?.autoResetDay?.toString
() ?? '
';
```

**auto_reset_bandwidth (String?)**:

```dart

final resetBandwidth = service?.autoResetBandwidth;if (
resetBandwidth != null && resetBandwidth.isNotEmpty) {
final bandwidthValue = num.tryParse(resetBandwidth);
if (bandwidthValue != null) {
_autoResetBandwidthHumanController.text = formatBytes(bandwidthValue.toInt());
_autoResetBandwidthRawController.text = bandwidthValue.toInt().toString();
} else {
// 清空
}
} else {
// 清空
}
```

#### 提交数据

```dart

final data = <String, dynamic>{
  // node_speed_limit: num 类型，支持小数，空值为 null
  'nodeSpeedLimit': _nodeSpeedLimitRawController.text
      .trim()
      .isEmpty
      ? null
      : num.tryParse(_nodeSpeedLimitRawController.text),

  // auto_reset_day: int 类型，空值为 null
  'autoResetDay': _autoResetDayController.text
      .trim()
      .isEmpty
      ? null
      : int.tryParse(_autoResetDayController.text),

  // auto_reset_bandwidth: int 类型，空值为 null
  'autoResetBandwidth': _autoResetBandwidthRawController.text
      .trim()
      .isEmpty
      ? null
      : int.tryParse(_autoResetBandwidthRawController.text),
};
```

### 3. 显示模式处理

#### 连接限速显示

```dart
// nodeSpeedLimit 是 String? 类型
if (service.nodeSpeedLimit != null && service.nodeSpeedLimit!.isNotEmpty)
() {
final speedLimit = num.tryParse(service.nodeSpeedLimit!);
if (speedLimit != null && speedLimit > 0) {
return _buildInfoRow(
Icons.speed,
'连接限速',
'${speedLimit.toStringAsFixed(2)} Mbps',
valueColor: Colors.blue,
);
} else {
return _buildInfoRow(
Icons.speed,
'连接限速',
'不限速',
valueColor: Colors.grey,
);
}
}()
else
_buildInfoRow(
Icons.speed,
'连接限速',
'不限速',
valueColor: Colors.
grey
,
)
```

#### 自动重置日显示

```dart
if (service.autoResetDay != null && service.autoResetDay! > 0)
_buildInfoRow(
Icons.event_repeat,
'管理员设置重置日',
'每月${service.autoResetDay}日',
valueColor: Colors.blue,
)
else
_buildInfoRow(
Icons.event_repeat,
'管理员设置重置日',
'未启用',
valueColor: Colors.grey,
)
```

#### 自动重置流量显示

```dart
// autoResetBandwidth 是 String? 类型
if (service.autoResetBandwidth != null && service.autoResetBandwidth!.isNotEmpty)
() {
final bandwidth = num.tryParse(service.autoResetBandwidth!);
if (bandwidth != null && bandwidth > 0) {
return _buildInfoRow(
Icons.autorenew,
'管理员设置自动重置流量值',
formatBytes(bandwidth.toInt()),
valueColor: Colors.blue,
);
} else {
return _buildInfoRow(
Icons.autorenew,
'管理员设置自动重置流量值',
'未设置',
valueColor: Colors.grey,
);
}
}()
else
_buildInfoRow(
Icons.autorenew,
'管理员设置自动重置流量值',
'未设置',
valueColor: Colors.
grey
,
)
```

### 4. 更新 PUT 请求

**文件**: `/lib/page/low_admin/user_detail/low_admin_user_detail_page.dart`

```dart

final body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut(
  // ...其他字段
  nodeSpeedLimit: data['nodeSpeedLimit'] as num?, // 改为 num?，支持小数
  autoResetDay: data['autoResetDay'] as int? ?? 0,
  autoResetBandwidth: data['autoResetBandwidth'] as num? ?? 0.0,
  // ...其他字段
);
```

## API 字段类型变化对比

| 字段                     | 旧类型          | 新类型             | 说明                   |
|------------------------|--------------|-----------------|----------------------|
| `node_speed_limit`     | `int?`（字节）   | `String?`（Mbps） | 单位从字节改为 Mbps，支持 null |
| `auto_reset_day`       | `int`（默认0）   | `int?`          | 支持真实的 null 值         |
| `auto_reset_bandwidth` | `num`（默认0.0） | `String?`       | 支持真实的 null 值         |

## 用户体验改进

### 连接限速

**编辑模式**：

- 旧方式：输入字节数，提示 "1073741824 字节 = 1 Mbps"
- 新方式：直接输入 Mbps，支持小数（如 10.5 Mbps）
- 更直观，更易用

**显示模式**：

- 旧方式：`1.00 Mbps (1073741824 字节)`
- 新方式：`10.50 Mbps`
- 更简洁

### 自动重置日

**编辑模式**：

- 旧提示：`每月重置流量的日期（1-31），0 为未启用`
- 新提示：`每月重置流量的日期（1-31），留空为未启用`
- 更符合直觉（留空而不是输入0）

**显示模式**：

- 旧方式：检查 `> 0`
- 新方式：检查 `!= null && > 0`
- 正确处理 null 值

### 自动重置流量

**编辑模式**：

- 留空表示未设置（null）
- 不需要输入 0

**显示模式**：

- null 或空字符串：显示"未设置"
- 0：显示"未设置"
- 大于 0：显示流量大小

## 测试建议

### 连接限速测试

1. 留空保存 → 验证后端收到 null → 前端显示"不限速"
2. 输入 "10.5" → 保存 → 验证后端收到 10.5 → 前端显示 "10.50 Mbps"
3. 输入 "0.01" → 保存 → 验证支持小数

### 自动重置日测试

1. 留空保存 → 验证后端收到 null → 前端显示"未启用"
2. 输入 "15" → 保存 → 验证后端收到 15 → 前端显示"每月15日"
3. 编辑时清空 → 保存 → 验证改为 null

### 自动重置流量测试

1. 留空保存 → 验证后端收到 null → 前端显示"未设置"
2. 输入流量值 → 保存 → 验证正确显示
3. 人类可读和原始字节数同步测试

## 相关文件

- `/lib/component/low_admin/editable_user_old_service_card_component.dart` - 旧版服务信息卡片
- `/lib/page/low_admin/user_detail/low_admin_user_detail_page.dart` - 用户详情页
- `/lib/api/models/admin_old_service.dart` - API 响应模型（自动生成）
- `/lib/api/models/web_sub_fastapi_routers_api_v_low_admin_api_user_old_service_param_model_put.dart` - PUT 请求模型（自动生成）

## 注意事项

1. **String 类型的数值字段**：需要使用 `num.tryParse()` 或 `int.tryParse()` 进行解析
2. **null 值处理**：所有可空字段都需要检查 `!= null` 和是否为空字符串
3. **默认值变化**：不再使用 0 作为"未设置"的标记，而是使用 null
4. **小数支持**：`node_speed_limit` 现在支持小数，使用 `num` 而不是 `int`
5. **显示逻辑**：null、空字符串、0 都应该显示为"未设置"或"不限速"

## 总结

这次修改主要是适配 API 的类型变化，从使用默认值（0、0.0）表示"未设置"改为使用真实的 null 值。这样更符合 RESTful API
的最佳实践，也使得前端逻辑更加清晰。同时简化了连接限速的输入方式，提升了用户体验。

