import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../api/models/web_sub_fastapi_routers_api_v_low_admin_api_user_bought_get_user_bought_response_result_list_data.dart';
import '../../api/rest_client.dart';
import '../../utils/auth/auth_export.dart';

class UserBoughtListPage extends StatefulWidget {
  const UserBoughtListPage({super.key});

  @override
  State<UserBoughtListPage> createState() => _UserBoughtListPageState();
}

class _UserBoughtListPageState extends State<UserBoughtListPage> {
  final TextEditingController _userIdController = TextEditingController();
  late final RestClient _restClient = createAuthenticatedClient();

  List<
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
  >
  _boughtRecords = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAllRecords();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  Future<void> _loadAllRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _restClient.fallback
        .getUserBoughtApiV2LowAdminApiUserBoughtGet(limit: 3000, userId: null);

    setState(() {
      _isLoading = false;
      if (result.isSuccess) {
        _boughtRecords = result.resultList;
        if (_boughtRecords.isEmpty) {
          _errorMessage = '暂无购买记录';
        }
      } else {
        _errorMessage = result.message;
        _boughtRecords = [];
      }
    });
  }

  Future<void> _searchByUserId() async {
    final userIdText = _userIdController.text.trim();
    if (userIdText.isEmpty) {
      _loadAllRecords();
      return;
    }

    final userId = int.tryParse(userIdText);
    if (userId == null) {
      setState(() {
        _errorMessage = '请输入有效的用户ID';
        _boughtRecords = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _restClient.fallback
        .getUserBoughtApiV2LowAdminApiUserBoughtGet(
          limit: 3000,
          userId: userId,
        );

    setState(() {
      _isLoading = false;
      if (result.isSuccess) {
        _boughtRecords = result.resultList;
        if (_boughtRecords.isEmpty) {
          _errorMessage = '该用户暂无购买记录';
        }
      } else {
        _errorMessage = result.message;
        _boughtRecords = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ShellRoute provides LowAdminLayout (menu). Return only the page content.
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
                onPressed: _isLoading ? null : _searchByUserId,
                icon: const Icon(Icons.search),
                label: const Text('搜索'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () {
                  _userIdController.clear();
                  _loadAllRecords();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('全部'),
              ),
            ],
          ),
        ),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('加载中...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _userIdController.text.isEmpty
                  ? _loadAllRecords
                  : _searchByUserId,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_boughtRecords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '暂无购买记录',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '输入用户ID搜索指定用户的购买记录',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _boughtRecords.length,
      itemBuilder: (context, index) {
        final record = _boughtRecords[index];
        return _buildBoughtCard(record);
      },
    );
  }

  Widget _buildBoughtCard(
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
    record,
  ) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final isExpired =
        record.expireAt != null && record.expireAt!.isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              record.shopName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (record.expireAt != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isExpired
                                    ? Colors.red.withValues(alpha: 0.2)
                                    : Colors.green.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isExpired ? '已过期' : '有效',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isExpired
                                      ? Colors.red[700]
                                      : Colors.green[700],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '订单ID: ${record.id}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildClickableUserIdItem(
                    context,
                    record.userId,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.shopping_bag,
                    '商品ID',
                    record.shopId.toString(),
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.attach_money,
                    '金额',
                    '¥${record.moneyAmount}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.calendar_today,
                    '购买时间',
                    dateFormat.format(record.createdAt),
                  ),
                ),
                if (record.expireAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      Icons.event,
                      '过期时间',
                      dateFormat.format(record.expireAt!),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildClickableUserIdItem(BuildContext context, int userId) {
    return InkWell(
      onTap: () {
        context.go('/low_admin/user_v2/$userId');
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '用户ID',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  userId.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.open_in_new,
                  size: 12,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
