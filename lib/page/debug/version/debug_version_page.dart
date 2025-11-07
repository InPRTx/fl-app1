import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/version_response_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:flutter/material.dart';

/// 页面：调用 GET /v1/version 并显示返回结果。
/// 说明/假设：默认 baseUrl 为 http://127.0.0.1:8000（常见 FastAPI 本地地址），
/// 可以在页面里修改并点击"Fetch"来请求其他地址。
class DebugVersionPage extends StatefulWidget {
  const DebugVersionPage({super.key});

  @override
  State<DebugVersionPage> createState() => _DebugVersionPageState();
}

class _DebugVersionPageState extends State<DebugVersionPage> {
  // Default to http://10.0.2.2:8000 which maps to host localhost from Android AVD.
  // Change this back to http://127.0.0.1:8000 for iOS simulator or when using adb reverse / physical device.
  final TextEditingController _baseUrlController = TextEditingController(
    text: kDefaultBaseUrl,
  );
  String? _result;
  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _baseUrlController.dispose();
    super.dispose();
  }

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _result = null;
      _error = null;
    });

    final baseUrl = _baseUrlController.text.trim();
    final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      // Use the generated RestClient + FallbackClient to call the API so the
      // response is parsed into VersionResponseModel automatically.
      final rest = RestClient(dio, baseUrl: baseUrl);
      final VersionResponseModel model = await rest.fallback
          .getVersionV1VersionGet();

      setState(() {
        _result =
            'Request: ${dio.options.baseUrl}/v1/version\n\n'
            'version: ${model.data}';
      });
    } on DioException catch (e) {
      // Provide verbose debug info to help troubleshooting
      final req = e.requestOptions;
      final uri = req.uri.toString();
      final type = e.type.name; // DioExceptionType
      String message = e.message ?? e.toString();
      final resp = e.response;
      String respText = '';
      if (resp != null) {
        final body = resp.data;
        try {
          respText = const JsonEncoder.withIndent('  ').convert(body);
        } catch (_) {
          respText = body?.toString() ?? '<empty>';
        }
        message = 'HTTP ${resp.statusCode}\n$respText';
      }

      final sb = StringBuffer();
      sb.writeln('DioException: $type');
      sb.writeln('URI: $uri');
      sb.writeln('Message: $message');
      if (resp != null) {
        sb.writeln();
        sb.writeln('Response headers:');
        resp.headers.forEach((k, v) => sb.writeln('$k: ${v.join(', ')}'));
      }
      // include the original request headers for debugging
      sb.writeln();
      sb.writeln('Request headers:');
      req.headers.forEach((k, v) => sb.writeln('$k: $v'));

      setState(() {
        _error = sb.toString();
      });
    } catch (e, st) {
      setState(() {
        _error = '$e\n\n$st';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('版本 /v1/version')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Base URL (可修改)：'),
            const SizedBox(height: 8),
            TextField(
              controller: _baseUrlController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: kDefaultBaseUrl,
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loading ? null : _fetch,
              icon: const Icon(Icons.download),
              label: const Text('Fetch'),
            ),
            const SizedBox(height: 12),
            if (_loading) ...[
              const Center(child: CircularProgressIndicator()),
            ] else if (_error != null) ...[
              const Text(
                'Error (详细):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ] else if (_result != null) ...[
              const Text(
                'Result:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: SingleChildScrollView(child: SelectableText(_result!)),
              ),
            ] else ...[
              const Text('点击 Fetch 来请求 /v1/version'),
            ],
          ],
        ),
      ),
    );
  }
}
