# 节点管理界面 - API 集成文档

## API 端点列表

所有 API 都基于 `/api/v2/low_admin_api/ss_node/` 路径

### 1. 获取节点列表 (GET)

**端点**: `GET /api/v2/low_admin_api/ss_node/`

**权限要求**: Bearer Token (低权限管理员)

**查询参数**:

```dart
offset: int? = 0 // 分页偏移量，默认 0
limit: int? = 3000 // 每页数量，默认 3000
q: String
? // 模糊搜索：节点名称、备注、ID
from_iso: DateTime
? // 时间范围起始 (UTC)
to_iso: DateTime? // 时间范围结束 (UTC)
```

**响应类型**: `GetSsNodeListResponse`

**响应示例**:

```dart
GetSsNodeListResponse
(
resultList: [
SsNodeOutput(
id: 1,
nodeName: 'HK Node 1',
nodeConfig: NodeConfig(host: '123.45.67.89', port: 443),
iso3166Code: CountryCode.hk,
vpnType: VpnTypeEnum.vmess,
nodeRate: '1.00',
priority: 60000,
nodeLevel: 0,
isEnable: true,
isHideNode: false,
createdAt: DateTime.utc(2025, 11, 20),
updatedAt: DateTime.utc(2025, 11, 22),
),
]
)
```

**代码示例**:

```dart

final response = await
_restClient.fallback
    .getSsNodeListApiV2LowAdminApiSsNodeGet
(
offset: 0,
limit: 100,
q: 'HK',
);

final nodes = response.resultList;
```

---

### 2. 创建节点 (POST)

**端点**: `POST /api/v2/low_admin_api/ss_node/`

**权限要求**: Bearer Token (低权限管理员)

**请求体**: `SsNodeInput` (必填)

**必填字段**:

```dart
SsNodeInput
(
id: null, // 新增时可为 null
nodeName: 'SG Node', // 节点名称 (必填)
nodeConfig: NodeConfig(
host: 'node.example.com', // 主机地址 (必填)
port: 443, // 端口 (可选)
),
priority: 60000, // 优先级 (必填，默认 60000)
isEnable: true, // 启用 (必填，默认 true)
iso3166Code: CountryCode.sg, // 国家代码 (必填)
vpnType: VpnTypeEnum.vmess, // VPN 类型 (必填)
nodeRate: 1.0, // 倍率 (必填，默认 1.0)
nodeLevel: 0, // 等级 (必填，默认 0)
isHideNode: false, // 隐藏 (必填，默认 false)
createdAt: DateTime.now().toUtc(), // 创建时间 (可选)
updatedAt: DateTime.now().toUtc(), // 更新时间 (可选)
nodeInfo: 'Singapore node', // 节点信息 (可选)
remark: 'test', // 备注 (可选)
nodeSpeedLimit: '100MB/day', // 速度限制 (可选)
userGroupHost:
null
, // 用户组映射 (可选)
)
```

**响应类型**: `ErrorResponse`

**成功响应示例**:

```dart
ErrorResponse
(
code: 200,
message: 'success',
isSuccess:
true
,
)
```

**代码示例**:

```dart

final body = SsNodeInput(
  id: null,
  nodeName: 'Singapore Node',
  nodeConfig: NodeConfig(host: 'sg.example.com', port: 443),
  iso3166Code: CountryCode.sg,
  vpnType: VpnTypeEnum.vmess,
  nodeRate: 1.0,
  nodeLevel: 0,
  isEnable: true,
  isHideNode: false,
);

final response = await
_restClient.fallback
    .postSsNodeApiV2LowAdminApiSsNodePost
(
body: body);

if (response.isSuccess) {
print('节点创建成功');
}
```

---

### 3. 更新节点 (PUT)

**端点**: `PUT /api/v2/low_admin_api/ss_node/{node_id}`

**权限要求**: Bearer Token (低权限管理员)

**路径参数**:

```dart
node_id: int // 节点 ID (必填)
```

**请求体**: `SsNodeInput` (必填)

**注意**: ⚠️ 这是**完全替换**操作，必须提供所有必填字段

**代码示例**:

