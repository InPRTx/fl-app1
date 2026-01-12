# POW 验证码使用指南

## 快速开始

### 1. 在登录页面使用

登录页面已经集成了 POW 验证码功能。用户流程：

1. 填写邮箱和密码
2. 点击"获取POW验证"按钮
3. 等待 1-10 秒计算完成
4. 看到绿色"验证成功"提示
5. 点击"登录"按钮

### 2. 在其他页面集成

#### 方法 A: 使用可复用组件

```dart
import 'package:fl_app1/component/captcha/pow_captcha_component.dart';
import 'package:fl_app1/api/rest_client.dart';

class YourPage extends StatefulWidget {
  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  String? _verifyToken;
  late RestClient _restClient;

  @override
  void initState() {
    super.initState();
    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    _restClient = RestClient(dio, baseUrl: kDefaultBaseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        POWCaptchaComponent(
          restClient: _restClient,
          onVerified: (String verifyToken) {
            setState(() {
              _verifyToken = verifyToken;
            });
          },
          buttonText: '获取验证',
          verifyingText: '验证中...',
        ),
        // 其他 UI
      ],
    );
  }
}
```

#### 方法 B: 直接调用服务

```dart
import 'package:fl_app1/store/service/captcha/captcha_export.dart';

Future<void> yourFunction() async {
  final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
  final RestClient rest = RestClient(dio, baseUrl: kDefaultBaseUrl);
  final CaptchaService captchaService = CaptchaService.instance;

  // 获取 verify_token
  final String verifyToken = await captchaService.getVerifyToken(
    restClient: rest,
  );

  // 使用 verify_token 调用 API
  final body = YourApiModel(
    // ... 其他字段
    verifyToken: verifyToken,
  );

  await rest.yourApi.yourMethod(body: body);
}
```

### 3. 注册页面集成示例

```dart
// 在注册页面添加 POW 验证
class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _verifyToken;
  bool _isVerifying = false;
  String? _captchaError;

  late RestClient _restClient;

  @override
  void initState() {
    super.initState();
    final Dio dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    _restClient = RestClient(dio, baseUrl: kDefaultBaseUrl);
  }

  Future<void> _handlePOWVerify() async {
    setState(() {
      _isVerifying = true;
      _captchaError = null;
      _verifyToken = null;
    });

    final CaptchaService captchaService = CaptchaService.instance;

    final String verifyToken = await captchaService
        .getVerifyToken(restClient: _restClient)
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
    }
  }

  Future<void> _handleRegister() async {
    if (_verifyToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先完成POW验证')),
      );
      return;
    }

    // 调用注册 API
    final body = RegisterModel(
      email: _emailController.text,
      password: _passwordController.text,
      verifyToken: _verifyToken,
      // ... 其他字段
    );

    await _restClient.yourApi.register(body: body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 邮箱、密码等字段

        // POW 验证码
        if (_verifyToken != null)
          Container(
            // 验证成功 UI
          )
        else
          if (_isVerifying)
            Container(
              // 验证中 UI
            )
          else
            ElevatedButton(
              onPressed: _handlePOWVerify,
              child: const Text('获取POW验证'),
            ),

        if (_captchaError != null)
          Text(_captchaError!, style: TextStyle(color: Colors.red)),

        // 注册按钮
        ElevatedButton(
          onPressed: _handleRegister,
          child: const Text('注册'),
        ),
      ],
    );
  }
}
```

## API 接口说明

### 需要 verify_token 的接口

根据后端配置，以下接口可能需要 `verify_token`：

#### V2 接口（必须）

- `POST /api/v2/auth/account-login/login` - 登录
- `POST /api/v2/auth/account-register/` - 注册
- `POST /api/v2/auth/account-reset-password/` - 找回密码

#### V1 接口（可选，取决于配置）

- `POST /v1/auth/login` - 登录

### 参数说明

```dart

final body = ApiModel(
  // ... 其他必填字段
  verifyToken: _verifyToken, // POW 验证令牌（可选或必填）
);
```

## 错误处理

### 常见错误及解决方案

