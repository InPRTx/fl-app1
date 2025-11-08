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

```text
response = await dio.get('/test?id=12&name=dio');
```

请把生成的文档放在
/docs_ai/年_月/日_操作.md 下面
月/日为01 02 10 这种两位长度
今天是 2025年11月11日

api url路径 /api/v2/low_admin_api 和 /api/v2/user 必须要带上访问令牌，不然会报401错误
所有api调用均使用model参数，避免手动构造query string
全局状态使用单例模式，确保状态一致性

## DateTime 时间处理规范

### 核心原则

API 使用 **UTC 时间**，UI 显示使用 **本地时间**

### 时间转换规则

#### 1. 从 API 获取数据（导入）

```dart
// API 模型自动解析为 DateTime（UTC时间）
// 在初始化时转换为本地时间用于显示和编辑
_dateTimeValues['userLevelExpireIn'] = service.userLevelExpireIn.toLocal();
```

#### 2. 提交数据到 API（导出）

```dart
// 提交前必须转换为 UTC 时间
final body = ModelName(
  userLevelExpireIn: (data['userLevelExpireIn'] as DateTime).toUtc(),
  userAccountExpireIn: (data['userAccountExpireIn'] as DateTime).toUtc(),
);
```

#### 3. UI 显示时间

```dart
// 显示前转换为本地时间并格式化
String _formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return 'N/A';
  final localDateTime = dateTime.toLocal();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
}
```


### 完整示例

```dart
// 1. 初始化阶段：从 API 模型转换为本地时间
void _initializeControllers() {
  // API 返回的是 UTC 时间，转换为本地时间供编辑使用
  _dateTimeValues['userLevelExpireIn'] = service.userLevelExpireIn.toLocal();
  _dateTimeValues['userAccountExpireIn'] = userInfo.userAccountExpireIn.toLocal();
}

// 2. 提交阶段：从本地时间转换为 UTC 时间
Future<void> _toggleEdit() async {
  if (_isEditing) {
    final data = <String, dynamic>{
      // 其他字段...
      'userLevelExpireIn': _dateTimeValues['userLevelExpireIn']!,  // 本地时间
    };
    
    // 在 onUpdate 回调中转换为 UTC
    final body = ModelName(
      userLevelExpireIn: (data['userLevelExpireIn'] as DateTime).toUtc(),
    );
  }
}

// 3. 显示阶段：格式化本地时间
Widget _buildDateTimeInfoRow(String field, String label, DateTime value) {
  return _isEditing
      ? InkWell(
          onTap: () => _selectDateTime(field),
          child: Text(_formatDateTime(_dateTimeValues[field])),  // 显示本地时间
        )
      : Text(
          _formatDateTime(value),
          style: TextStyle(
            color: value.isBefore(DateTime.now()) ? Colors.red : Colors.green,
          ),
        );
}
```

### 关键点总结

1. ✅ API 数据模型使用 `DateTime.parse()` 自动解析为 UTC
2. ✅ API 数据模型使用 `toIso8601String()` 自动序列化为 UTC
3. ✅ 初始化时：API DateTime（UTC） → `.toLocal()` → UI 本地时间
4. ✅ 提交时：UI 本地时间 → `.toUtc()` → API DateTime（UTC）
5. ✅ 显示时：DateTime → `.toLocal()` → 格式化字符串
6. ✅ 时间选择器：使用本地时间 + 中文 locale
7. ✅ 比较时间：使用 `DateTime.now()` 会自动使用本地时间

### 使用 TZDateTime 处理时区时间

当需要更精确的时区处理时，使用 `timezone` 包中的 `TZDateTime`。

#### 依赖包

```yaml
dependencies:
  timezone: ^0.9.0
  intl: ^0.18.0
```

#### 导入

```dart
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
```

#### 1. 从 API 读取时间并转换为本地时区

```dart
// API 返回的 DateTime 是 UTC 时间
// 使用 tz.TZDateTime.from 转换为本地时区
final DateTime? apiDateTime = record.expireAt; // UTC 时间

final tz.TZDateTime? localExpireAt = apiDateTime != null
    ? tz.TZDateTime.from(apiDateTime, tz.local)
    : null;
```

#### 2. 显示时间

