import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class LowAdminSsNodePage extends StatefulWidget {
  const LowAdminSsNodePage({super.key});

  @override
  State<LowAdminSsNodePage> createState() => _LowAdminSsNodePageState();
}

class _LowAdminSsNodePageState extends State<LowAdminSsNodePage> {
  final TextEditingController _searchController = TextEditingController();
  final RestClient _restClient = createAuthenticatedClient();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  List<SsNodeOutput> _nodes = <SsNodeOutput>[];
  bool _isLoading = false;
  String? _errorMessage;
  static const double _tabletBreakpoint = 640;

  @override
  void initState() {
    super.initState();
    _fetchNodes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchNodes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final GetSsNodeListResponse response = await _restClient.fallback
          .getSsNodeListApiV2LowAdminApiSsNodeGet(
            q: _searchController.text.trim().isEmpty
                ? null
                : _searchController.text.trim(),
          );

      if (!mounted) return;
      setState(() {
        _nodes = response.resultList;
        if (_nodes.isEmpty) {
          _errorMessage = '暂无节点数据';
        }
        _isLoading = false;
      });
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = error.message ?? '节点数据加载失败';
        _nodes = <SsNodeOutput>[];
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = error.toString();
        _nodes = <SsNodeOutput>[];
      });
    }
  }

  bool _isTablet(double width) => width >= _tabletBreakpoint;


  Future<void> _openNodeForm({SsNodeOutput? node}) async {
    final bool? updated = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          _SsNodeFormDialog(restClient: _restClient, node: node),
    );
    if (updated == true) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('节点信息已更新')));
      _fetchNodes();
    }
  }

  Future<void> _confirmDelete(SsNodeOutput node) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除节点'),
        content: Text('确定要删除节点 ${node.nodeName} (ID: ${node.id}) 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirm != true || node.id == null) return;

    try {
      final ErrorResponse response = await _restClient.fallback
          .deleteSsNodeApiV2LowAdminApiSsNodeNodeIdDelete(nodeId: node.id!);
      if (!mounted) return;
      if (response.isSuccess) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('节点 ${node.nodeName} 已删除')));
        _fetchNodes();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.message)));
      }
    } on DioException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message ?? '删除失败')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final tz.TZDateTime localTime = tz.TZDateTime.from(dateTime, tz.local);
    return _dateFormat.format(localTime);
  }

  String _getCountryEmoji(String countryCode) {
    final code = countryCode.toUpperCase();
    if (code.length != 2) return countryCode;
    return String.fromCharCodes([
      0x1F1E6 + code.codeUnitAt(0) - 0x41,
      0x1F1E6 + code.codeUnitAt(1) - 0x41,
    ]);
  }

  Widget _buildFilterRow() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: 320,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: '查询 (q)',
                      hintText: '支持节点名称 / 备注 / ID',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _fetchNodes(),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _fetchNodes,
                  icon: Icon(
                    _searchController.text.trim().isEmpty
                        ? Icons.refresh
                        : Icons.search,
                  ),
                  label: Text(
                    _searchController.text.trim().isEmpty ? '刷新' : '搜索',
                  ),
                ),
                FilledButton.icon(
                  onPressed: _isLoading ? null : () => _openNodeForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('新增节点'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text('正在加载节点数据...'),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 12),
              Text(_errorMessage!),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _fetchNodes,
                icon: const Icon(Icons.refresh),
                label: const Text('重试'),
              ),
            ],
          ),
        ),
      );
    }

    if (_nodes.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hub_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 12),
              const Text('暂无节点数据'),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final bool isTablet = _isTablet(width);

          Widget child;
          if (isTablet) {
            child = GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 280,
              ),
              itemCount: _nodes.length,
              itemBuilder: (context, index) => _buildNodeCard(_nodes[index]),
            );
          } else {
            child = ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _nodes.length,
              itemBuilder: (context, index) => _buildNodeCard(_nodes[index]),
            );
          }

          return RefreshIndicator(onRefresh: _fetchNodes, child: child);
        },
      ),
    );
  }


  Widget _buildNodeCard(SsNodeOutput node) {
    return SizedBox(
      height: 280,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          node.nodeName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ID: ${node.id ?? '-'}',
                          style: const TextStyle(fontSize: 11, color: Colors
                              .grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: '编辑',
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                        minWidth: 32, minHeight: 32),
                    icon: const Icon(Icons.edit),
                    onPressed: () => _openNodeForm(node: node),
                  ),
                  IconButton(
                    tooltip: '删除',
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                        minWidth: 32, minHeight: 32),
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red[700],
                    onPressed: () => _confirmDelete(node),
                  ),
                  Chip(
                    backgroundColor: node.isEnable
                        ? Colors.green.withValues(alpha: 0.15)
                        : Colors.red.withValues(alpha: 0.15),
                    label: Text(
                      node.isEnable ? '启用' : '禁用',
                      style: const TextStyle(fontSize: 11),
                    ),
                    labelStyle: TextStyle(
                      color: node.isEnable ? Colors.green[700] : Colors
                          .red[700],
                      fontSize: 11,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                  ),
                ],
              ),
              const Divider(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('主机', node.nodeConfig.host ?? '-'),
                      _buildInfoRow(
                          '端口', node.nodeConfig.port?.toString() ?? '-'),
                      _buildInfoRow('协议', node.vpnType.name),
                      _buildInfoRow(
                          '国家代码',
                          '${_getCountryEmoji(node.iso3166Code.name)} ${node
                              .iso3166Code.name.toUpperCase()}'),
                      _buildInfoRow('倍率', node.nodeRate),
                      _buildInfoRow('等级', node.nodeLevel.toString()),
                      _buildInfoRow('隐藏', node.isHideNode ? '是' : '否'),
                      _buildInfoRow(
                          '创建时间', _formatDateTime(node.createdAt)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text('节点管理', style: Theme.of(context).textTheme.headlineSmall),
        ),
        _buildFilterRow(),
        _buildContent(),
      ],
    );
  }
}

