import 'package:fl_app1/api/models/get_search_user_result.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_grafana_admin_view_search_user_get_search_user_result_result_list_data.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class LowAdminUsersListPage extends StatefulWidget {
  const LowAdminUsersListPage({super.key});

  @override
  State<LowAdminUsersListPage> createState() => _LowAdminUsersListPageState();
}

class _LowAdminUsersListPageState extends State<LowAdminUsersListPage> {
  final TextEditingController _searchController = TextEditingController();
  late final RestClient _restClient = createAuthenticatedClient();

  List<
    WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData
  >
  _users = [];
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
    _searchController.text = '';
    _scrollController.addListener(_onScroll);
    _searchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers({bool isLoadMore = false}) async {
    final String query = _searchController.text.trim();

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

    final GetSearchUserResult result = await _restClient.fallback
        .getUserV2ApiV2LowAdminApiUserV2Get(
          q: query.isEmpty ? null : query,
      limit: _pageLimit,
      offset: _offset,
        );

    if (!mounted) return;

    setState(() {
      if (isLoadMore) {
        _isLoadingMore = false;
      } else {
        _isLoading = false;
      }

      if (result.isSuccess) {
        final List<
            WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData
        > fetched = result.resultList;

        if (isLoadMore) {
          _users = List.from(_users)
            ..addAll(fetched);
        } else {
          _users = fetched;
        }

        // If fewer items than page limit returned -> no more data
        if (fetched.length < _pageLimit) {
          _hasMore = false;
        } else {
          _hasMore = true;
          _offset += _pageLimit;
        }

        if (_users.isEmpty) {
          _errorMessage = '未找到匹配的用户';
        }
      } else {
        _errorMessage = result.message;
        if (!isLoadMore) {
          _users = <
              WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData
          >[];
        }
      }
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double current = _scrollController.position.pixels;
    // When within 200 pixels from bottom, try to load more
    if (current >= (maxScroll - 200) && !_isLoading && !_isLoadingMore &&
        _hasMore) {
      _searchUsers(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ShellRoute provides LowAdminLayout (menu). Return only the page content.
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: '搜索用户',
              hintText: '输入用户ID、邮箱或用户名',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _users = [];
                          _errorMessage = null;
                        });
                      },
                    ),
                ],
              ),
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (_) => _searchUsers(),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        if (_searchController.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _searchUsers,
                    icon: const Icon(Icons.search),
                    label: const Text('搜索'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _showUserIdDialog(context),
                  icon: const Icon(Icons.person_search),
                  label: const Text('通过ID查看'),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
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
            Text('搜索中...'),
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
              onPressed: _searchUsers,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '输入关键词搜索用户',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '支持搜索用户ID、邮箱或用户名',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showUserIdDialog(context),
              icon: const Icon(Icons.person_search),
              label: const Text('通过ID查看用户'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _users.length + 1, // extra item for footer
      itemBuilder: (context, index) {
        if (index < _users.length) {
          final user = _users[index];
          return _buildUserCard(user);
        }
        return _buildListFooter();
      },
    );
  }

  Widget _buildUserCard(
    WebSubFastapiRoutersApiVGrafanaAdminViewSearchUserGetSearchUserResultResultListData
    user,
  ) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: InkWell(
        onTap: () => context.push('/low_admin/user_v2/${user.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      user.userName.isNotEmpty
                          ? user.userName[0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.userName.isEmpty ? '未设置用户名' : user.userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: user.isEnable
                                    ? Colors.green.withValues(alpha: 0.2)
                                    : Colors.red.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                user.isEnable ? '启用' : '禁用',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: user.isEnable
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(Icons.tag, 'ID', user.id.toString()),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.account_balance_wallet,
                      '余额',
                      '¥${user.moneyAmount}',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.calendar_today,
                      '注册时间',
                      // API returns UTC DateTime; convert to local for display
                      dateFormat.format(
                        tz.TZDateTime.from(user.createdAt, tz.local),
                      )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListFooter() {
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
          child: Text(
            '到底了',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    // When not loading more and still may have data, show nothing.
    return const SizedBox.shrink();
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

  Future<void> _showUserIdDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final GoRouter router = GoRouter.of(context);

    final int? result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('输入用户ID'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '用户ID',
            hintText: '例如: 123',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final id = int.tryParse(controller.text.trim());
              Navigator.pop(context, id);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result != null) {
      if (!mounted) return;
      router.push('/low_admin/user_v2/$result');
    }
  }
}