```dart
// 格式化显示本地时间
final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

Widget _buildTimeDisplay(DateTime? dateTime) {
  if (dateTime == null) return const Text('N/A');

  // 转换为本地时区后格式化
  final tz.TZDateTime localTime = tz.TZDateTime.from(dateTime, tz.local);
  return Text(dateFormat.format(localTime));
}
```

#### 3. 时间比较

```dart
// 比较时间时，统一使用本地时区
final tz.TZDateTime? localExpireAt = record.expireAt != null
    ? tz.TZDateTime.from(record.expireAt!, tz.local)
    : null;

final bool isExpired = localExpireAt != null &&
    localExpireAt.isBefore(tz.TZDateTime.now(tz.local));
```

#### 4. 完整示例（用户购买记录列表）

```dart
Widget _buildBoughtCard(BoughtRecord record) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  // 1. 从 API DateTime（UTC）转换为本地时区
  final tz.TZDateTime? localExpireAt = record.expireAt != null
      ? tz.TZDateTime.from(record.expireAt!, tz.local)
      : null;

  // 2. 使用本地时区进行时间比较
  final bool isExpired = localExpireAt != null &&
      localExpireAt.isBefore(tz.TZDateTime.now(tz.local));

  return Card(
    child: Column(
      children: [
        // 3. 显示格式化的本地时间
        Text('购买时间: ${dateFormat.format(
            tz.TZDateTime.from(record.createdAt, tz.local)
        )}'),

        if (record.expireAt != null)
          Text('过期时间: ${dateFormat.format(localExpireAt!)}'),

        // 4. 根据时间状态显示不同样式
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isExpired
                ? Colors.red.withValues(alpha: 0.2)
                : Colors.green.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isExpired ? '已过期' : '有效',
            style: TextStyle(
              fontSize: 12,
              color: isExpired ? Colors.red[700] : Colors.green[700],
            ),
          ),
        ),
      ],
    ),
  );
}
```

#### 5. 提交数据到 API

```dart
// 如果需要从 TZDateTime 转换回 UTC 提交给 API
Future<void> updateRecord(tz.TZDateTime localTime) async {
  // TZDateTime 转换为 UTC DateTime
  final DateTime utcTime = localTime.toUtc();

  final body = UpdateModel(
    expireAt: utcTime, // API 模型会自动序列化为 ISO8601 UTC 格式
  );

  await _restClient.updateRecord(body);
}
```

#### TZDateTime 关键点总结

1. ✅ 使用 `tz.TZDateTime.from(dateTime, tz.local)` 将 UTC 转为本地时区
2. ✅ 使用 `tz.TZDateTime.now(tz.local)` 获取当前本地时区时间
3. ✅ 时间比较时确保两个时间都在同一时区（都用 `tz.local`）
4. ✅ 显示时间前先转换为本地时区，再格式化
5. ✅ 提交 API 时使用 `.toUtc()` 转回 UTC 时间
6. ✅ `tz.local` 会自动使用设备的系统时区

# Flutter 开发规范

# TL;DR

