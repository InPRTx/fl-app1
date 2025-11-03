import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/export.dart';
import 'package:flutter/material.dart';

class UserV2Page extends StatefulWidget {
  // userId is provided from the route path, e.g. /low_admin/user_v2/123
  final int userId;

  const UserV2Page({super.key, required this.userId});

  @override
  State<UserV2Page> createState() => _UserV2PageState();
}

class _UserV2PageState extends State<UserV2Page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool? _isEnable;
  final TextEditingController _telegramIdController = TextEditingController();
  bool? _isEmailVerify;
  DateTime? _expireIn;

  String _output = '';
  bool _loading = false;

  RestClient get _rest {
    final dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    return RestClient(dio, baseUrl: kDefaultBaseUrl);
  }

  void _setLoading(bool v) => setState(() => _loading = v);

  Future<void> _callGetOldService() async {
    final id = widget.userId;
    _setLoading(true);
    try {
      // Use generated fallback client
      await _rest.fallback
          .getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet(userId: id);
      setState(() {
        _output = '调用完成（没有返回体）';
      });
    } on DioException catch (e) {
      setState(() {
        _output = _formatDioError(e);
      });
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _callGetUserV2() async {
    final id = widget.userId;
    _setLoading(true);
    try {
      final dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
      final resp = await dio.get('/api/v2/low_admin_api/user_v2/$id');
      final data = resp.data;
      if (data is Map) {
        final obj = AdminUserV.fromJson(Map<String, dynamic>.from(data));
        _output = const JsonEncoder.withIndent('  ').convert(obj.toJson());
      } else {
        _output = data?.toString() ?? '<empty>';
      }
      setState(() {});
    } on DioException catch (e) {
      setState(() {
        _output = _formatDioError(e);
      });
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _callPatchUserV2() async {
    final id = widget.userId;

    final telegram = int.tryParse(_telegramIdController.text.trim());

    final body = ParamModelPatch(
      email: _emailController.text.trim().isEmpty
          ? null
          : _emailController.text.trim(),
      userName: _userNameController.text.trim().isEmpty
          ? null
          : _userNameController.text.trim(),
      isEnable: _isEnable,
      telegramId: telegram,
      isEmailVerify: _isEmailVerify,
      userAccountExpireIn: _expireIn,
    );

    _setLoading(true);
    try {
      // Use generated fallback client
      await _rest.fallback.patchUserV2ApiV2LowAdminApiUserV2UserIdPatch(
        userId: id,
        body: body,
      );
      _showSnack('更新完成');
      setState(() {
        _output = 'Patch success (no returned body)';
      });
    } on DioException catch (e) {
      setState(() {
        _output = _formatDioError(e);
      });
    } finally {
      _setLoading(false);
    }
  }

  String _formatDioError(DioException e) {
    final req = e.requestOptions;
    final uri = req.uri.toString();
    final type = e.type.name;
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
    return sb.toString();
  }

  void _showSnack(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _telegramIdController.dispose();
    super.dispose();
  }

  Future<void> _pickExpireIn() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expireIn ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _expireIn = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('user_v2 - id: ${widget.userId}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _loading ? null : _callGetOldService,
                  child: const Text('Get Old Service'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loading ? null : _callGetUserV2,
                  child: const Text('Get User V2'),
                ),
              ],
            ),
            const Divider(),
            const Text('Patch fields (leave empty to skip)'),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'User name'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Is enable:'),
                const SizedBox(width: 8),
                DropdownButton<bool?>(
                  value: _isEnable,
                  items: const [
                    DropdownMenuItem<bool?>(value: null, child: Text('Skip')),
                    DropdownMenuItem<bool?>(value: true, child: Text('True')),
                    DropdownMenuItem<bool?>(value: false, child: Text('False')),
                  ],
                  onChanged: (v) => setState(() => _isEnable = v),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _telegramIdController,
              decoration: const InputDecoration(labelText: 'Telegram ID'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Is email verify:'),
                const SizedBox(width: 8),
                DropdownButton<bool?>(
                  value: _isEmailVerify,
                  items: const [
                    DropdownMenuItem<bool?>(value: null, child: Text('Skip')),
                    DropdownMenuItem<bool?>(value: true, child: Text('True')),
                    DropdownMenuItem<bool?>(value: false, child: Text('False')),
                  ],
                  onChanged: (v) => setState(() => _isEmailVerify = v),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Expire in:'),
                const SizedBox(width: 8),
                Text(_expireIn == null ? 'Skip' : _expireIn!.toIso8601String()),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _pickExpireIn,
                  child: const Text('Pick'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _callPatchUserV2,
              child: const Text('Patch User V2'),
            ),
            const Divider(),
            const Text('Output'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: _loading
                  ? const SizedBox(
                      height: 32,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Text(_output.isEmpty ? '<空>' : _output),
            ),
          ],
        ),
      ),
    );
  }
}
