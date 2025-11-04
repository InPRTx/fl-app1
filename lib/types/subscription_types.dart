/// 订阅相关类型定义

/// 操作系统类型
enum OperatingSystem {
  universal('universal', '自动识别', 'earth', 'primary'),
  windows('windows', 'Windows', 'desktop_windows', 'blue'),
  android('android', '安卓', 'android', 'green'),
  macos('macos', 'macOS', 'apple', 'purple'),
  ios('ios', 'iOS', 'phone_iphone', 'orange'),
  ssr('ssr', 'SSR', 'shield', 'dark'),
  linux('linux', 'Linux', 'computer', 'teal');

  const OperatingSystem(this.value, this.label, this.iconName, this.color);

  final String value;
  final String label;
  final String iconName;
  final String color;
}

/// 客户端类型
enum ClientType {
  auto('AUTO', '自动检测'),
  mixed('Mixed', 'Shadowrocket'),
  clash('Clash', 'Clash'),
  v2ray('V2Ray', 'V2Ray'),
  quantumultX('QuantumultX', 'Quantumult X'),
  surge4('Surge4', 'Surge 4'),
  ssr('SSR', 'ShadowsocksR'),
  loon('Loon', 'Loon');

  const ClientType(this.value, this.label);

  final String value;
  final String label;
}

/// 操作系统配置
class OSConfig {
  const OSConfig({
    required this.os,
    required this.description,
    required this.recommendation,
    required this.supportedClients,
  });

  final OperatingSystem os;
  final String description;
  final String recommendation;
  final List<ClientType> supportedClients;
}

/// 操作系统配置常量
const Map<OperatingSystem, OSConfig> osConfigs = {
  OperatingSystem.universal: OSConfig(
    os: OperatingSystem.universal,
    description: '通用订阅链接，兼容大多数客户端',
    recommendation: '推荐客户端：Clash、V2Ray等',
    supportedClients: [ClientType.auto],
  ),
  OperatingSystem.windows: OSConfig(
    os: OperatingSystem.windows,
    description: '专为Windows系统优化的订阅链接',
    recommendation: '推荐客户端：ClashMeta、V2rayN',
    supportedClients: [ClientType.clash, ClientType.v2ray],
  ),
  OperatingSystem.android: OSConfig(
    os: OperatingSystem.android,
    description: '适用于Android手机和平板设备',
    recommendation: '推荐客户端：V2rayNG',
    supportedClients: [ClientType.clash, ClientType.v2ray, ClientType.ssr],
  ),
  OperatingSystem.macos: OSConfig(
    os: OperatingSystem.macos,
    description: '专为苹果Mac电脑设计',
    recommendation: '推荐客户端：ClashX、V2rayU',
    supportedClients: [ClientType.clash, ClientType.v2ray, ClientType.surge4],
  ),
  OperatingSystem.ios: OSConfig(
    os: OperatingSystem.ios,
    description: '适用于iPhone和iPad设备',
    recommendation: '推荐客户端：Shadowrocket、Quantumult X',
    supportedClients: [
      ClientType.mixed,
      ClientType.quantumultX,
      ClientType.loon,
      ClientType.surge4,
    ],
  ),
  OperatingSystem.ssr: OSConfig(
    os: OperatingSystem.ssr,
    description: 'ShadowsocksR专用订阅链接',
    recommendation: '推荐客户端：SSR系列',
    supportedClients: [ClientType.ssr],
  ),
  OperatingSystem.linux: OSConfig(
    os: OperatingSystem.linux,
    description: '适用于Linux系统',
    recommendation: '推荐客户端：Clash',
    supportedClients: [ClientType.clash, ClientType.v2ray],
  ),
};
