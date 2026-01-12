import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/login_post_result_model.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:fl_app1/store/service/captcha/captcha_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _twoFaController = TextEditingController();
  final AuthStore _authStore = AuthStore();

  bool _rememberMe = false;
  bool _isLoggingIn = false;
  String? _verifyToken;
  bool _isVerifying = false;
  String? _captchaError;
  int _powProgress = 0;
  int _powTotal = 0;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnim;


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
    final FormState? form = _formKey.currentState;
    final bool isValid = form?.validate() ?? false;
    if (!isValid || _verifyToken == null) {
      if (_verifyToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('请先完成POW验证码验证'),
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
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    final WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel body =
    WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      verifyToken: _verifyToken,
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
        final String msg = result.message.isNotEmpty
            ? result.message
            : '登录失败，请稍后重试';

        // 重置POW验证令牌，要求用户重新验证
        setState(() {
          _verifyToken = null;
          _captchaError = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$msg\n请重新进行POW验证'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        _triggerShake();
        return;
      }

      // Save tokens to auth store
      await _authStore.setTokens(
        result.result.accessToken,
        result.result.refreshToken,
      );

      // 通知系统保存自动填充凭据
      TextInput.finishAutofillContext(shouldSave: true);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.message.isNotEmpty
                ? result.message
                : '欢迎回来，${_emailController.text}',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // 跳转到用户仪表板
      context.router.pushPath('/user/dashboard');
    } on DioException catch (e) {
      setState(() {
        _isLoggingIn = false;
        // 重置POW验证令牌
        _verifyToken = null;
        _captchaError = null;
      });

      // Show error similar to VersionPage for debugging
      final RequestOptions req = e.requestOptions;
      final String uri = req.uri.toString();
      final String type = e.type.name;
      String message = e.message ?? e.toString();
      final Response<dynamic>? resp = e.response;
      String respText = '';
      if (resp != null) {
        final dynamic body = resp.data;
        try {
          respText = body?.toString() ?? '<empty>';
        } catch (_) {
          respText = '<non-string response>';
        }
        message = 'HTTP ${resp.statusCode}\n$respText';
      }

      final StringBuffer sb = StringBuffer();
      sb.writeln('DioException: $type');
      sb.writeln('URI: $uri');
      sb.writeln('Message: $message');
      sb.writeln('\n请重新进行POW验证');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(sb.toString()),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e, st) {
      setState(() {
        _isLoggingIn = false;
        // 重置POW验证令牌
        _verifyToken = null;
        _captchaError = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e\n\n$st\n\n请重新进行POW验证'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> _handlePOWVerify() async {
    setState(() {
      _isVerifying = true;
      _captchaError = null;
      _verifyToken = null;
      _powProgress = 0;
      _powTotal = 0;
    });

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);
    final CaptchaService captchaService = CaptchaService.instance;

    final String verifyToken = await captchaService
        .getVerifyToken(
      restClient: rest,
      onProgress: (int current, int total) {
        print('POW Progress: $current / $total');
        if (mounted) {
          setState(() {
            _powProgress = current;
            _powTotal = total;
          });
        }
      },
    )
        .catchError((Object e) {
      setState(() {
        _captchaError = e.toString();
        _isVerifying = false;
        _powProgress = 0;
        _powTotal = 0;
      });
      return '';
    });

    if (verifyToken.isNotEmpty) {
      setState(() {
        _verifyToken = verifyToken;
        _isVerifying = false;
        _powProgress = 0;
        _powTotal = 0;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('POW验证码验证成功'),
          backgroundColor: Colors.green,
        ),
      );
    }
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
                      AutofillGroup(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              maxLength: 100,
                              autofillHints: const [AutofillHints.email],
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: '邮箱地址',
                                prefixIcon: Icon(Icons.email),
                                hintText: 'example@email.com',
                                counterText: '',
                              ),
                              validator: (String? v) {
                                if (v == null || v.isEmpty) {
                                  return '请输入邮箱';
                                }
                                if (!_validateEmail(v)) {
                                  return '请输入有效邮箱';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _passwordController,
                              obscureText: true,
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: '密码',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: (String? v) {
                                if (v == null || v.isEmpty) {
                                  return '请输入密码';
                                }
                                if (v.length < 6) {
                                  return '密码至少6位';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _twoFaController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              autofillHints: const [AutofillHints.oneTimeCode],
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                labelText: '两步验证码 (可选)',
                                prefixIcon: Icon(Icons.shield),
                                hintText: '123456',
                                helperText: '请输入6位数字验证码',
                                counterText: '',
                              ),
                              validator: (String? v) {
                                if (v == null || v.isEmpty) {
                                  return null;
                                }
                                if (v.length != 6) {
                                  return '验证码必须是6位数字';
                                }
                                if (!RegExp(r"^\d{6}$").hasMatch(v)) {
                                  return '验证码只能包含数字';
                                }
                                return null;
                              },
                              onChanged: (v) {
                                if (v.length > 6) {
                                  _twoFaController.text = v.substring(0, 6);
                                  _twoFaController.selection =
                                      TextSelection.fromPosition(
                                        const TextPosition(offset: 6),
                                      );
                                }
                              },
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v ?? false),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                    () => _rememberMe = !_rememberMe,
                                  ),
                                  child: const Text('记住我'),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 8),
                              // POW验证码
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const Text(
                                  'POW验证码验证',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_verifyToken != null)
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(
                                          alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.green),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(Icons.check_circle,
                                            color: Colors.green),
                                        const SizedBox(width: 8),
                                        const Expanded(
                                          child: Text(
                                            '验证成功',
                                            style: TextStyle(
                                                color: Colors.green),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.refresh),
                                          onPressed: () {
                                            setState(() {
                                              _verifyToken = null;
                                              _captchaError = null;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  if (_isVerifying)
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withValues(
                                            alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.blue),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                    strokeWidth: 2),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  _powTotal > 0
                                                      ? '正在计算 POW 验证码... ${(_powProgress /
                                                      _powTotal * 100)
                                                      .toInt()}%'
                                                      : '正在计算 POW 验证码，请稍候...',
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          LinearProgressIndicator(
                                            value: _powTotal > 0
                                                ? _powProgress / _powTotal
                                                : null,
                                            backgroundColor: Colors.blue
                                                .withValues(alpha: 0.2),
                                            valueColor: const AlwaysStoppedAnimation<
                                                Color>(Colors.blue),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _powTotal > 0
                                                ? '$_powProgress / $_powTotal'
                                                : '准备中...',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    ElevatedButton.icon(
                                      onPressed: _handlePOWVerify,
                                      icon: const Icon(Icons.security),
                                      label: const Text('获取POW验证'),
                                  ),
                                if (_captchaError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _captchaError!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
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
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () =>
                            context.router.pushPath('/auth/reset-password'),
                        child: const Text('忘记密码？'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('还没有账号？'),
                          TextButton(
                            onPressed: () =>
                                context.router.pushPath('/auth/register'),
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
