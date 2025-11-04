/// 订阅链接处理工具函数

/// 为订阅链接添加客户端类型参数
/// [baseUrl] 基础订阅链接
/// [clientType] 客户端类型
/// 返回带有客户端类型参数的完整链接
String addClientTypeToUrl(String baseUrl, String clientType) {
  final uri = Uri.tryParse(baseUrl);
  if (uri != null) {
    final params = Map<String, dynamic>.from(uri.queryParameters);
    params['client_type'] = clientType;
    return uri.replace(queryParameters: params).toString();
  }
  
  // URL解析失败时使用简单拼接
  final separator = baseUrl.contains('?') ? '&' : '?';
  return '$baseUrl${separator}client_type=$clientType';
}

/// 为SSR订阅链接添加vpn_type参数
/// [baseUrl] 基础订阅链接
/// 返回带有vpn_type=ssr参数的完整链接
String addSSRTypeToUrl(String baseUrl) {
  final uri = Uri.tryParse(baseUrl);
  if (uri != null) {
    final params = Map<String, dynamic>.from(uri.queryParameters);
    params['vpn_type'] = 'ssr';
    return uri.replace(queryParameters: params).toString();
  }
  
  // URL解析失败时使用简单拼接
  final separator = baseUrl.contains('?') ? '&' : '?';
  return '$baseUrl${separator}vpn_type=ssr';
}

/// 从订阅链接中提取域名
/// [url] 订阅链接
/// 返回域名或空字符串
String extractDomainFromUrl(String url) {
  final uri = Uri.tryParse(url);
  return uri?.host ?? '';
}

/// 从订阅链接数组中提取唯一域名列表
/// [urls] 订阅链接数组
/// 返回唯一域名数组
List<String> extractUniqueDomains(List<String> urls) {
  final domains = urls
      .map(extractDomainFromUrl)
      .where((domain) => domain.isNotEmpty)
      .toSet()
      .toList();
  return domains;
}
