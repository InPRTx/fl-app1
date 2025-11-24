import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/component/bought_records/bought_records_list_component.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LowAdminUserBoughtListPage extends StatefulWidget {
  const LowAdminUserBoughtListPage({
    super.key,
    @QueryParam('q') this.queryParam,
  });

  final String? queryParam;

  @override
  State<LowAdminUserBoughtListPage> createState() =>
      _LowAdminUserBoughtListPageState();
}

class _LowAdminUserBoughtListPageState
    extends State<LowAdminUserBoughtListPage> {
  final TextEditingController _queryController = TextEditingController();
  String? _queryString;

  @override
  void initState() {
    super.initState();
    // 从路由参数初始化查询字符串
    if (widget.queryParam != null && widget.queryParam!.isNotEmpty) {
      _queryController.text = widget.queryParam!;
      _queryString = widget.queryParam;
    }
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _applyQuery() {
    final text = _queryController.text.trim();
    setState(() {
      _queryString = text.isEmpty ? null : text;
    });
  }

  void _showAddRecordDialog() {
    // 从查询字符串中提取 user_id
    int? userId;
    if (_queryString != null && _queryString!.contains('user_id:')) {
      final match = RegExp(r'user_id:(\d+)').firstMatch(_queryString!);
      if (match != null) {
        userId = int.tryParse(match.group(1)!);
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加购买记录'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, size: 48, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              'API 暂不支持添加购买记录功能',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            if (userId != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '用户 ID: $userId',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 搜索栏（可滚动）
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      decoration: InputDecoration(
                        labelText: '查询参数 (q)',
                        hintText: '例如: user_id:123 或留空查询所有',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _queryController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _queryController.clear();
                                  _applyQuery();
                                },
                              )
                            : null,
                        border: const OutlineInputBorder(),
                        helperText: '支持格式: user_id:123 id: shop_id:',
                      ),
                      onSubmitted: (_) => _applyQuery(),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _applyQuery,
                    icon: Icon(
                      _queryController.text.trim().isEmpty
                          ? Icons.refresh
                          : Icons.search,
                    ),
                    label: Text(
                      _queryController.text.trim().isEmpty ? '全部' : '搜索',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 购买记录列表组件
          SliverFillRemaining(
            child: BoughtRecordsListComponent(
              key: ValueKey(_queryString),
              q: _queryString,
              isShowActions: true,
              isEnableUserIdNavigation: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddRecordDialog,
        icon: const Icon(Icons.add),
        label: const Text('添加记录'),
      ),
    );
  }
}
