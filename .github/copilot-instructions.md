尽量不要使用try来包装无意义的报错，
代码最大化用最精简的方法来实现功能
不要修改项目的/lib/api下的所有代码，该目录下的代码均为自动生成代码
在调用api类似使用下面

```dart
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';

final body = WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
  email: _emailController.text.trim(),
  password: _passwordController.text,
  captchaKey: _fixedCaptchaKey,
  tiago2CapToken: _captchaToken!,
  isRememberMe: _rememberMe,
  twoFaCode: _twoFaController.text.isEmpty
      ? null
      : _twoFaController.text.trim(),
);
```

以下代码调用是最大扣分项

```dart
response = await
dio.get
('/test?id=12&name=dio
'
);
```

请把生成的文档放在
/docs_ai/年_月/日_操作.md 下面
月/日为01 02 10 这种两位长度

api url路径 /api/v2/low_admin_api 和 /api/v2/user 必须要带上访问令牌，不然会报401错误
所有api调用均使用model参数，避免手动构造query string
全局状态使用单例模式，确保状态一致性