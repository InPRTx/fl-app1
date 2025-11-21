import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/login_post_result_model.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AuthSimpleLoginPage extends StatefulWidget {
  const AuthSimpleLoginPage({super.key});

  @override
  State<AuthSimpleLoginPage> createState() => _AuthSimpleLoginPageState();
}

class _AuthSimpleLoginPageState extends State<AuthSimpleLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthStore _authStore = AuthStore();

  bool _isLoading = false;
  static const String _captchaKey = 'a9539556-9cbf-45e7-8ccd-db408ce6af33';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    final body = WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      captchaKey: _captchaKey,
      tiago2CapToken: 'auto_${DateTime.now().millisecondsSinceEpoch}',
      isRememberMe: true,
    );

    final LoginPostResultModel result = await rest.fallback
        .loginPostApiV2AuthAccountLoginLoginPost(body: body);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (!result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message.isNotEmpty ? result.message : '登录失败'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _authStore.setTokens(
      result.result.accessToken,
      result.result.refreshToken,
    );

    TextInput.finishAutofillContext(shouldSave: true);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('登录成功，欢迎回来！'), backgroundColor: Colors.green),
    );

    context.go('/user/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('简洁登录')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: AutofillGroup(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_circle, size: 80),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: '邮箱',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return '请输入邮箱';
                            }
                            if (!RegExp(
                              r"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                            ).hasMatch(v)) {
                              return '邮箱格式不正确';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _login(),
                          decoration: const InputDecoration(
                            labelText: '密码',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
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
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    '登录',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
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
