import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // 导航到工单详情页面
          if (ticket.id != null) {
            context.push('/low_admin/ticket/${ticket.id}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
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
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.tag, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'ID: ${ticket.id ?? "N/A"}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.person, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '用户ID: ${ticket.userId ?? "N/A"}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (ticket.createdAt != null)
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '创建: ${dateFormat.format(ticket.createdAt!.toLocal())}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              if (ticket.updatedAt != null &&
                  ticket.createdAt != null &&
                  ticket.updatedAt != ticket.createdAt)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Icon(Icons.update, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '更新: ${dateFormat.format(ticket.updatedAt!.toLocal())}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              if (ticket.isMarkdown)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Icons.code, size: 16, color: Colors.blue[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Markdown格式',
                        style: TextStyle(color: Colors.blue[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
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
