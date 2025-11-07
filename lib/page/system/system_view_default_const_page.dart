import 'package:fl_app1/api/base_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemViewDefaultConstPage extends StatelessWidget {
  const SystemViewDefaultConstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('系统默认常量')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('默认 Base URL'),
              subtitle: Text(kDefaultBaseUrl),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: kDefaultBaseUrl));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('已复制到剪贴板')));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
