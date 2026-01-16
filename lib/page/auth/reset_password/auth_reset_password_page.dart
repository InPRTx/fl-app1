import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/account_reset_password_params_model.dart';
import 'package:fl_app1/api/models/request_email_code_params_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/captcha/captcha_export.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthResetPasswordPage extends StatefulWidget {
  const AuthResetPasswordPage({super.key});

  @override
  State<AuthResetPasswordPage> createState() => _AuthResetPasswordPageState();
}

class _AuthResetPasswordPageState extends State<AuthResetPasswordPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isResetting = false;
  bool _isSendingCode = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  int _countdown = 0;
  bool _emailCodeSent = false;

  // POW 验证相关（只用于发送邮件）
  String? _verifyToken;
  bool _isVerifying = false;
  String? _captchaError;
  int _powProgress = 0;
  int _powTotal = 0;

  Timer? _countdownTimer;

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
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: -8.0),
          weight: 10,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -8.0, end: 8.0),
          weight: 20,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 8.0, end: -6.0),
          weight: 20,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -6.0, end: 6.0),
          weight: 20,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 6.0, end: 0.0),
          weight: 30,
        ),
      ],
    ).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));

    _shakeController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reset();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _shakeController.dispose();
    _emailController.dispose();
    _emailCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0);
  }

  bool _validateEmail(String value) {
    final RegExp emailReg = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    return emailReg.hasMatch(value);
  }

  bool get _isEmailValid {
    final String email = _emailController.text.trim();
    return _validateEmail(email);
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

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _countdown = 60;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _sendEmailCode() async {
    if (!_isEmailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入有效的邮箱地址'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 检查是否已获取POW验证令牌
    if (_verifyToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请先完成POW验证码验证'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSendingCode = true);

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    try {
      final RequestEmailCodeParamsModel body = RequestEmailCodeParamsModel(
        email: _emailController.text.trim(),
        verifyToken: _verifyToken!,
      );

      final response = await rest.fallback
          .postRequestEmailCodeApiV2AuthAccountResetPasswordRequestEmailCodePost(
            body: body,
          );

      if (!mounted) return;

      setState(() {
        _isSendingCode = false;
        // 无论成功还是失败，都重置 POW 验证令牌
        _verifyToken = null;
        _captchaError = null;
      });

      if (response.isSuccess) {
        setState(() {
          _emailCodeSent = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message.isNotEmpty ? response.message : '验证码已发送到您的邮箱',
            ),
            backgroundColor: Colors.green,
          ),
        );

        _startCountdown();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message.isNotEmpty ? response.message : '发送验证码失败',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;

      setState(() {
        _isSendingCode = false;
        // 发送失败也要重置 POW 验证令牌
        _verifyToken = null;
        _captchaError = null;
      });

      final String message = e.response?.data?['message'] ?? '发送验证码失败，请稍后重试';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSendingCode = false;
        // 发送失败也要重置 POW 验证令牌
        _verifyToken = null;
        _captchaError = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发送验证码失败: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _handleResetPassword() async {
    final FormState? form = _formKey.currentState;
    final bool isValid = form?.validate() ?? false;

    if (!isValid) {
      _triggerShake();
      return;
    }

    setState(() => _isResetting = true);

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    try {
      final AccountResetPasswordParamsModel body =
          AccountResetPasswordParamsModel(
            email: _emailController.text.trim(),
            emailCode: _emailCodeController.text.trim(),
            password: _passwordController.text,
          );

      final result = await rest.fallback
          .postIndexApiV2AuthAccountResetPasswordPost(body: body);

      if (!mounted) return;

      setState(() => _isResetting = false);

      if (result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.message.isNotEmpty ? result.message : '密码重置成功',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // 延迟跳转到登录页
        await Future<void>.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        context.router.pushPath('/auth/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
        _triggerShake();
      }
    } on DioException catch (e) {
      setState(() => _isResetting = false);

      if (!mounted) return;

      final String message = e.response?.data?['message'] ?? '密码重置失败，请稍后重试';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
      _triggerShake();
    } catch (e) {
      setState(() => _isResetting = false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('密码重置失败: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
      _triggerShake();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('找回密码')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedBuilder(
            animation: _shakeAnim,
            builder: (BuildContext context, Widget? child) {
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
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          '找回密码',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '在下面输入您的信息以找回您的帐户',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // 邮箱
                        TextFormField(
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: '邮箱地址',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            helperText: '请输入您注册时使用的邮箱地址',
                          ),
                          onChanged: (String value) {
                            // 触发 UI 更新，确保发送验证码按钮状态正确
                            setState(() {});
                          },
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '邮箱不能为空';
                            }
                            if (!_validateEmail(v)) {
                              return '邮箱格式不正确';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

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
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                      child: Text(
                                        '验证成功',
                                        style: TextStyle(color: Colors.green),
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
                            else if (_isVerifying)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                _powTotal * 100).toInt()}%'
                                                : '正在计算 POW 验证码，请稍候...',
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: _powTotal > 0 ? _powProgress /
                                          _powTotal : null,
                                      backgroundColor: Colors.blue.withValues(
                                          alpha: 0.2),
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
                        const SizedBox(height: 16),

                        // 发送验证码按钮
                        ElevatedButton.icon(
                          onPressed:
                              _isEmailValid &&
                                  !_isSendingCode &&
                                  _countdown == 0 &&
                                  _verifyToken != null
                              ? _sendEmailCode
                              : null,
                          icon: _isSendingCode
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send),
                          label: Text(
                            _countdown > 0
                                ? '重新发送 $_countdown s'
                                : _emailCodeSent
                                ? '重新发送验证码'
                                : '发送验证码',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 验证码成功提示
                        if (_emailCodeSent)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green),
                            ),
                            child: const Row(
                              children: <Widget>[
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '验证码已发送，请查收邮箱。',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // 邮箱验证码
                        TextFormField(
                          controller: _emailCodeController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: const InputDecoration(
                            labelText: '验证码',
                            prefixIcon: Icon(Icons.shield_outlined),
                            border: OutlineInputBorder(),
                            counterText: '',
                            hintText: '请输入6位验证码',
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '验证码不能为空';
                            }
                            if (!RegExp(r'^\d{6}$').hasMatch(v)) {
                              return '验证码必须是6位数字';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 新密码
                        TextFormField(
                          controller: _passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: '新密码',
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(
                                () => _showPassword = !_showPassword,
                              ),
                            ),
                            helperText: '至少8个字符，包含大小写字母和数字',
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '密码不能为空';
                            }
                            if (v.length < 8) {
                              return '密码至少8个字符';
                            }
                            if (v.length > 50) {
                              return '密码不能超过50个字符';
                            }
                            if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
                            ).hasMatch(v)) {
                              return '密码必须包含大小写字母和数字';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 确认新密码
                        TextFormField(
                          controller: _confirmPasswordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !_showConfirmPassword,
                          decoration: InputDecoration(
                            labelText: '确认新密码',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(
                                () => _showConfirmPassword =
                                    !_showConfirmPassword,
                              ),
                            ),
                            hintText: '再次输入新密码',
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '确认密码不能为空';
                            }
                            if (v != _passwordController.text) {
                              return '两次密码不一致';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // 重置密码按钮
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isResetting
                                ? null
                                : _handleResetPassword,
                            child: _isResetting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    '重置密码',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Divider(),
                        const SizedBox(height: 8),

                        // 返回登录
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('已经有账号？'),
                            TextButton(
                              onPressed: () =>
                                  context.router.pushPath('/auth/login'),
                              child: const Text('登录'),
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
      ),
    );
  }
}
