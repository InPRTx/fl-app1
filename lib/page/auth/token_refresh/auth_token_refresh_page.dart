import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthTokenRefreshPage extends StatefulWidget {
  const AuthTokenRefreshPage({
    super.key,
    @QueryParam('returnPath') this.returnPath,
  });

  final String? returnPath;

  @override
  State<AuthTokenRefreshPage> createState() => _AuthTokenRefreshPageState();
}

class _AuthTokenRefreshPageState extends State<AuthTokenRefreshPage> {
  bool _isRefreshing = false;
  String _statusMessage = '正在刷新登录令牌...';
  bool _hasError = false;
  int _retryCount = 0;

  @override
  void initState() {
    super.initState();
    _startTokenRefresh();
  }

  Future<void> _startTokenRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
      _hasError = false;
      _statusMessage = '正在刷新登录令牌...';
    });

    final bool success = await AuthStore().apiRefreshToken();

    if (!mounted) return;

    if (success) {
      setState(() {
        _statusMessage = '令牌刷新成功！正在返回...';
      });

      // 延迟一下让用户看到成功消息
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // 返回到之前的页面
      if (widget.returnPath != null && widget.returnPath!.isNotEmpty) {
        context.router.pushPath(widget.returnPath!);
      } else {
        context.router.pushPath('/');
      }
    } else {
      setState(() {
        _isRefreshing = false;
        _hasError = true;
        _retryCount++;
        _statusMessage = '令牌刷新失败';
      });
    }
  }

  Future<void> _handleLogout() async {
    await AuthStore().logout();
    if (!mounted) return;
    context.router.pushPath('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 图标
                      if (_isRefreshing)
                        const SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepPurple,
                            ),
                          ),
                        )
                      else if (_hasError)
                        Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Colors.red.shade400,
                        )
                      else
                        Icon(
                          Icons.check_circle_outline,
                          size: 80,
                          color: Colors.green.shade400,
                        ),

                      const SizedBox(height: 24),

                      // 状态文字
                      Text(
                        _statusMessage,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),

                      if (_hasError) ...[
                        const SizedBox(height: 12),
                        Text(
                          '登录令牌已过期或无效',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '尝试次数: $_retryCount',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade500),
                        ),
                      ],

                      if (_hasError) ...[
                        const SizedBox(height: 32),

                        // 操作按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // 重试按钮
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _startTokenRefresh,
                                icon: const Icon(Icons.refresh),
                                label: const Text('重试'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  side: BorderSide(
                                    color: Colors.deepPurple.shade400,
                                    width: 2,
                                  ),
                                  foregroundColor: Colors.deepPurple.shade400,
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // 重新登录按钮
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _handleLogout,
                                icon: const Icon(Icons.login),
                                label: const Text('重新登录'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  backgroundColor: Colors.deepPurple.shade400,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      if (_isRefreshing) ...[
                        const SizedBox(height: 24),
                        Text(
                          '请稍候...',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
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
