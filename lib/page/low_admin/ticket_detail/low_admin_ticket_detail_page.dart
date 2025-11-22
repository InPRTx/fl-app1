import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LowAdminTicketDetailPage extends StatefulWidget {
  final int ticketId;

  const LowAdminTicketDetailPage({super.key, required this.ticketId});

  @override
  State<LowAdminTicketDetailPage> createState() =>
      _LowAdminTicketDetailPageState();
}

class _LowAdminTicketDetailPageState extends State<LowAdminTicketDetailPage> {
  late final RestClient _restClient = createAuthenticatedClient();
  final TextEditingController _replyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isSubmitting = false;
  UserTicketView? _ticket;
  String? _errorMessage;
  TicketStatusEnum? _selectedStatus;
  TicketStatusEnum? _initialStatus;
  bool _statusChanged = false;

  @override
  void initState() {
    super.initState();
    _loadTicketDetail();
  }

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadTicketDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await _restClient.fallback
        .getTicketDetailApiV2LowAdminApiTicketTicketIdGet(
          ticketId: widget.ticketId,
        );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (response.isSuccess && response.result != null) {
        _ticket = response.result;
        _selectedStatus = _ticket?.ticketStatus;
        // record the initial status and reset changed flag
        _initialStatus = _ticket?.ticketStatus;
        _statusChanged = false;
      } else {
        _errorMessage = response.message;
      }
    });
  }

  Future<void> _submitReply() async {
    final content = _replyController.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入回复内容')));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Only include status if the user explicitly changed it.
    final body = ReplyParams(
      content: content,
      status: _statusChanged ? _selectedStatus : null,
    );

    final response = await _restClient.fallback
        .postTicketReplyApiV2LowAdminApiTicketTicketIdReplyPost(
          ticketId: widget.ticketId,
          body: body,
        );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (response.isSuccess == true) {
      _replyController.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('回复成功')));
      await _loadTicketDetail();

      // 滚动到底部显示新回复
      if (_scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('回复失败: ${response.message}')));
    }
  }

  Future<void> _closeTicket() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认关闭工单'),
        content: const Text('确定要关闭这个工单吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('关闭工单'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isSubmitting = true;
    });

    final body = ReplyParams(
      content: '工单已由管理员关闭',
      status: TicketStatusEnum.closed,
    );

    final response = await _restClient.fallback
        .postTicketReplyApiV2LowAdminApiTicketTicketIdReplyPost(
          ticketId: widget.ticketId,
          body: body,
        );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (response.isSuccess == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('工单已关闭')));
      await _loadTicketDetail();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('关闭失败: ${response.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('工单详情 #${widget.ticketId}'),
        actions: [
          if (_ticket != null &&
              _ticket!.ticketStatus != TicketStatusEnum.closed)
            IconButton(
              onPressed: _isSubmitting ? null : _closeTicket,
              icon: const Icon(Icons.close),
              tooltip: '关闭工单',
            ),
          IconButton(
            onPressed: _loadTicketDetail,
            icon: const Icon(Icons.refresh),
            tooltip: '刷新',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
              onPressed: _loadTicketDetail,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_ticket == null) {
      return const Center(child: Text('工单不存在'));
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTicketHeader(),
                const SizedBox(height: 16),
                _buildTicketInfo(),
                const SizedBox(height: 24),
                _buildMessagesSection(),
              ],
            ),
          ),
        ),
        if (_ticket!.ticketStatus != TicketStatusEnum.closed)
          _buildReplySection(),
      ],
    );
  }

  Widget _buildTicketHeader() {
    final statusColor = _getStatusColor(_ticket!.ticketStatus);
    final statusText = _getStatusText(_ticket!.ticketStatus);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _ticket!.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildInfoChip(Icons.tag, 'ID: ${_ticket!.id}'),
                _buildInfoChip(Icons.person, '用户ID: ${_ticket!.userId}'),
                if (_ticket!.isMarkdown)
                  _buildInfoChip(Icons.code, 'Markdown', Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, [Color? color]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color ?? Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: color ?? Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildTicketInfo() {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '工单信息',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            _buildInfoRow(
              Icons.access_time,
              '创建时间',
              dateFormat.format(_ticket!.createdAt.toLocal()),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.update,
              '更新时间',
              dateFormat.format(_ticket!.updatedAt.toLocal()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
      ],
    );
  }

  Widget _buildMessagesSection() {
    final messages = _ticket!.messages ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '消息记录',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${messages.length}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (messages.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text('暂无消息记录', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          )
        else
          ...messages.map((message) => _buildMessageCard(message)),
      ],
    );
  }

  Widget _buildMessageCard(Messages message) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final isAdmin = message.userId != _ticket!.userId;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isAdmin ? Colors.blue.withValues(alpha: 0.05) : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isAdmin
                        ? Colors.blue.withValues(alpha: 0.2)
                        : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isAdmin ? Icons.support_agent : Icons.person,
                    size: 20,
                    color: isAdmin ? Colors.blue[700] : Colors.grey[700],
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
                            isAdmin ? '管理员' : '用户',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isAdmin ? Colors.blue[700] : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ID: ${message.userId}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dateFormat.format(message.createdAt.toLocal()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message.content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('消息内容已复制'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  tooltip: '复制内容',
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              message.content,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplySection() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    '回复工单',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  DropdownButton<TicketStatusEnum>(
                    value: _selectedStatus,
                    items: TicketStatusEnum.values.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(_getStatusText(status)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                        // mark that user explicitly changed status
                        _statusChanged = true;
                      });
                    },
                    hint: const Text('选择状态'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _replyController,
                decoration: const InputDecoration(
                  hintText: '输入回复内容...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                enabled: !_isSubmitting,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _submitReply,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                      label: Text(_isSubmitting ? '发送中...' : '发送回复'),
                    ),
                  ),
                ],
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
