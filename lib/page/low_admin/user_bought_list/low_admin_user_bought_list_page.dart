import 'package:fl_app1/component/bought_records/bought_records_list_component.dart';
import 'package:flutter/material.dart';

class LowAdminUserBoughtListPage extends StatefulWidget {
  const LowAdminUserBoughtListPage({super.key});

  @override
  State<LowAdminUserBoughtListPage> createState() =>
      _LowAdminUserBoughtListPageState();
}

class _LowAdminUserBoughtListPageState
    extends State<LowAdminUserBoughtListPage> {
  final TextEditingController _userIdController = TextEditingController();
  int? _filterUserId;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _searchByUserId() {
    final text = _userIdController.text.trim();
    setState(() {
      _filterUserId = text.isEmpty ? null : int.tryParse(text);
    });
  }

  void _clearFilter() {
    _userIdController.clear();
    setState(() {
      _filterUserId = null;
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
                  controller: _userIdController,
                  decoration: InputDecoration(
                    labelText: '用户ID',
                    hintText: '输入用户ID搜索，留空查询所有记录',
                    prefixIcon: const Icon(Icons.person_search),
                    suffixIcon: _userIdController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _userIdController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _searchByUserId(),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _searchByUserId,
                icon: const Icon(Icons.search),
                label: const Text('搜索'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _clearFilter,
                icon: const Icon(Icons.refresh),
                label: const Text('全部'),
              ),
            ],
          ),
        ),
        Expanded(
          child: BoughtRecordsListComponent(
            key: ValueKey(_filterUserId),
            userId: _filterUserId,
            isShowActions: false,
            isEnableUserIdNavigation: true,
          ),
        ),
      ],
    );
  }
}
