import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/base_url.dart';

/// A simple debug page that displays the resolved kDefaultBaseUrl value.
///
/// Useful during development to quickly verify which base URL the app is
/// currently using (dev vs. production, web vs. non-web).
class BaseUrlPage extends StatelessWidget {
  const BaseUrlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String baseUrl = kDefaultBaseUrl;
    final String platform = kIsWeb ? 'web' : defaultTargetPlatform.toString();

    return Scaffold(
      appBar: AppBar(title: const Text('Base URL')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Resolved kDefaultBaseUrl',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SelectableText(
              baseUrl.isEmpty ? '<empty (use same origin)>' : baseUrl,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text('Platform: $platform'),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                ElevatedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('复制到剪贴板'),
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await Clipboard.setData(ClipboardData(text: baseUrl));
                    messenger.showSnackBar(
                      const SnackBar(content: Text('已复制到剪贴板')),
                    );
                  },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('刷新页面'),
                  onPressed: () {
                    // As a StatelessWidget we can't trigger setState; just
                    // pop+push to force rebuild in case runtime flags changed.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const BaseUrlPage()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '说明：\n- 开发模式 (debug) 会显示 dev 地址。\n- Release 模式在 Web 上显示空串（同源），非 Web 显示生产地址。',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