- **禁止** 出现任何错误；
- **禁止** 不要写 `new` ，在 Dart 2.x 中已不建议继续使用 `new` 关键字；
- **必须** 缩进为2空格；
- **必须** 使用 `flutter format` 、 `dartfmt` 或者 `dart format` 对代码进行格式化；
- **必须** 使用 Flutter 官方仓库下的 `analysis_options.yaml` （[文件](https://github.com/flutter/flutter/blob/master/analysis_options.yaml)）进行基本代码规范约束。
- **必须** 在较长代码和嵌套中使用尾逗号进行拆分，防止超过80字或出现 `))))` ；
- **尽量** 避免出现任何警告；
- **尽量** 避免一行超过80个字符。如果超过了，请检查是否有 `))))` ；
- **尽量** 避免直接修改 Flutter 源码，或依赖的 package 源码；
- **尽量** 在项目排期允许的情况下，将所有 packages 保持为可使用的最新版本；
- **推荐** 在项目排期允许的情况下，将 Flutter SDK 保持为最新的**稳定版本**；

除此之外，以下是各类规范的细则。

# 1. 文件类规范

## 1.1 命名规范

> 对于一个项目而言，良好的文件和目录层级可读性，保证了代码的健壮。


### 1.1.1 文件命名

- **必须** 所有文件（包括资源）采用**小写+下划线**命名。
    - `home_page.dart`
- **必须** 功能组命名时，如果代表一系列同类的集合，使用复数词语。
    -  `enums` , `models`
- **尽量** 不要使用**与项目无关**且**没有共识**的**缩写**用于文件命名。
    -  `wlck_page.dart`
- **尽量** 分词时**信、雅、达。**
    - `user_edit_profile_page.dart`

### 1.1.2 类命名

一个类应直截了当地表明其**内容+身份+用途**。

- **必须** 使用大驼峰命名。同样适用于**枚举**和**扩展函数**。
    - `class Foo` , `extension Bar<T>`
- **必须** 超过两个字母的大写缩略词当做一般单词对待。两个字母的单词除外。
    - `HttpConnectionInfo` , `IOStream` , `Id`  ✅
    - `HTTPConnection` , `IoStream` , `ID`  🚫
- **必须** 在导入库时，使用**小写+下划线**的别名。
    -  `import 'dart:math' as math`
- **尽量** 不要超过5个单词。如果超过了，应该考虑是否为命名或拆分不当。

### 1.1.3 变量命名

- **必须** 使用**小驼峰**命名。
    -  `int imagesLength`
    -  `List<AssetEntity> selectedAssets`
- **必须** 不要超过5个单词。
- **必须** 布尔类型变量使用前缀 `is` 或 `should` 。
    - `bool isLoading`
- **必须** 如果一个变量不是私有变量，不要使用 `_` 作为前缀，因为 Dart 中没有私有的概念。
- **尽量** 除了表示状态的布尔值，其他变量使用名词进行命名。
    -  `double width`
    - `Widget separator`
- **尽量** 不要使用前缀字母。（ `k` 是 Flutter 内定的前缀。）
    -  `kDefaultTimeout`
- **尽量** 不要同时命名多个接近且具有迷惑性的变量。
    -  `tabIndex` , `tabCurrentIndex`

# 2 用法规范

## 2.1 import/export

- **必须** 按照字母表顺序进行 import/export。
- **必须** 将 `dart:` 放在最前。
- **必须** 将 `package:` 放在相对引用之前。
- **必须** 将 Flutter 的 package 放在其他 package 之前。
- **必须** 将 export 放在所有 import 之后。
- **尽量** 避免在构建一般页面时，将 package 的 **src** 引入。除非你正在对一个官方组件进行定制。[implementation_imports](https://dart-lang.github.io/linter/lints/implementation_imports.html)

## 2.2 构造方法

构造方法是 OOP 语言中最常用的方法之一。在 Dart + Flutter 中，依照各项规则的限制，一般对构造函数有以下几点要求：

- **必须** 所有**构造函数**和**工厂方法**都要写在类的**开头位置**，而后才是变量声明。
- **必须** `StatefulWidget` 的构造字段必须为终值 `final` 。(@immutable)
- **必须** `Widget` 的构造必须带有命名可选参数 `Key key` 。
- **必须** 如果构造需要3个及以上的参数，或作为一个 `Widget` 的构造，请将它们转为命名可选参数。
- **必须** 单例使用私有构造。（例： `const API._()` ）
- **必须** 为所有自定义的类实现 `toString()` 。
- **尽量** 如果 `Widget` 的字段均为终值且没有构造回调，将构造方法加上 `const` 。
- **尽量** 有可能用于 `Iterable*`  的类，请重写 `operator ==` 和 `hashCode` 。
- **推荐** 作为 Provider Model 的 `ChangeNotifier` ，字段使用 getter & setter。
- **推荐** 一个由 json 数据转换而来的实体类，请实现 `Map<String, dynamic> toJson()` 。

根据上述要求举两个例子：

```dart
class Person {
  const Person({
    this.name = 'Alex',
    this.age = 23,
    this.skills,
  });

  factory Person.fromJson(Map<String, dynamic?> json) {
    return Person(
      name: json['name'] as String,
      age: json['age'] as int,
      skills: json['skills'] as List<String>?,
    );
  }

  final String name;
  final int age;
  final List<String>? skills;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return name == other.name
        && age == other.age
        && skills == other.skills;
  }

  @override
  int get hashCode => hashValues(name, age, skills);
}
```

```dart
class PersonalPage extends StatefulWidget {
  const PersonalPage({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Person person;

  ///...///
}
```

## 2.3 变量声明、使用、调用

- **禁止** 不要使用 `var` , `Object` ，**在确定变量时必须确定它的类型**。
- **禁止** 不要使用**魔数**。如果它是一种类型表示，直接将它们**定义为枚举**。
- **必须** 避免普遍地使用缩写，除非是类似表示偏移的 `x` 。
    -  `i` -> `index`
- **必须** 在声明时将类型写明，**包括泛型**。[always_specify_types](https://dart-lang.github.io/linter/lints/always_specify_types.html)
    - `Map<String, dynamic> json`
    - `Column(children: <Widget>[])`
- **必须** 使用 `final` 声明**无需改动**的**基本类型**、**无需重新创建实例**的**非基础类型**的变量。
    - `final int userId = 0`
    - `final ScrollController controller = ScrollController()`
    - `final List<AssetEntity> selectedAssets = <AssetEntity>[]`
- **必须** 空安全 除了 Model 以外，不要滥用 `?` ，在声明时就确定是否可空。

### 2.3.1 布尔值

- **禁止** 不要写布尔转布尔的语句。
    -  `return list.isEmpty ? true : false`
- **必须** 非空安全 使用 `??` 将可能为空的布尔值转换为不为空的值。
    - `list?.isEmpty ?? true`
- **尽量** 为值起**肯定形式**的名字。如果在使用它时总是取反，请考虑取反向意义的名字。

### 2.3.2 枚举

- **必须** `switch` 中列出所有的枚举值，不要用 `default` 。
- **必须** 使用 `switch` 而不是 `if` 来判断枚举内容。

### 2.3.3 字符串

- **必须** 拼接字面量字符串时使用临近字符串，而不用 `+` 。[prefer_adjacent_string_concatenation](https://dart-lang.github.io/linter/lints/prefer_adjacent_string_concatenation.html)
- **必须** 使用插值组合字符串。[prefer_interpolation_to_compose_strings](https://dart-lang.github.io/linter/lints/prefer_interpolation_to_compose_strings.html)
- **必须** 避免在字符串插值中使用不必要的大括号。[unnecessary_brace_in_string_interps](https://dart-lang.github.io/linter/lints/unnecessary_brace_in_string_interps.html)

### 2.3.4 集合

- **必须** `List` , `Set` , `Map` 使用字面量构造实例。[prefer_collection_literals](https://dart-lang.github.io/linter/lints/prefer_collection_literals.html)。
    - `<T>[]` , `<T>{}` , `<T, S>{}`
- **尽量** `Iterable*` 初始化为空的集合。
    -  `List<int> list = <int>[]`
- **尽量** 避免使用 `toList()` 和 `List.cast` ，使用 `List.from` 。
    - 仅在改变类型和从可迭代对象生成 `List` 时使用，其他时间勿用。
- **尽量** 使用**展开操作符**构造新的 `Iterable` 。
    - `final List<int> anotherList = <int>[...list]`
- **推荐** 使用**级联操作符**对同一个对象进行连续调用。
    -  `list..add(x)..add(y)`

### 2.3.5 局部变量

### 2.3.6 异步类

- **必须** `StreamController` 如果不再使用必须 `close`。
- **必须** 监听 `Stream` 产生的 `StreamSubscription` 不再收听必须手动调用 `cancel` 取消监听。

Lib
├──page 落地页     
│   └──user 页面模块文件夹   
│       └──login 页面落地页文件夹
│            └──user_login.dart => class UserLoginPage 后缀为page为落地页 唯一入口     
│                   └──user_login_button.dart => class UserLoginButton 非公共部分页面子组件   
├──component 通用组件   
│        └──Modal
│            └──alert.dart => class ModalAlertComponent  
├──store 数据集中管理
│    ├──index.dart 实例化Provider export model类
│    ├──proto pb协议转换代码
│    ├──service pb协议 yyp协议 等等转义成 dart方法
│    ├──model
│    │    ├──user_model.dart => class UserModel
│    │    └──index.dart => export all models
│    └──object
│         └──user_object.dart => class UserObject
├──helper 公共方法   
│    └──index.dart 常规方法、通用方法、全局方法可以用过这个入口export 避免重复引入、可以作用通过用方法入口
├──config 配置中心
│    ├──index.dart 配置变量与切换方法  
└──router 路由
└──  页面映射配置、observe 方法导出
