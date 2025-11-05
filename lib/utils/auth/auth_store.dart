import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_jwt_token_access_refresh_params_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/utils/auth/auth_constants.dart';
import 'package:fl_app1/utils/auth/jwt_token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore extends ChangeNotifier {
  static final AuthStore _instance = AuthStore._internal();

  factory AuthStore() => _instance;

  AuthStore._internal();

  SharedPreferences? _prefs;

  String? _accessJWTToken;
  String? _refreshJWTToken;
  JWTTokenModel? _accessJWTTokenPayload;
  JWTTokenModel? _refreshJWTTokenPayload;
  Timer? _refreshTokenTimeout;

  String? get accessToken => _accessJWTToken;

  String? get refreshToken => _refreshJWTToken;

  JWTTokenModel? get accessTokenPayload => _accessJWTTokenPayload;

  JWTTokenModel? get refreshTokenPayload => _refreshJWTTokenPayload;

  bool get isAuthenticated =>
      _accessJWTToken != null && _accessJWTTokenPayload != null;

  String? get userEmail => _accessJWTTokenPayload?.subjectAccess?.email;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _refreshThisToken();

    if (_accessJWTToken == null && _refreshJWTToken != null) {
      await apiRefreshToken();
    }

    if (_accessJWTToken != null) {
      _startRefreshTokenTimer();
    }
  }

  Future<void> logout() async {
    _stopRefreshTokenTimer();
    _accessJWTToken = null;
    _refreshJWTToken = null;
    _accessJWTTokenPayload = null;
    _refreshJWTTokenPayload = null;

    // 只需要清理 SharedPreferences 中的 refreshToken
    await _prefs?.remove(AuthConstants.refreshTokenKey);
    debugPrint('🗑️ 已清除 SharedPreferences 中的 refreshToken');

    notifyListeners();
  }

  Future<bool> apiRefreshToken() async {
    debugPrint('🔄 apiRefreshToken 被调用');
    debugPrint('🔍 当前 _refreshJWTToken: ${_refreshJWTToken != null
        ? "存在"
        : "null"}');

    if (_refreshJWTToken == null) {
      debugPrint('❌ No refresh token available for renewal');
      debugPrint('🔍 尝试重新从存储加载 token...');
      await _refreshThisToken();

      if (_refreshJWTToken == null) {
        debugPrint('❌ 重新加载后仍然没有 refresh token，清除访问令牌并登出');
        await logout();
        return false;
      }
      debugPrint('✅ 重新加载后找到 refresh token');
    }

    final dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
    final rest = RestClient(dio, baseUrl: kDefaultBaseUrl);

    final body = WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModel(
      refreshToken: _refreshJWTToken!,
    );

    final response = await rest.fallback
        .postJwtAccessRefreshApiV2AuthJwtTokenJwtAccessRefreshPost(body: body);

    if (response.isSuccess && response.result.accessToken.isNotEmpty) {
      await _setTokens(
        response.result.accessToken,
        response.result.refreshToken,
      );
      return true;
    } else {
      debugPrint('Token refresh failed: ${response.message}');
      await logout();
      return false;
    }
  }

  void _startRefreshTokenTimer() {
    _stopRefreshTokenTimer();

    final expAccess = _accessJWTTokenPayload?.exp;
    if (expAccess == null) {
      debugPrint('Access token exp 字段缺失，无法设置刷新定时器');
      logout();
      return;
    }

    final expTime = DateTime.fromMillisecondsSinceEpoch(expAccess * 1000);
    final timeout =
        expTime.difference(DateTime.now()) -
        AuthConstants.tokenRefreshAdvanceTime;

    if (timeout.isNegative || timeout.inMilliseconds <= 0) {
      debugPrint('Access token已过期，立即刷新');
      apiRefreshToken().then((success) {
        if (success) {
          Future.delayed(const Duration(seconds: 1), () {
            _startRefreshTokenTimer();
          });
        } else {
          debugPrint('❌ 访问令牌刷新失败，用户需要重新登录');
        }
      });
    } else {
      final timeoutSeconds = timeout.inSeconds;
      debugPrint('将在 $timeoutSeconds 秒后刷新访问令牌');

      _refreshTokenTimeout = Timer(timeout, () async {
        debugPrint('开始刷新访问令牌...');
        final success = await apiRefreshToken();
        if (success) {
          debugPrint('访问令牌刷新成功');
          _startRefreshTokenTimer();
        }
      });
    }
  }

  void _stopRefreshTokenTimer() {
    _refreshTokenTimeout?.cancel();
    _refreshTokenTimeout = null;
  }

  Future<void> _refreshThisToken() async {
    // 刷新令牌从 SharedPreferences 读取
    final refreshToken = _prefs?.getString(AuthConstants.refreshTokenKey);
    final stopRefresh = _prefs?.getString(AuthConstants.stopRefreshKey);

    debugPrint('🔍 _refreshThisToken: 访问令牌在内存中=${_accessJWTToken != null
        ? "存在"
        : "不存在"}');
    debugPrint('🔍 _refreshThisToken: refreshToken从SP读取=${refreshToken != null
        ? "存在"
        : "不存在"}');

    _refreshJWTToken = refreshToken;

    if (stopRefresh == 'true') {
      debugPrint('刷新令牌已被停止，停止操作');
      return;
    }

    // 访问令牌仅在内存中，应用重启后会丢失
    if (_accessJWTToken != null) {
      _accessJWTTokenPayload = _decodeToken(_accessJWTToken!);
      debugPrint('🔍 Access token payload 解析: ${_accessJWTTokenPayload != null
          ? "成功"
          : "失败"}');
    } else {
      _accessJWTTokenPayload = null;
      debugPrint('⚠️ 访问令牌不在内存中（应用重启或首次启动）');
    }

    if (refreshToken != null) {
      _refreshJWTTokenPayload = _decodeToken(refreshToken);
      debugPrint(
          '🔍 Refresh token payload 解析: ${_refreshJWTTokenPayload != null
              ? "成功"
              : "失败"}');
    } else {
      _refreshJWTTokenPayload = null;
      debugPrint('⚠️ 警告: Refresh token 不存在');
    }
  }

  JWTTokenModel? _decodeToken(String token) {
    try {
      final payload = Jwt.parseJwt(token);

      // Validate required fields
      if (payload['exp'] == null || payload['iat'] == null) {
        debugPrint('Token missing required fields: $payload');
        return null;
      }

      return JWTTokenModel.fromJson(payload);
    } catch (error, stackTrace) {
      debugPrint('Failed to decode token: $error');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<void> _setTokens(String? accessToken, String? refreshToken) async {
    debugPrint('💾 _setTokens 被调用: accessToken=${accessToken != null
        ? "存在"
        : "null"}, refreshToken=${refreshToken != null ? "存在" : "null"}');

    // 访问令牌只保存在内存中
    _accessJWTToken = accessToken;
    if (accessToken != null) {
      debugPrint('💾 设置内存中的 _accessJWTToken');
      _accessJWTTokenPayload = _decodeToken(accessToken);
      debugPrint('💾 解析 accessToken payload: ${_accessJWTTokenPayload != null
          ? "成功"
          : "失败"}');
    } else {
      _accessJWTTokenPayload = null;
    }

    // 刷新令牌保存在 SharedPreferences 中
    if (refreshToken != null) {
      _refreshJWTToken = refreshToken;
      await _prefs?.setString(AuthConstants.refreshTokenKey, refreshToken);
      debugPrint('💾 保存 refreshToken 到 SharedPreferences');
      _refreshJWTTokenPayload = _decodeToken(refreshToken);
      debugPrint('💾 解析 refreshToken payload: ${_refreshJWTTokenPayload != null
          ? "成功"
          : "失败"}');
    } else {
      await _prefs?.remove(AuthConstants.refreshTokenKey);
    }

    if (accessToken != null && isAuthenticated) {
      _startRefreshTokenTimer();
    }

    notifyListeners();
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await _setTokens(accessToken, refreshToken);
  }
}