```dart

final body = SsNodeInput(
  id: 1,
  nodeName: 'Updated Node Name',
  nodeConfig: NodeConfig(host: 'new.host.com', port: 443),
  iso3166Code: CountryCode.us,
  // 更新国家代码
  vpnType: VpnTypeEnum.vmess,
  nodeRate: 1.5,
  nodeLevel: 1,
  isEnable: true,
  isHideNode: false,
);

final response = await
_restClient.fallback
    .putSsNodeApiV2LowAdminApiSsNodeNodeIdPut
(
nodeId: 1,
body: body,
);

if (response.isSuccess) {
print('节点更新成功');
}
```

---

### 4. 删除节点 (DELETE)

**端点**: `DELETE /api/v2/low_admin_api/ss_node/{node_id}`

**权限要求**: Bearer Token (低权限管理员)

**路径参数**:

```dart
node_id: int // 节点 ID (必填)
```

**响应类型**: `ErrorResponse`

**代码示例**:

```dart

final response = await
_restClient.fallback
    .deleteSsNodeApiV2LowAdminApiSsNodeNodeIdDelete
(
nodeId: 1);

if (response.isSuccess) {
print('节点删除成功');
}
```

---

### 5. 获取单个节点 (GET)

**端点**: `GET /api/v2/low_admin_api/ss_node/{node_id}`

**权限要求**: Bearer Token (低权限管理员)

**路径参数**:

```dart
node_id: int // 节点 ID (必填)
```

**响应类型**: `GetSsNodeResponse`

**代码示例**:

```dart

final response = await
_restClient.fallback
    .getSsNodeByIdApiV2LowAdminApiSsNodeNodeIdGet
(
nodeId: 1);

final node = response.result;
print('节点名称: ${node.nodeName}');
print('国家代码: ${node.iso3166Code.name.toUpperCase()}');
```

---

## 模型类参考

### SsNodeOutput (响应模型)

```dart
@JsonSerializable()
class SsNodeOutput {
  int? id; // 节点 ID
  String nodeName; // 节点名称
  NodeConfig nodeConfig; // 节点配置 (主机、端口等)
  int priority; // 优先级
  bool isEnable; // 是否启用
  CountryCode iso3166Code; // ISO 3166-1 alpha-2 国家代码
  VpnTypeEnum vpnType; // VPN 类型
  String nodeRate; // 倍率 (string)
  int nodeLevel; // 节点等级
  bool isHideNode; // 是否隐藏
  DateTime? createdAt; // 创建时间 (UTC)
  DateTime? updatedAt; // 更新时间 (UTC)
  String? nodeInfo; // 节点信息
  String? remark; // 备注
  String? nodeSpeedLimit; // 速度限制
  UserGroupHost? userGroupHost; // 用户组主机映射
}
```

### SsNodeInput (请求模型)

```dart
@JsonSerializable()
class SsNodeInput {
  int? id; // 节点 ID (编辑时必填)
  String nodeName; // 节点名称
  NodeConfig nodeConfig; // 节点配置
  int priority; // 优先级
  bool isEnable; // 是否启用
  CountryCode iso3166Code; // 国家代码
  VpnTypeEnum vpnType; // VPN 类型
  double nodeRate; // 倍率 (double)
  int nodeLevel; // 节点等级
  bool isHideNode; // 是否隐藏
  DateTime? createdAt; // 创建时间
  DateTime? updatedAt; // 更新时间
  String? nodeInfo; // 节点信息
  String? remark; // 备注
  String? nodeSpeedLimit; // 速度限制
  UserGroupHost? userGroupHost; // 用户组映射
}
```

### CountryCode (国家代码枚举)

支持所有 ISO 3166-1 alpha-2 代码:

```dart
enum CountryCode {
  @JsonValue('CN')
  cn, // 中国
  @JsonValue('HK')
  hk, // 香港
  @JsonValue('SG')
  sg, // 新加坡
  @JsonValue('JP')
  jp, // 日本
  @JsonValue('US')
  us, // 美国
  @JsonValue('GB')
  gb, // 英国
  // ... 及全球所有国家和地区
}
```

### NodeConfig (节点配置)

```dart
@JsonSerializable()
class NodeConfig {
  String? host; // 主机地址
  int? port; // 端口号
}
```

### VpnTypeEnum (VPN 类型)

```dart
enum VpnTypeEnum {
  vmess, // VMess 协议
  vless, // VLESS 协议
  trojan, // Trojan 协议
  // ... 其他支持的协议
}
```

---

## 常见用例

### 用例 1: 获取所有 HK 节点

