import 'package:fl_app1/component/bought_records/bought_records_list_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LowAdminUserBoughtListPage extends StatefulWidget {
  const LowAdminUserBoughtListPage({super.key});

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
    // 延迟读取URL参数，确保GoRouter已经初始化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQueryFromUrl();
    });
  }

  void _loadQueryFromUrl() {
    final uri = GoRouterState.of(context).uri;
    final qParam = uri.queryParameters['q'];
    if (qParam != null && qParam.isNotEmpty) {
      _queryController.text = qParam;
      setState(() {
        _queryString = qParam;
      });
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                icon: Icon(_queryController.text
                    .trim()
                    .isEmpty
                    ? Icons.refresh
                    : Icons.search),
                label: Text(_queryController.text
                    .trim()
                    .isEmpty
                    ? '全部'
                    : '搜索'),
              ),
            ],
          ),
        ),
        Expanded(
          child: BoughtRecordsListComponent(
            key: ValueKey(_queryString),
            q: _queryString,
            isShowActions: false,
            isEnableUserIdNavigation: true,
          ),
        ),
      ],
    );
  }
}