class _SsNodeFormDialog extends StatefulWidget {
  const _SsNodeFormDialog({required this.restClient, this.node});

  final RestClient restClient;
  final SsNodeOutput? node;

  @override
  State<_SsNodeFormDialog> createState() => _SsNodeFormDialogState();
}

class _SsNodeFormDialogState extends State<_SsNodeFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late _SsNodeFormData _data;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _data = widget.node == null
        ? _SsNodeFormData()
        : _SsNodeFormData.fromOutput(widget.node!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.node == null ? '新增节点' : '编辑节点'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _data.nodeName,
                  decoration: const InputDecoration(
                    labelText: '节点名称',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? '节点名称必填' : null,
                  onChanged: (value) => setState(() {
                    _data.nodeName = value.trim();
                  }),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _data.host,
                        decoration: const InputDecoration(
                          labelText: '主机地址',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? '主机地址必填'
                            : null,
                        onChanged: (value) => setState(() {
                          _data.host = value.trim();
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        initialValue: _data.port == null
                            ? ''
                            : _data.port.toString(),
                        decoration: const InputDecoration(
                          labelText: '端口',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() {
                          _data.port = int.tryParse(value.trim());
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _data.priority.toString(),
                        decoration: const InputDecoration(
                          labelText: '优先级',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() {
                          _data.priority = int.tryParse(value.trim()) ?? 60000;
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        initialValue: _data.nodeLevel.toString(),
                        decoration: const InputDecoration(
                          labelText: '节点等级',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() {
                          _data.nodeLevel = int.tryParse(value.trim()) ?? 0;
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _data.nodeRate.toString(),
                        decoration: const InputDecoration(
                          labelText: '倍率 (node_rate)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (value) => setState(() {
                          _data.nodeRate = double.tryParse(value.trim()) ?? 1;
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<VpnTypeEnum>(
                        initialValue: _data.vpnType,
                        items: VpnTypeEnum.values
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              ),
                            )
                            .toList(),
                        decoration: const InputDecoration(
                          labelText: '协议类型',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            setState(() => _data.vpnType = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<CountryCode>(
                  initialValue: _data.iso3166Code,
                  decoration: const InputDecoration(
                    labelText: '国家/地区代码',
                    border: OutlineInputBorder(),
                  ),
                  items: CountryCode.values
                      .map(
                        (code) => DropdownMenuItem(
                          value: code,
                          child: Text(code.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() {
                    _data.iso3166Code = value ?? CountryCode.cn;
                  }),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: _data.nodeSpeedLimit ?? '',
                  decoration: const InputDecoration(
                    labelText: '速度限制 (可选)',
                    helperText: '示例: 100MB 或 1GB/日',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() {
                    _data.nodeSpeedLimit = value.trim().isEmpty ? null : value;
                  }),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: _data.nodeInfo ?? '',
                  decoration: const InputDecoration(
                    labelText: '节点信息 (可选)',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 4,
                  onChanged: (value) => setState(() {
                    _data.nodeInfo = value.trim().isEmpty ? null : value;
                  }),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: _data.remark ?? '',
                  decoration: const InputDecoration(
                    labelText: '备注 (可选)',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 4,
                  onChanged: (value) => setState(() {
                    _data.remark = value.trim().isEmpty ? null : value;
                  }),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: _data.userGroupHostRaw,
                  decoration: const InputDecoration(
                    labelText: '用户组主机映射 (JSON 可选)',
                    helperText:
                        '示例: {"default":{"host":"example.com","port":443}}',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: 6,
                  onChanged: (value) => setState(() {
                    _data.userGroupHostRaw = value.trim();
                  }),
                ),
                SwitchListTile(
                  title: const Text('节点启用'),
                  value: _data.isEnable,
                  onChanged: (value) => setState(() {
                    _data.isEnable = value;
                  }),
                ),
                SwitchListTile(
                  title: const Text('节点对用户隐藏'),
                  value: _data.isHideNode,
                  onChanged: (value) => setState(() {
                    _data.isHideNode = value;
                  }),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context, false),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('保存'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String trimmed = _data.userGroupHostRaw.trim();
    UserGroupHost? userGroupHost;
    if (trimmed.isNotEmpty) {
      try {
        userGroupHost = _parseUserGroupHost(trimmed);
      } catch (error) {
        setState(() {
          _errorMessage = '用户组主机 JSON 解析失败: $error';
        });
        return;
      }
    }

    final NodeConfig nodeConfig = NodeConfig(
      host: _data.host,
      port: _data.port,
    );

    final SsNodeInput body = SsNodeInput(
      id: _data.id,
      nodeName: _data.nodeName,
      nodeConfig: nodeConfig,
      priority: _data.priority,
      isEnable: _data.isEnable,
      iso3166Code: _data.iso3166Code,
      vpnType: _data.vpnType,
      nodeRate: _data.nodeRate,
      nodeLevel: _data.nodeLevel,
      isHideNode: _data.isHideNode,
      createdAt: _data.createdAtLocal?.toUtc(),
      updatedAt: DateTime.now().toUtc(),
      nodeInfo: _data.nodeInfo,
      remark: _data.remark,
      nodeSpeedLimit: _data.nodeSpeedLimit,
      userGroupHost: userGroupHost,
    );

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

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
      if (response.isSuccess) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          _isSubmitting = false;
          _errorMessage = response.message;
        });
      }
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = error.message ?? '保存失败';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = error.toString();
      });
    }
  }

  UserGroupHost _parseUserGroupHost(String raw) {
    final dynamic decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('必须是对象结构');
    }

    final Map<String, SsNodeUserGroupHostDict> map = decoded.map((key, value) {
      if (value is! Map<String, dynamic>) {
        throw const FormatException('每个用户组必须是对象');
      }
      return MapEntry(key, SsNodeUserGroupHostDict.fromJson(value));
    });
    return UserGroupHost(userGroupHost: map);
  }
}

class _SsNodeFormData {
  _SsNodeFormData()
    : id = null,
      nodeName = '',
      host = '',
      port = 443,
      priority = 60000,
      nodeRate = 1,
      nodeLevel = 0,
      isEnable = true,
      isHideNode = false,
      iso3166Code = CountryCode.cn,
      vpnType = VpnTypeEnum.vmess,
      userGroupHostRaw = '';

  _SsNodeFormData.fromOutput(SsNodeOutput node)
    : id = node.id,
      nodeName = node.nodeName,
      host = node.nodeConfig.host ?? '',
      port = node.nodeConfig.port,
      priority = node.priority,
      nodeRate = double.tryParse(node.nodeRate) ?? 1,
      nodeLevel = node.nodeLevel,
      isEnable = node.isEnable,
      isHideNode = node.isHideNode,
      iso3166Code = node.iso3166Code,
      vpnType = node.vpnType,
      nodeInfo = node.nodeInfo,
      remark = node.remark,
      nodeSpeedLimit = node.nodeSpeedLimit,
      createdAtLocal = node.createdAt?.toLocal(),
      userGroupHostRaw = node.userGroupHost == null
          ? ''
          : const JsonEncoder.withIndent('  ').convert(
              node.userGroupHost!.userGroupHost.map(
                (key, value) => MapEntry(key, value.toJson()),
              ),
            );

  int? id;
  String nodeName;
  String host;
  int? port;
  int priority;
  double nodeRate;
  int nodeLevel;
  bool isEnable;
  bool isHideNode;
  CountryCode iso3166Code;
  VpnTypeEnum vpnType;
  String? nodeInfo;
  String? remark;
  String? nodeSpeedLimit;
  DateTime? createdAtLocal;
  String userGroupHostRaw;
}
