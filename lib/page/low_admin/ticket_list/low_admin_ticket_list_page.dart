import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@RoutePage()
class LowAdminTicketListPage extends StatefulWidget {
  const LowAdminTicketListPage({super.key});

  @override
  State<LowAdminTicketListPage> createState() => _LowAdminTicketListPageState();
}

class _LowAdminTicketListPageState extends State<LowAdminTicketListPage> {
  late final RestClient _restClient = createAuthenticatedClient();
  final TextEditingController _queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _queryString;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  List<UserTicket> _tickets = [];
  String? _errorMessage;
  Map<int, UserInfo> _userInfos = <int, UserInfo>{};

  static const int _pageLimit = 20;
  int _offset = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQueryFromUrl();
      _loadTickets();
    });
  }

  void _loadQueryFromUrl() {
    final uri = Uri.base;
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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void _applyQuery() {
    final text = _queryController.text.trim();
    setState(() {
      _queryString = text.isEmpty ? null : text;
      _offset = 0;
      _hasMore = true;
    });
    _loadTickets();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= (maxScroll - 200) &&
        !_isLoading &&
        !_isLoadingMore &&
        _hasMore) {
      _loadTickets(isLoadMore: true);
    }
  }

  Future<void> _loadTickets({bool isLoadMore = false}) async {
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

    final response = await _restClient.fallback
        .getTicketApiV2LowAdminApiTicketGet(
          q: _queryString,
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

      if (response.isSuccess) {
        final fetched = response.resultList;
        if (isLoadMore) {
          _tickets = List.from(_tickets)..addAll(fetched);
        } else {
          _tickets = fetched;
        }

        if (fetched.length < _pageLimit) {
          _hasMore = false;
        } else {
          _hasMore = true;
          _offset += _pageLimit;
        }
      } else {
        _errorMessage = response.message;
        if (!isLoadMore) {
          _tickets = [];
        }
      }
    });

    // Fetch user info for all tickets after loading
    if (response.isSuccess && _tickets.isNotEmpty && mounted) {
      final Set<int> userIds = <int>{};
      for (final ticket in _tickets) {
        if (ticket.userId != null) {
          userIds.add(ticket.userId!);
        }
      }

      if (userIds.isNotEmpty) {
        try {
          final fetched = await UserService().fetchBatchUserInfos(
            userIds.toList(),
          );
          if (!mounted) return;
          setState(() {
            _userInfos = fetched;
          });
        } catch (_) {
          // 不做无意义的报错包装，列表仍然可以显示基础信息
        }
      }
    }
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
                    helperText: '支持格式: user_id:123 title:问题',
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
                label: Text(_queryController.text.trim().isEmpty ? '全部' : '搜索'),
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
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text('加载失败', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadTickets,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('暂无工单', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTickets,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _tickets.length + 1,
        itemBuilder: (context, index) {
          if (index < _tickets.length) {
            final ticket = _tickets[index];
            return _buildTicketCard(ticket);
          }
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
                child: Text('到底了', style: TextStyle(color: Colors.grey)),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTicketCard(UserTicket ticket) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final statusColor = _getStatusColor(ticket.ticketStatus);
    final statusText = _getStatusText(ticket.ticketStatus);

    // Get user info from cache
    final userInfo = ticket.userId != null ? _userInfos[ticket.userId!] : null;
    final userAvatar = userInfo != null
        ? UserService().gravatarUrlForEmail(userInfo.email, size: 40)
        : null;
    final userName = userInfo?.userName ??
        (ticket.userId != null ? '用户ID: ${ticket.userId}' : 'N/A');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // 导航到工单详情页面
          if (ticket.id != null) {
            context.router.pushPath('/low_admin/ticket/${ticket.id}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info row with avatar and name
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: userAvatar != null ? NetworkImage(
                        userAvatar) : null,
                    child: userAvatar == null
                        ? Icon(Icons.person, color: Colors.grey[700], size: 20)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (ticket.userId != null)
                          Text(
                            'ID: ${ticket.userId}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              // Title row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ticket.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Metadata row
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildInfoChip(Icons.tag, 'ID: ${ticket.id ?? "N/A"}'),
                  if (ticket.createdAt != null)
                    _buildInfoChip(
                      Icons.access_time,
                      dateFormat.format(ticket.createdAt!.toLocal()),
                    ),
                  if (ticket.updatedAt != null &&
                      ticket.createdAt != null &&
                      ticket.updatedAt != ticket.createdAt)
                    _buildInfoChip(
                      Icons.update,
                      '更新: ${dateFormat.format(ticket.updatedAt!.toLocal())}',
                    ),
                  if (ticket.isMarkdown)
                    _buildInfoChip(Icons.code, 'Markdown', Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, [Color? color]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color ?? Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color ?? Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(TicketStatusEnum status) {
    switch (status) {
      case TicketStatusEnum.pending:
        return Colors.orange;
      case TicketStatusEnum.processing:
        return Colors.blue;
      case TicketStatusEnum.resolved:
        return Colors.green;
      case TicketStatusEnum.closed:
        return Colors.grey;
    }
  }

  String _getStatusText(TicketStatusEnum status) {
    switch (status) {
      case TicketStatusEnum.pending:
        return '待处理';
      case TicketStatusEnum.processing:
        return '处理中';
      case TicketStatusEnum.resolved:
        return '已解决';
      case TicketStatusEnum.closed:
        return '已关闭';
    }
  }
}