```dart

final response = await
_restClient.fallback
    .getSsNodeListApiV2LowAdminApiSsNodeGet
(
q
:
'
HK
'
, // 模糊搜索
);

// 或者使用精确查询
// q_command: {"iso3166_code": "HK"}
```

### 用例 2: 创建新节点并指定国家

```dart

final newNode = SsNodeInput(
  id: null,
  nodeName: 'new-node',
  nodeConfig: NodeConfig(host: 'example.com', port: 443),
  iso3166Code: CountryCode.hk,
  // 香港节点
  vpnType: VpnTypeEnum.vmess,
  nodeRate: 1.0,
  nodeLevel: 0,
  isEnable: true,
  isHideNode: false,
);

await
_restClient.fallback.postSsNodeApiV2LowAdminApiSsNodePost
(
body
:
newNode
,
);
```

### 用例 3: 修改节点的国家代码

```dart
// 1. 先获取完整节点信息
final response = await
_restClient.fallback
    .getSsNodeByIdApiV2LowAdminApiSsNodeNodeIdGet
(
nodeId: 1);
final node = response.result;

// 2. 修改国家代码
final updated = SsNodeInput(
id: node.id,
nodeName: node.nodeName,
nodeConfig: node.nodeConfig,
iso3166Code: CountryCode.sg, // 改为新加坡
vpnType: node.vpnType,
nodeRate: double.tryParse(node.nodeRate) ?? 1.0,
nodeLevel: node.nodeLevel,
isEnable: node.isEnable,
isHideNode: node.isHideNode,
// ... 其他字段
);

// 3. 提交更新
await _restClient.fallback.putSsNodeApiV2LowAdminApiSsNodeNodeIdPut(
nodeId: 1,
body
:
updated
,
);
```

---

## 错误处理

### HTTP 状态码

```dart
200 OK // 成功
400 Bad Request // 请求参数错误
401 Unauthorized // 认证失败（Token 过期）
403 Forbidden // 无权限访问
404 Not Found // 资源不存在
500
Internal
Error // 服务器错误
```

### 错误响应格式

```dart
ErrorResponse
(
code: 400,
message: '节点名称已存在',
isSuccess:
false
,
)
```

### 错误处理代码示例

```dart
try {
final response = await _restClient.fallback
    .postSsNodeApiV2LowAdminApiSsNodePost(body: body);

if (response.isSuccess) {
print('成功: ${response.message}');
} else {
print('业务错误: ${response.message}');
}
} on DioException catch (error) {
if (error.response?.statusCode == 401) {
print('Token 过期，请重新登录');
} else {
print('网络错误: ${error.message}');
}
}
```

---

## 时间处理

### UTC 到本地转换

```dart
// API 返回的是 UTC 时间
final DateTime createdAtUtc = node.createdAt; // UTC

// 转换为本地时间显示
final tz.TZDateTime localTime = tz.TZDateTime.from(
  createdAtUtc,
  tz.local,
);

// 格式化显示
final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(localTime);
```

### 本地到 UTC 转换

```dart
// 提交数据时需要转换为 UTC
final DateTime localTime = selectedDateTime; // 本地时间
final DateTime utcTime = localTime.toUtc();

final body = SsNodeInput(
  // ...
  updatedAt: utcTime, // 转换为 UTC
);
```

---

## 分页示例

```dart

int offset = 0;
const int pageSize = 50;

// 获取第一页
var response = await
_restClient.fallback
    .getSsNodeListApiV2LowAdminApiSsNodeGet
(
offset: 0,
limit: pageSize,
);

// 获取下一页
offset += pageSize;
response = await _restClient.fallback
    .getSsNodeListApiV2LowAdminApiSsNodeGet(
offset: offset,
limit: pageSize,
);
```

---

## 调试技巧

### 打印请求/响应日志

```dart
// 在创建 Dio 客户端时添加 Logger
final dio = Dio();
dio.interceptors.add
(
LogInterceptor(
requestBody: true,
responseBody: true,
),
);
```

### 验证国家代码

```dart
// 检查枚举值
print
(
CountryCode.hk.name); // 'hk'
print(CountryCode.hk.name.toUpperCase()); // 'HK'

// 获取所有支持的代码
for (var code in CountryCode.values) {
print(code.name.toUpperCase());
}
```

---

**文档版本**: 1.0  
**更新日期**: 2025年11月22日  
**API 版本**: v2  
**生成工具**: OpenAPI 自动生成