| 错误信息         | 原因                    | 解决方案              |
|--------------|-----------------------|-------------------|
| 请先完成POW验证码验证 | 未获取 verify_token      | 点击"获取POW验证"按钮     |
| 验证码已过期       | verify_token 超过 15 分钟 | 重新获取 verify_token |
| 令牌验证失败       | IP 地址变更               | 重新获取 verify_token |
| 验证码已被使用      | verify_token 已消费      | 重新获取 verify_token |

### 错误处理示例

```dart
try {
final String verifyToken = await captchaService.getVerifyToken(
restClient: rest,
);

// 使用 verifyToken
} catch (e) {
if (e.toString().contains('过期')) {
// 提示用户验证码已过期
showDialog(...);
} else if (e.toString().contains('IP')) {
// 提示用户网络环境变更
showDialog(...);
} else {
// 通用错误处理
showDialog(...);
}
}
```

## 性能优化建议

### 1. 预加载验证码

在用户填写表单时预先计算：

```dart
@override
void initState() {
  super.initState();
  // 页面加载时就开始计算验证码
  _handlePOWVerify();
}
```

### 2. 缓存未使用的 Token

如果用户取消操作，可以保留 token 供下次使用（注意 15 分钟有效期）：

```dart
DateTime? _tokenExpireTime;

if (
_tokenExpireTime != null &&
DateTime.now().isBefore(_tokenExpireTime)) {
// 使用缓存的 token
} else {
// 重新获取
}
```

### 3. 显示进度提示

告知用户预计等待时间：

```dart
Text
('正在计算POW验证码，预计需要 3-8 秒...
'
)
```

## 测试建议

### 单元测试

```dart
test
('POW solution verification
'
, () {
String capId = '01937a2e-1234-7abc-9def-0123456789ab';
int index = 0;
int solution = 12345;

String data = '$index$capId$solution';
var hash = sha256.convert(utf8.encode(data));

expect(hash.toString().startsWith('0000'), true);
});
```

### 集成测试

```dart
testWidgets
('Login with POW captcha
'
, (WidgetTester tester) async {
await tester.pumpWidget(MyApp());

// 填写表单
await tester.enterText(find.byKey(Key('email')), 'test@example.com');
await tester.enterText(find.byKey(Key('password')), 'password123');

// 点击获取验证
await tester.tap(find.text('获取POW验证'));
await tester.pumpAndSettle(Duration(seconds: 10));

// 验证成功后登录
expect(find.text('验证成功'), findsOneWidget);

await tester.tap(find.text('登录'));
await tester.pumpAndSettle();

// 验证跳转
expect(find.text('用户仪表板'), findsOneWidget);
});
```

## 常见问题

### Q: POW 计算会卡住 UI 吗？

A: 不会。POW 计算在独立的 Isolate 中执行，不会阻塞 UI 线程。

### Q: 计算需要多长时间？

A: 根据设备性能，通常 1-10 秒。高端设备可能只需 1-3 秒。

### Q: verify_token 可以重复使用吗？

A: 不可以。verify_token 是一次性的，使用后会被标记为已消费。

### Q: 如果网络切换了怎么办？

A: verify_token 包含 IP 绑定，网络切换后会验证失败，需要重新获取。

### Q: 可以跳过验证码吗？

A: 取决于后端配置。如果后端启用了 POW 验证开关，则必须提供 verify_token。

## 相关文件

- `lib/store/service/captcha/pow_service.dart` - POW 计算服务
- `lib/store/service/captcha/captcha_service.dart` - 验证码 API 服务
- `lib/component/captcha/pow_captcha_component.dart` - 可复用组件
- `lib/page/auth/login/auth_login_page.dart` - 登录页面示例
- `docs_ai/2026_01/12/POW验证码功能集成.md` - 完整技术文档

## 更新日志

**v1.0 - 2026-01-12**

- ✅ 实现 POW 计算服务（Isolate）
- ✅ 实现验证码 API 服务（单例）
- ✅ 实现可复用组件
- ✅ 登录页面集成
- ✅ 简单登录页面适配
- ✅ 完整文档编写

