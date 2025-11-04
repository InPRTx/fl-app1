import 'package:flutter/material.dart';

import 'low_admin_layout.dart';

class LowAdminSettingsPage extends StatefulWidget {
  const LowAdminSettingsPage({super.key});

  @override
  State<LowAdminSettingsPage> createState() => _LowAdminSettingsPageState();
}

class _LowAdminSettingsPageState extends State<LowAdminSettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = '中文';

  @override
  Widget build(BuildContext context) {
    return LowAdminLayout(
      title: '系统设置',
      selectedIndex: 2,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('通知提醒'),
                  subtitle: const Text('接收系统通知'),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('深色模式'),
                  subtitle: const Text('切换深色主题'),
                  trailing: Switch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() => _darkModeEnabled = value);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('语言设置'),
                  subtitle: Text(_selectedLanguage),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showLanguageDialog(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('关于'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: '低权限管理后台',
                      applicationVersion: '1.0.0',
                      applicationIcon: const Icon(
                        Icons.admin_panel_settings,
                        size: 48,
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('帮助与反馈'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('帮助功能开发中')));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              '设置功能开发中',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择语言'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('中文'),
              leading: Icon(
                _selectedLanguage == '中文'
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              onTap: () => Navigator.pop(context, '中文'),
            ),
            ListTile(
              title: const Text('English'),
              leading: Icon(
                _selectedLanguage == 'English'
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              onTap: () => Navigator.pop(context, 'English'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() => _selectedLanguage = result);
    }
  }
}
