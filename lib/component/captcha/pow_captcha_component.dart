import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/captcha/captcha_export.dart';
import 'package:flutter/material.dart';

/// POW验证码组件
///
/// 提供可视化的验证码计算界面
/// 使用方式：点击按钮后自动执行POW计算
class POWCaptchaComponent extends StatefulWidget {
  const POWCaptchaComponent({
    super.key,
    required this.restClient,
    required this.onVerified,
    this.buttonText = '获取验证',
    this.verifyingText = '验证中...',
  });

  final RestClient restClient;
  final void Function(String verifyToken) onVerified;
  final String buttonText;
  final String verifyingText;

  @override
  State<POWCaptchaComponent> createState() => _POWCaptchaComponentState();
}

class _POWCaptchaComponentState extends State<POWCaptchaComponent> {
  bool _isVerifying = false;
  String? _verifyToken;
  String? _errorMessage;

  Future<void> _handleVerify() async {
    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    final CaptchaService captchaService = CaptchaService.instance;

    final String verifyToken = await captchaService
        .getVerifyToken(restClient: widget.restClient)
        .catchError((Object e) {
          setState(() {
            _errorMessage = e.toString();
            _isVerifying = false;
          });
          return '';
        });

    if (verifyToken.isNotEmpty) {
      setState(() {
        _verifyToken = verifyToken;
        _isVerifying = false;
      });
      widget.onVerified(verifyToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_verifyToken != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('验证成功', style: TextStyle(color: Colors.green)),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _verifyToken = null;
                  _errorMessage = null;
                });
              },
            ),
          ],
        ),
      );
    }

    if (_isVerifying) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.verifyingText,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: _handleVerify,
          icon: const Icon(Icons.security),
          label: Text(widget.buttonText),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
