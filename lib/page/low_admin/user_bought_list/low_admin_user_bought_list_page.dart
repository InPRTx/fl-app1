import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_low_admin_api_user_bought_get_user_bought_response.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_low_admin_api_user_bought_get_user_bought_response_result_list_data.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class LowAdminUserBoughtListPage extends StatefulWidget {
  const LowAdminUserBoughtListPage({super.key});

  @override
  State<LowAdminUserBoughtListPage> createState() =>
      _LowAdminUserBoughtListPageState();
}

class _LowAdminUserBoughtListPageState
    extends State<LowAdminUserBoughtListPage> {
  final TextEditingController _userIdController = TextEditingController();
  late final RestClient _restClient = createAuthenticatedClient();

  List<
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
  >
  _boughtRecords = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;

  // Paging
  final ScrollController _scrollController = ScrollController();
  static const int _pageLimit = 50;
  int _offset = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchRecords(userId: null);
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchRecords({int? userId, bool isLoadMore = false}) async {
    final String? userIdText = _userIdController.text
        .trim()
        .isEmpty
        ? null
        : _userIdController.text.trim();

    if (isLoadMore) {
      if (_isLoadingMore || !_hasMore) return;
      setState(() {
        _isLoadingMore = true;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _offset = 0;
        _hasMore = true;
      });
    }

    final int? effectiveUserId = userId ??
        (userIdText == null ? null : int.tryParse(userIdText));

    final WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse
    result = await _restClient.fallback
        .getUserBoughtApiV2LowAdminApiUserBoughtGet(
      limit: _pageLimit,
      offset: _offset,
      userId: effectiveUserId,
    );

    if (!mounted) return;

    setState(() {
      if (isLoadMore) {
        _isLoadingMore = false;
      } else {
        _isLoading = false;
      }

      if (result.isSuccess) {
        final fetched = result.resultList;
        if (isLoadMore) {
          _boughtRecords = List.from(_boughtRecords)
            ..addAll(fetched);
        } else {
          _boughtRecords = fetched;
        }

        if (fetched.length < _pageLimit) {
          _hasMore = false;
        } else {
          _hasMore = true;
          _offset += _pageLimit;
        }

        if (_boughtRecords.isEmpty) {
          _errorMessage = userId == null
              ? '暂无购买记录'
              : '该用户暂无购买记录';
        }
      } else {
        _errorMessage = result.message;
        if (!isLoadMore) {
          _boughtRecords =
          <
              WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
          >[];
        }
      }
    });
  }

  Future<void> _searchByUserId() async {
    final String userIdText = _userIdController.text.trim();
    if (userIdText.isEmpty) {
      await _fetchRecords(userId: null);
      return;
    }

    final int? userId = int.tryParse(userIdText);
    if (userId == null) {
      setState(() {
        _errorMessage = '请输入有效的用户ID';
        _boughtRecords =
            <
              WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
            >[];
      });
      return;
    }

    await _fetchRecords(userId: userId);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= (maxScroll - 200) && !_isLoading && !_isLoadingMore &&
        _hasMore) {
      // Determine current filter (userId)
      final String text = _userIdController.text.trim();
      final int? userId = text.isEmpty ? null : int.tryParse(text);
      _fetchRecords(userId: userId, isLoadMore: true);
    }
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
                        _fetchRecords(userId: null);
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
                  ? () => _fetchRecords(userId: null)
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
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _boughtRecords.length + 1,
      itemBuilder: (context, index) {
        if (index < _boughtRecords.length) {
          final record = _boughtRecords[index];
          return _buildBoughtCard(record);
        }
        // footer
        if (_isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (!_hasMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
                child: Text('到底了', style: TextStyle(color: Colors.grey))),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBoughtCard(
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
    record,
  ) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    // use local time for display/comparison
    final localExpireAt = record.expireAt != null
        ? tz.TZDateTime.from(record.expireAt!, tz.local)
        : null;
    final isExpired = localExpireAt != null &&
        localExpireAt.isBefore(tz.TZDateTime.now(tz.local));

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
                  child: _buildClickableUserIdItem(context, record.userId),
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
                    dateFormat.format(
                        tz.TZDateTime.from(record.createdAt, tz.local)),
                  ),
                ),
                if (record.expireAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      Icons.event,
                      '过期时间',
                      dateFormat.format(localExpireAt!),
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
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.open_in_new,
                  size: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
