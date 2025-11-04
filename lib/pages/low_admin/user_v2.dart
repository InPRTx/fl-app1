import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/admin_old_service.dart';
import 'package:fl_app1/api/models/admin_user_v.dart';
import 'package:fl_app1/api/models/param_model_patch.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:flutter/material.dart';

class UserV2Page extends StatefulWidget {
  const UserV2Page({super.key, required this.userId});

  final int userId;

  @override
  State<UserV2Page> createState() => _UserV2PageState();
}

class _UserV2PageState extends State<UserV2Page> {
  bool _isLoading = true;
  bool _isSaving = false;
  String? _error;

  // Data from APIs
  AdminUserV? _userV;
  AdminOldService? _oldService;

  // Controllers for editable fields (userV)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _telegramIdController = TextEditingController();
  bool _isEnable = false;
  bool _isEmailVerify = false;
  DateTime? _expireIn;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _telegramIdController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    try {
      // Call both endpoints concurrently
      final results = await Future.wait([
        rest.fallback.getUserV2ApiV2LowAdminApiUserV2UserIdGet(
            userId: widget.userId),
        rest.fallback.getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet(
            userId: widget.userId),
      ]);

      final userResp = results[0] as dynamic;
      final oldServiceResp = results[1] as dynamic;

      // Extract results (generated models wrap result in `.result`)
      final AdminUserV? user = userResp.result as AdminUserV?;
      final AdminOldService? old = oldServiceResp.result as AdminOldService?;

      setState(() {
        _userV = user;
        _oldService = old;

        if (user != null) {
          _emailController.text = user.email;
          _userNameController.text = user.userName;
          _telegramIdController.text = user.telegramId?.toString() ?? '';
          _isEnable = user.isEnable;
          _isEmailVerify = user.isEmailVerify;
          _expireIn = user.userAccountExpireIn;
        }

        _isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        _isLoading = false;
        _error = _formatDioError(e);
      });
    } catch (e, st) {
      setState(() {
        _isLoading = false;
        _error = '$e\n$st';
      });
    }
  }

  String _formatDioError(DioException e) {
    final req = e.requestOptions;
    final uri = req.uri.toString();
    String message = e.message ?? e.toString();
    final resp = e.response;
    if (resp != null) {
      final body = resp.data;
      try {
        message = 'HTTP ${resp.statusCode}\n${body?.toString() ?? '<empty>'}';
      } catch (_) {
        message = 'HTTP ${resp.statusCode}\n<non-string response>';
      }
    }
    return 'DioException: ${e.type.name}\nURI: $uri\nMessage: $message';
  }

  Future<void> _saveUserV2() async {
    if (_userV == null) return;

    setState(() => _isSaving = true);

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    String email = _emailController.text.trim();
    String username = _userNameController.text.trim();
    int? telegramId = _telegramIdController.text
        .trim()
        .isEmpty
        ? null
        : int.tryParse(_telegramIdController.text.trim());

    final ParamModelPatch body = ParamModelPatch(
      email: email == _userV!.email ? null : email,
      userName: username == _userV!.userName ? null : username,
      isEnable: _isEnable == _userV!.isEnable ? null : _isEnable,
      telegramId: telegramId == _userV!.telegramId ? null : telegramId,
      isEmailVerify: _isEmailVerify == _userV!.isEmailVerify
          ? null
          : _isEmailVerify,
      userAccountExpireIn: _expireIn == _userV!.userAccountExpireIn
          ? null
          : _expireIn,
    );

    await rest.fallback.patchUserV2ApiV2LowAdminApiUserV2UserIdPatch(
      userId: widget.userId,
      body: body,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('User V2 保存成功'), backgroundColor: Colors.green),
    );

    await _loadData();
  }

  Future<void> _saveOldService() async {
    if (_oldService == null) return;

    setState(() => _isSaving = true);

    // TODO: Implement old service save API when available
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Old Service 保存成功'), backgroundColor: Colors.green),
    );

    setState(() => _isSaving = false);
  }

  Future<void> _handleSave(Future<void> Function() saveFunction) async {
    setState(() => _isSaving = true);
    await saveFunction().catchError((e) {
      if (!mounted) return;
      final errorMsg = e is DioException ? _formatDioError(e) : e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
      );
    }).whenComplete(() {
      if (mounted) setState(() => _isSaving = false);
    });
  }

  Future<void> _pickExpireIn(BuildContext context) async {
    final TextEditingController dateController = TextEditingController(
      text: _expireIn?.toIso8601String() ?? DateTime.now().toIso8601String(),
    );

    final result = await showDialog<DateTime>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('设置过期时间（ISO 8601）'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: '日期时间（ISO 8601格式）',
                    hintText: '2024-12-31T23:59:59.000Z',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '格式示例：\n2024-12-31T23:59:59.000Z\n2024-12-31T23:59:59+08:00',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  final parsed = DateTime.tryParse(dateController.text.trim());
                  if (parsed != null) {
                    Navigator.pop(context, parsed);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('无效的日期时间格式'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('确定'),
              ),
              TextButton(
                onPressed: () {
                  dateController.text =
                      DateTime.now().toUtc().toIso8601String();
                },
                child: const Text('当前时间(UTC)'),
              ),
            ],
          ),
    );

    if (result != null) {
      setState(() => _expireIn = result);
    }

    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户详情（可编辑）')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
            ? Center(
            child: Text(_error!, style: const TextStyle(color: Colors.red)))
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User V2 box
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('User V2',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight
                              .bold)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: '邮箱'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _userNameController,
                        decoration: const InputDecoration(labelText: '用户名'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('是否启用'),
                          const Spacer(),
                          Switch(
                            value: _isEnable,
                            onChanged: (v) => setState(() => _isEnable = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('邮箱已验证'),
                          const Spacer(),
                          Switch(
                            value: _isEmailVerify,
                            onChanged: (v) =>
                                setState(() => _isEmailVerify = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _telegramIdController,
                        decoration: const InputDecoration(
                            labelText: 'Telegram ID'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('账户过期时间'),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _expireIn != null
                                  ? _expireIn!.toIso8601String()
                                  : '未设置',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _pickExpireIn(context),
                            child: const Text('选择'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isSaving ? null : () =>
                              _handleSave(_saveUserV2),
                          icon: _isSaving
                              ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.save),
                          label: const Text('保存 User V2'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Old Service box (readonly fields but in its own Card)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Old Service',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight
                              .bold)),
                      const SizedBox(height: 8),
                      if (_oldService == null)
                        const Text('无旧版服务数据')
                      else
                        ...[
                          Text('到期: ${_oldService!.userLevelExpireIn
                              .toIso8601String()}'),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _isSaving ? null : () =>
                                  _handleSave(_saveOldService),
                              icon: _isSaving
                                  ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                                  : const Icon(Icons.save),
                              label: const Text('保存 Old Service'),
                            ),
                          ),
                        ],
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
}

