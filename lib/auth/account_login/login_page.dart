import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/login_post_result_model.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart'
    as api_models;
import 'package:fl_app1/api/rest_client.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _twoFaController = TextEditingController();

  bool _rememberMe = false;
  bool _isLoggingIn = false;
  String? _captchaToken;
  int _captchaKeyCounter = 0;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnim;

  // Fixed captcha_key as requested
  static const String _fixedCaptchaKey = 'a9539556-9cbf-45e7-8ccd-db408ce6af33';

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeAnim = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 10),
        TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 20),
        TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 20),
        TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 20),
        TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 30),
      ],
    ).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));

    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reset();
      }
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _twoFaController.dispose();
    super.dispose();
  }

  bool _validateEmail(String value) {
    final emailReg = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    return emailReg.hasMatch(value);
  }

  void _triggerShake() {
    _shakeController.forward(from: 0);
  }

  Future<void> _handleSubmit() async {
    final form = _formKey.currentState;
    final isValid = form?.validate() ?? false;
    if (!isValid || _captchaToken == null) {
      if (_captchaToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('请先完成验证码验证'),
            backgroundColor: Colors.red,
          ),
        );
      }
      _triggerShake();
      return;
    }

    setState(() => _isLoggingIn = true);

    // Default base URL - match VersionPage default
    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    final body =
        api_models.WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          captchaKey: _fixedCaptchaKey,
          tiago2CapToken: _captchaToken!,
          isRememberMe: _rememberMe,
          twoFaCode: _twoFaController.text.isEmpty
              ? null
              : _twoFaController.text.trim(),
        );

    try {
      final LoginPostResultModel result = await rest.fallback
          .loginPostApiV2AuthAccountLoginLoginPost(body: body);

      if (!mounted) return;

      setState(() => _isLoggingIn = false);

      // Use API response to inform the user. If API reports failure, show its message.
      if (!result.isSuccess) {
        final msg = result.message.isNotEmpty
            ? result.message
            : '登录失败，请稍后重试';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        _triggerShake();
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message.isNotEmpty
              ? result.message
              : '欢迎回来，${_emailController.text}'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } on DioException catch (e) {
      setState(() => _isLoggingIn = false);

      // Show error similar to VersionPage for debugging
      final req = e.requestOptions;
      final uri = req.uri.toString();
      final type = e.type.name;
      String message = e.message ?? e.toString();
      final resp = e.response;
      String respText = '';
      if (resp != null) {
        final body = resp.data;
        try {
          respText = body?.toString() ?? '<empty>';
        } catch (_) {
          respText = '<non-string response>';
        }
        message = 'HTTP ${resp.statusCode}\n$respText';
      }

      final sb = StringBuffer();
      sb.writeln('DioException: $type');
      sb.writeln('URI: $uri');
      sb.writeln('Message: $message');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(sb.toString()),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e, st) {
      setState(() => _isLoggingIn = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e\n\n$st'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _toggleCaptcha() {
    // Simple placeholder for captcha: toggles a token and bumps counter to force rebuild
    setState(() {
      if (_captchaToken == null) {
        _captchaToken = 'token_${DateTime.now().millisecondsSinceEpoch}';
      } else {
        _captchaToken = null;
      }
      _captchaKeyCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedBuilder(
            animation: _shakeAnim,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_shakeAnim.value, 0),
                child: child,
              );
            },
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('使用邮箱和密码登录', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 12),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: '邮箱地址',
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return '请输入邮箱';
                                }
                                if (!_validateEmail(v)) return '请输入有效邮箱';
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: '密码',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return '请输入密码';
                                if (v.length < 6) return '密码至少6位';
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _twoFaController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: '两步验证码 (可选)',
                                prefixIcon: Icon(Icons.shield),
                              ),
                              maxLength: 6,
                              validator: (v) {
                                if (v == null || v.isEmpty) return null;
                                if (!RegExp(r"^\d{6}$").hasMatch(v)) {
                                  return '验证码必须是6位数字';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v ?? false),
                                ),
                                const Text('记住我'),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Captcha placeholder
                            Column(
                              children: [
                                const Text('👇👇点击下方验证以完成验证码'),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: _toggleCaptcha,
                                  child: Container(
                                    key: ValueKey<int>(_captchaKeyCounter),
                                    width: double.infinity,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                      color: _captchaToken == null
                                          ? Colors.white
                                          : Colors.green.shade50,
                                    ),
                                    alignment: Alignment.center,
                                    child: _captchaToken == null
                                        ? const Text(
                                            '点击此处进行验证码验证',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                '已通过验证',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoggingIn ? null : _handleSubmit,
                                child: _isLoggingIn
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('登录'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          // Navigate to forgot password - placeholder
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('忘记密码页面尚未实现')),
                          );
                        },
                        child: const Text('忘记密码？'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('还没有账号？'),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('注册页面尚未实现')),
                              );
                            },
                            child: const Text('注册'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
