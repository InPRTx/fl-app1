import 'package:fl_app1/store/base_url_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemDebugBaseUrlPage extends StatefulWidget {
  const SystemDebugBaseUrlPage({super.key});

  @override
  State<SystemDebugBaseUrlPage> createState() => _SystemDebugBaseUrlPageState();
}

class _SystemDebugBaseUrlPageState extends State<SystemDebugBaseUrlPage> {
  final BaseUrlStore _baseUrlStore = BaseUrlStore();
  final TextEditingController _urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _baseUrlStore.addListener(_onStoreChanged);
    _urlController.text = _baseUrlStore.baseUrl;
  }

  @override
  void dispose() {
    _baseUrlStore.removeListener(_onStoreChanged);
    _urlController.dispose();
    super.dispose();
  }

  void _onStoreChanged() {
    if (mounted) {
      setState(() {
        _urlController.text = _baseUrlStore.baseUrl;
      });
    }
  }

  Future<void> _saveBaseUrl() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String newUrl = _urlController.text.trim();
      await _baseUrlStore.setCustomBaseUrl(newUrl);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Base URL 已保存，重启应用后生效')));
      }
    }
  }

  Future<void> _resetToDefault() async {
    await _baseUrlStore.resetToDefault();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已恢复默认 Base URL')));
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('已复制到剪贴板')));
  }

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入 Base URL';
    }
    if (!value.startsWith('http://') && !value.startsWith('https://')) {
      return 'URL 必须以 http:// 或 https:// 开头';
    }
    try {
      Uri.parse(value);
    } catch (e) {
      return 'URL 格式不正确';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Base URL 配置')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('当前配置', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.link),
                    title: const Text('当前使用的 Base URL'),
                    subtitle: Text(_baseUrlStore.baseUrl),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => _copyToClipboard(_baseUrlStore.baseUrl),
                      tooltip: '复制',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('默认 Base URL'),
                    subtitle: Text(_baseUrlStore.defaultBaseUrl),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () =>
                          _copyToClipboard(_baseUrlStore.defaultBaseUrl),
                      tooltip: '复制',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('配置状态'),
                    subtitle: Text(
                      _baseUrlStore.isUsingCustom ? '使用自定义配置' : '使用默认配置',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '修改 Base URL',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'Base URL',
                        hintText: 'https://api.example.com',
                        border: OutlineInputBorder(),
                        helperText: '修改后需要重启应用才能生效',
                      ),
                      validator: _validateUrl,
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _saveBaseUrl,
                            icon: const Icon(Icons.save),
                            label: const Text('保存'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _resetToDefault,
                            icon: const Icon(Icons.restore),
                            label: const Text('恢复默认'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        '注意事项',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• 修改 Base URL 后需要重启应用才能生效\n'
                    '• 请确保输入的 URL 格式正确\n'
                    '• 使用自定义 URL 前请确认服务器可访问\n'
                    '• 如遇到问题可恢复默认配置',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
