import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/account_register_params_model.dart';
import 'package:fl_app1/api/models/check_invite_code_params_model.dart';
import 'package:fl_app1/api/models/request_email_code_params_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/captcha/captcha_export.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key, this.inviteCode});

  final String? inviteCode;

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _inviteCodeController = TextEditingController();

  bool _isRegistering = false;
  bool _isSendingCode = false;
  bool _isCheckingInvite = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  int _countdown = 0;
  bool _emailCodeSent = false;

  String? _verifyToken;
  bool _isVerifying = false;
  String? _captchaError;

  InviteCodeState _inviteCodeState = InviteCodeState.unchecked;
  String _inviteCodeMessage = '';

  Timer? _countdownTimer;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnim;

  // 邮箱白名单
  static const List<String> _emailWhitelist = <String>[
    'gmail.com',
    'yahoo.com',
    'hotmail.com',
    'outlook.com',
    'live.com',
    'msn.com',
    'aol.com',
    'icloud.com',
    'web.de',
    'gmx.de',
    'gmx.com',
    'mail.com',
    'yandex.com',
    'yandex.ru',
    'mail.ru',
    'rambler.ru',
    'protonmail.com',
    'tutanota.com',
    'zoho.com',
    '163.com',
    '126.com',
    'yeah.net',
    'vip.163.com',
    'vip.126.com',
    'qq.com',
    'sina.com',
    'sina.cn',
    'vip.sina.com',
    'sohu.com',
    'vip.sohu.com',
    'tom.com',
    '21cn.com',
    'aliyun.com',
    'alibaba-inc.com',
    'china.com',
    'chinaren.com',
    '139.com',
  ];

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

    // 如果有邀请码参数，设置并校验
    if (widget.inviteCode != null && widget.inviteCode!.isNotEmpty) {
      _inviteCodeController.text = widget.inviteCode!;
      Future<void>.delayed(const Duration(milliseconds: 500), _checkInviteCode);
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _shakeController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _emailCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0);
  }

  bool _validateEmail(String value) {
    final RegExp emailReg = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailReg.hasMatch(value)) {
      return false;
    }
    final String domain = value.split('@')[1];
    return _emailWhitelist.contains(domain);
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
    });

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);
    final CaptchaService captchaService = CaptchaService.instance;

    final String verifyToken = await captchaService
        .getVerifyToken(restClient: rest)
        .catchError((Object e) {
          setState(() {
            _captchaError = e.toString();
            _isVerifying = false;
          });
          return '';
        });

    if (verifyToken.isNotEmpty) {
      setState(() {
        _verifyToken = verifyToken;
        _isVerifying = false;
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

  Future<void> _checkInviteCode() async {
    final String inviteCode = _inviteCodeController.text.trim();
    if (inviteCode.isEmpty) {
      setState(() {
        _inviteCodeState = InviteCodeState.unchecked;
        _inviteCodeMessage = '';
      });
      return;
    }

    setState(() {
      _isCheckingInvite = true;
      _inviteCodeState = InviteCodeState.checking;
      _inviteCodeMessage = '正在校验邀请码...';
    });

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    try {
      final CheckInviteCodeParamsModel body = CheckInviteCodeParamsModel(
        inviteCode: inviteCode,
      );

      final response = await rest.fallback
          .postCheckInviteCodeApiV2AuthAccountRegisterCheckInviteCodePost(
            body: body,
          );

      if (!mounted) return;

      setState(() {
        _isCheckingInvite = false;
        if (response.isSuccess) {
          _inviteCodeState = InviteCodeState.valid;
          _inviteCodeMessage = response.message.isNotEmpty
              ? response.message
              : '邀请码有效';
        } else {
          _inviteCodeState = InviteCodeState.invalid;
          _inviteCodeMessage = response.message.isNotEmpty
              ? response.message
              : '邀请码无效或已使用';
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isCheckingInvite = false;
        _inviteCodeState = InviteCodeState.invalid;
        _inviteCodeMessage = '校验邀请码时发生错误';
      });
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
          .postRequestEmailCodeApiV2AuthAccountRegisterRequestEmailCodePost(
            body: body,
          );

      if (!mounted) return;

      setState(() => _isSendingCode = false);

      if (response.isSuccess) {
        setState(() => _emailCodeSent = true);

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

      setState(() => _isSendingCode = false);

      final String message = e.response?.data?['message'] ?? '发送验证码失败，请稍后重试';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _isSendingCode = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发送验证码失败: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _handleRegister() async {
    final FormState? form = _formKey.currentState;
    final bool isValid = form?.validate() ?? false;

    if (!isValid) {
      _triggerShake();
      return;
    }

    if (_verifyToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请先完成POW验证码验证'),
          backgroundColor: Colors.red,
        ),
      );
      _triggerShake();
      return;
    }

    setState(() => _isRegistering = true);

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    try {
      final AccountRegisterParamsModel body = AccountRegisterParamsModel(
        name: _nicknameController.text.trim(),
        email: _emailController.text.trim(),
        emailCode: _emailCodeController.text.trim(),
        password: _passwordController.text,
        rePassword: _confirmPasswordController.text,
        inviteCode: _inviteCodeController.text.trim().isEmpty
            ? null
            : _inviteCodeController.text.trim(),
      );

      final result = await rest.fallback.postIndexApiV2AuthAccountRegisterPost(
        body: body,
      );

      if (!mounted) return;

      setState(() => _isRegistering = false);

      if (result.isSuccess) {
        _showSuccessDialog();
      } else {
        // 注册失败，重置POW验证令牌
        setState(() {
          _verifyToken = null;
          _captchaError = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.message}\n请重新进行POW验证'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
        _triggerShake();
      }
    } on DioException catch (e) {
      setState(() {
        _isRegistering = false;
        _verifyToken = null;
        _captchaError = null;
      });

      if (!mounted) return;

      final String message = e.response?.data?['message'] ?? '注册失败，请稍后重试';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$message\n请重新进行POW验证'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
      _triggerShake();
    } catch (e) {
      setState(() {
        _isRegistering = false;
        _verifyToken = null;
        _captchaError = null;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e\n请重新进行POW验证'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
      _triggerShake();
    }
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('注册成功'),
          content: const Text('恭喜您注册成功！即将跳转到登录页面...'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.router.pushPath('/auth/login');
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );

    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop();
        context.router.pushPath('/auth/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户注册')),
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
                          '用户注册',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // 昵称
                        TextFormField(
                          controller: _nicknameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: '昵称',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '昵称不能为空';
                            }
                            if (v.length < 2) {
                              return '昵称至少2个字符';
                            }
                            if (v.length > 20) {
                              return '昵称不能超过20个字符';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 邮箱
                        TextFormField(
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: '邮箱',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            helperText: '支持主流邮箱服务商',
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '邮箱不能为空';
                            }
                            if (!_validateEmail(v)) {
                              return '邮箱格式不正确或不在白名单内';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // POW验证码（移到邮箱后面）
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
                                child: const Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '正在计算POW验证码，请稍候...',
                                        style: TextStyle(color: Colors.blue),
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

                        // 邮箱验证码
                        TextFormField(
                          controller: _emailCodeController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: const InputDecoration(
                            labelText: '邮箱验证码',
                            prefixIcon: Icon(Icons.confirmation_number),
                            border: OutlineInputBorder(),
                            counterText: '',
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

                        // 密码
                        TextFormField(
                          controller: _passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: '密码',
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

                        // 确认密码
                        TextFormField(
                          controller: _confirmPasswordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !_showConfirmPassword,
                          decoration: InputDecoration(
                            labelText: '确认密码',
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
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '确认密码不能为空';
                            }
                            if (v != _passwordController.text) {
                              return '两次输入的密码不一致';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 邀请码
                        TextFormField(
                          controller: _inviteCodeController,
                          decoration: InputDecoration(
                            labelText: '邀请码（可选）',
                            prefixIcon: const Icon(Icons.card_giftcard),
                            border: const OutlineInputBorder(),
                            suffixIcon: _isCheckingInvite
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : _inviteCodeState == InviteCodeState.valid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : _inviteCodeState == InviteCodeState.invalid
                                ? const Icon(Icons.error, color: Colors.red)
                                : null,
                            helperText:
                                _inviteCodeMessage.isNotEmpty &&
                                    _inviteCodeState != InviteCodeState.invalid
                                ? _inviteCodeMessage
                                : null,
                            errorText:
                                _inviteCodeState == InviteCodeState.invalid
                                ? _inviteCodeMessage
                                : null,
                          ),
                          onChanged: (String v) {
                            if (v.isEmpty) {
                              setState(() {
                                _inviteCodeState = InviteCodeState.unchecked;
                                _inviteCodeMessage = '';
                              });
                            }
                          },
                          onFieldSubmitted: (String v) {
                            if (v.isNotEmpty) {
                              _checkInviteCode();
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // 注册按钮
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isRegistering ? null : _handleRegister,
                            child: _isRegistering
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    '注册',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 返回登录
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('已有账号？'),
                            TextButton(
                              onPressed: () =>
                                  context.router.pushPath('/auth/login'),
                              child: const Text('立即登录'),
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

enum InviteCodeState { unchecked, checking, valid, invalid }
