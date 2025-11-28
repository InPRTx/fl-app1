# 添加 API 请求加载提示功能

## 日期

2025年11月27日

## 修改文件

- `/lib/page/low_admin/ss_node/low_admin_ss_node_page.dart`

## 功能描述

为节点管理页面添加了 API 请求时的加载提示功能，当发起 API 请求时会显示全屏加载遮罩层，提示用户当前正在进行的操作。

## 技术实现

### 1. 加载遮罩层实现

使用 `OverlayEntry` 实现全屏加载提示：

```dart
OverlayEntry? _loadingOverlay;

void _showLoadingOverlay(String message) {
  if (_loadingOverlay != null) return;
  _loadingOverlay = OverlayEntry(
    builder: (context) =>
        Container(
          color: Colors.black54,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
  );
  Overlay.of(context).insert(_loadingOverlay!);
}

void _hideLoadingOverlay() {
  _loadingOverlay?.remove();
  _loadingOverlay = null;
}
```

### 2. 应用场景

#### 2.1 删除节点

当用户确认删除节点后，显示"正在删除节点..."提示：

```dart
Future<void> _confirmDelete(SsNode node) async {
  // ...确认对话框...

  if (!mounted) return;
  _showLoadingOverlay('正在删除节点...');

  try {
    final ErrorResponse response = await _restClient.fallback
        .deleteSsNodeApiV2LowAdminApiSsNodeNodeIdDelete(nodeId: node.id!);
    if (!mounted) return;
    _hideLoadingOverlay();
    // ...处理响应...
  } catch (error) {
    if (!mounted) return;
    _hideLoadingOverlay();
    // ...错误处理...
  }
}
```

#### 2.2 创建/更新节点

在表单提交时，根据操作类型显示相应提示：

```dart
Future<void> _handleSubmit() async {
  // ...表单验证和数据准备...

  if (!mounted) return;
  _showLoadingOverlay(widget.node == null ? '正在创建节点...' : '正在更新节点...');

  try {
    ErrorResponse response;
    if (widget.node == null) {
      response = await widget.restClient.fallback
          .postSsNodeApiV2LowAdminApiSsNodePost(body: body);
    } else {
      response = await widget.restClient.fallback
          .putSsNodeApiV2LowAdminApiSsNodeNodeIdPut(
        nodeId: widget.node!.id!,
        body: body,
      );
    }

    if (!mounted) return;
    _hideLoadingOverlay();
    // ...处理响应...
  } catch (error) {
    if (!mounted) return;
    _hideLoadingOverlay();
    // ...错误处理...
  }
}
```

### 3. 资源清理

在 `dispose()` 方法中清理加载遮罩层，防止内存泄漏：

```dart
@override
void dispose() {
  _searchController.dispose();
  _hideLoadingOverlay();
  super.dispose();
}
```

## 改进点

### 用户体验

1. **明确的操作反馈**：用户发起操作后立即看到加载提示
2. **半透明遮罩**：使用 `Colors.black54` 半透明背景，既能阻止用户操作，又保持界面可见性
3. **动态提示文本**：根据不同操作显示对应的提示信息
    - 删除节点：`正在删除节点...`
    - 创建节点：`正在创建节点...`
    - 更新节点：`正在更新节点...`

### 代码质量

1. **防重复显示**：在 `_showLoadingOverlay` 中检查 `_loadingOverlay != null`，避免重复插入
2. **生命周期管理**：在组件销毁时自动清理遮罩层
3. **异步安全**：在异步操作后检查 `mounted` 状态，避免在组件已销毁时操作

## 应用的设计模式

### 单例模式

每个页面/对话框维护一个 `OverlayEntry` 实例，确保同一时间只有一个加载提示显示。

### 状态管理

- 主页面状态类 `_LowAdminSsNodePageState`：管理节点列表加载、删除操作的加载提示
- 表单对话框状态类 `_SsNodeFormDialogState`：管理创建/更新节点的加载提示

## 注意事项

1. **mounted 检查**：所有异步操作后都需要检查 `mounted` 状态
2. **遮罩层清理**：确保在所有代码路径（成功、异常）中都调用 `_hideLoadingOverlay()`
3. **用户体验**：加载提示应该在 API 请求发起时立即显示，响应后立即隐藏

## 后续优化建议

1. 可以考虑添加加载超时提示
2. 可以将加载遮罩层抽取为通用组件
3. 可以添加加载进度百分比（如果 API 支持）

