// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fallback_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _FallbackClient implements FallbackClient {
  _FallbackClient(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<void> getHealthcheckHealthGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/health',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getHealthcheckIpGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/ip',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<VersionResponseModel> getVersionV1VersionGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<VersionResponseModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/version',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late VersionResponseModel _value;
    try {
      _value = VersionResponseModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getDbVersionV1VersionDbGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/version_db',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> embyFunctionV1EmbyFunctionGet({
    required String apiKey,
    required WebSubFastapiRoutersVEmbyFunctionSqlTableEnum sqlTable,
    int? sqlTableUserId,
    String? sqlTableLinkToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'sql_table': sqlTable,
      r'sql_table_user_id': sqlTableUserId,
      r'sql_table_link_token': sqlTableLinkToken,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/emby_function',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> casinoFunctionV1CasinoFunctionGet({
    required String apiKey,
    required WebSubFastapiRoutersVCasinoFunctionSqlTableEnum sqlTable,
    String? sqlTableTelegramId,
    int? sqlTableAddTransferEnable,
    TypeModeEnum? typeMode,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'sql_table': sqlTable,
      r'sql_table_telegram_id': sqlTableTelegramId,
      r'sql_table_add_transfer_enable': sqlTableAddTransferEnable,
      r'type_mode': typeMode,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/casino_function',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getUserinfoV1EmbyLinkTokenGet({required String token}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/emby_link/${token}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getEmbyLinkListV1EmbyLinkListGet({
    required String apiKey,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api_key': apiKey};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/emby_link_list',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getNotifyV1PaymentNotifyPaymentSystemGet({
    required String paymentSystem,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/payment/notify/${paymentSystem}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postNotifyV1PaymentNotifyPaymentSystemPost({
    required String paymentSystem,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/payment/notify/${paymentSystem}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postStatusV1PaymentStatusPost({required String tradeno}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'tradeno': tradeno};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/payment/status',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> adminNotifyV1PaymentAdminNotifyByCookiesGet({
    required String outTradeNo,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'out_trade_no': outTradeNo};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/payment/admin_notify_by_cookies',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> adminNotifyV1PaymentAdminNotifyGet({
    required String outTradeNo,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'out_trade_no': outTradeNo};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/payment/admin_notify',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> cronQueueUserPostV1ModMuCronQueueUserPostGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/cron_queue_user_post',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getFuncDetectRulesV1ModMuFuncDetectRulesGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/detect_rules',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getFuncDetectRulesV1ModMuFuncRelayRulesGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/relay_rules',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getFuncBlockIpV1ModMuFuncBlockIpGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/block_ip',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postFuncBlockIpV1ModMuFuncBlockIpPost({
    required PostFuncBlockIpModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/block_ip',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getFuncUnblockIpV1ModMuFuncUnblockIpGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/unblock_ip',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postFuncSpeedtestV1ModMuFuncSpeedtestPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/speedtest',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getFuncAutoexecV1ModMuFuncAutoexecGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/autoexec',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postFuncAutoexecV1ModMuFuncAutoexecPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/autoexec',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postFuncPingV1ModMuFuncPingPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/func/ping',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getNodeInfoV1ModMuNodesIdInfoGet({required int id}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/nodes/${id}/info',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postNodesInfoV1ModMuNodesIdInfoPost({required int id}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/nodes/${id}/info',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getNodesV1ModMuNodesGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/nodes',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postNodesConfigV1ModMuNodesConfigPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/nodes/config',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getUsersV1ModMuUsersGet({
    bool? isAutoTrigger = false,
    String? skipCacheKey,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
      r'skip_cache_key': skipCacheKey,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/users',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getUsersTrafficV1ModMuUsersTrafficPost({
    required PostTrafficModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/users/traffic',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> addAliveIpV1ModMuUsersAliveipPost({
    required PostAddAliveIpModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/users/aliveip',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> addDetectLogV1ModMuUsersDetectlogPost({
    required PostAddDetectLogModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/users/detectlog',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getUsersV1ModMuGrafanaLokiExportGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/grafana_loki_export',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> activeCheckPaylistV1ModMuActiveCheckPaylistGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/active_check_paylist',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void>
  clickhouseImportUserTrafficRawV1ModMuClickhouseImportUserTrafficRawGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/clickhouse_import_user_traffic_raw',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void>
  clickhouseImportModMuUserAliveIpV1ModMuClickhouseImportModMuUserAliveIpGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/clickhouse_import_mod_mu_user_alive_ip',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ErrorResponse> cron1minTaskAllV1ModMuCron1minTaskAllGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/cron_1min_task_all',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> checkUserPasswordV1ModMuCheckUserPasswordGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/check_user_password',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ErrorResponse> getCronBanTaskV1ModMuCronBanTaskGet({
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/cron_ban_task',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getDailyJobV1ModMuDailyJobPost({
    String? apiTokenUuid,
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_token_uuid': apiTokenUuid,
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/daily_job',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getCheckJobV1ModMuCheckJobPost({
    String? apiTokenUuid,
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_token_uuid': apiTokenUuid,
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/check_job',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void>
  clickhouseImportClickhouseImportUserDataHistoryV1ModMuClickhouseImportUserDataHistoryGet(
      {
        bool? isAutoTrigger = false,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/clickhouse_import_user_data_history',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getCheckOldServiceAutoRenewV1ModMuCheckOldServiceAutoRenewPost({
    String? apiTokenUuid,
    bool? isAutoTrigger = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_token_uuid': apiTokenUuid,
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/check_old_service_auto_renew',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void>
  getClickhouseImportUserTrafficLogTotalV1ModMuClickhouseImportUserTrafficLogTotalGet(
      {
        bool? isAutoTrigger = false,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/mod_mu/clickhouse_import_user_traffic_log_total',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getByTokenUuidV1AuthByTokenUuidTokenUuidGet({
    required String tokenUuid,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/by_token_uuid/${tokenUuid}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getLoginV1AuthLoginGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/login',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postLoginV1AuthLoginPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/login',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getLoginV1AuthRegisterGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/register',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postRegisterV1AuthRegisterPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/register',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postLoginV1AuthSendPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/send',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postQrcodeCheckV1AuthQrcodeLoginPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/qrcode_login',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> byUrlV1AuthByUrlGet({
    required int createdAtUnix,
    required String validToken,
    required String inputData,
    LoginWebVersionEnum? loginWebVersion = LoginWebVersionEnum.v1,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'created_at_unix': createdAtUnix,
      r'valid_token': validToken,
      r'input_data': inputData,
      r'login_web_version': loginWebVersion,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/auth/by_url',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getAdminTotalNodeDV1TotalTrafficNodeNodeIdPost({
    required int nodeId,
    required TotalNodeList body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/total/traffic/node/${nodeId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void>
  getUserByMonthCalendarPieV1TotalTrafficUserByMonthCalendarPieTokenUuidGet({
    required String tokenUuid,
    String? yearMonth,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'year_month': yearMonth};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/total/traffic/user_by_month_calendar_pie/${tokenUuid}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getUserAreaTimeAxisV1TotalTrafficUserAreaTimeAxisTokenUuidGet({
    required String tokenUuid,
    dynamic limit = 10000,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'limit': limit.toJson()};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/total/traffic/user_area_time_axis/${tokenUuid}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getAdminTotalUserDV1TotalTrafficUserUserIdPost({
    required int userId,
    required TotalUserList body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/total/traffic/user/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<SystemMetaDataAnnouncementModel>
  getAnnouncementV1AdminAnnouncementGet({
    required AnnouncementEnum annType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<SystemMetaDataAnnouncementModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/announcement',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late SystemMetaDataAnnouncementModel _value;
    try {
      _value = SystemMetaDataAnnouncementModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> postAnnouncementV1AdminAnnouncementPost({
    required AnnouncementEnum annType,
    String? body = '',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = body;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/announcement',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getAnnouncementV1AdminAnnouncementHtmlGet({
    required AnnouncementEnum annType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/announcement_html',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<String> getAnnouncementV1AdminAnnouncementMarkdownGet({
    required AnnouncementEnum annType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<String>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/announcement_markdown',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<String>(_options);
    late String _value;
    try {
      _value = _result.data!;
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> genUserLinkV1V1AdminGenUserLinkV1Get({
    required String a1Host,
    required String a2Host,
    required String a3Host,
    int? a1Port,
    int? a2Port,
    int? a3Port,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'a1_host': a1Host,
      r'a2_host': a2Host,
      r'a3_host': a3Host,
      r'a1_port': a1Port,
      r'a2_port': a2Port,
      r'a3_port': a3Port,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/gen_user_link_v1',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ErrorResponse> postUserBanTaskInsertV1AdminUserBanTaskInsertPost({
    required int userId,
    required DateTime taskEndAt,
    bool? isNeedSendEmail = true,
    String? banContext = '管理员禁封用户',
    String? remark = '',
    DateTime? taskStartAt,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'user_id': userId,
      r'task_end_at': taskEndAt.toIso8601String(),
      r'is_need_send_email': isNeedSendEmail,
      r'ban_context': banContext,
      r'remark': remark,
      r'task_start_at': taskStartAt?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/user_ban_task_insert',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse> postUserBanTaskUnbanV1AdminUserBanTaskUnbanPost({
    required int userId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/user_ban_task_unban',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> replaceUserEmailV1AdminReplaceUserEmailGet({
    required int userId,
    required String userOldEmail,
    required String userNewEmail,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'user_id': userId,
      r'user_old_email': userOldEmail,
      r'user_new_email': userNewEmail,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/replace_user_email',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ErrorResponse>
  postRequestIpBanTaskInsertV1AdminRequestIpBanTaskInsertPost({
    required String ipCidr,
    required DateTime taskEndAt,
    String? banContext = '管理员禁封IP',
    String? remark = '',
    DateTime? taskStartAt,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'ip_cidr': ipCidr,
      r'task_end_at': taskEndAt.toIso8601String(),
      r'ban_context': banContext,
      r'remark': remark,
      r'task_start_at': taskStartAt?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/request_ip_ban_task_insert',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  postRequestIpBanTaskUnbanV1AdminRequestIpBanTaskUnbanPost({
    required String ipCidr,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ip_cidr': ipCidr};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/admin/request_ip_ban_task_unban',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> postGasetV1UserGasetPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/gaset',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postGacheckV1UserGacheckPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/gacheck',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> buyTrafficPackageV1UserShopBuytrafficpackagePost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/shop/buytrafficpackage',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getPlanInfoV1UserShopGetplaninfoGet({
    String? time,
    String? num,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'time': time, r'num': num};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/shop/getplaninfo',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getPlanTimeV1UserShopGetplantimeGet({
    required String? num,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'num': num};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/shop/getplantime',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getShopV1UserShopGet({
    int? page = 1,
    int? size = 15,
    FormalEnum? format,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
      r'format': format,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/shop/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getDetectV1UserDetectGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/detect/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getLogV1UserDetectLogGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/detect/log',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> ticketV1UserTicketGet({
    int? page = 1,
    int? size = 15,
    FormalEnum? format,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
      r'format': format,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/ticket/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postTicketV1UserTicketPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/ticket/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> putTicketV1UserTicketTicketIdPut({
    required int? ticketId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/ticket/${ticketId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getCreateV1UserTicketCreateGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/ticket/create',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getDetectV1UserTicketTicketIdViewGet({
    required int ticketId,
    int? page = 1,
    int? size = 5,
    FormalEnum? format,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
      r'format': format,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/ticket/${ticketId}/view',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<dynamic> postBuyPreV1UserBuyPrePost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<dynamic>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/buy_pre',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch(_options);
    final _value = _result.data;
    return _value;
  }

  @override
  Future<dynamic> postBuyPreV1UserBuyPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<dynamic>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/buy',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch(_options);
    final _value = _result.data;
    return _value;
  }

  @override
  Future<void> sspwdV1UserSspwdPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/sspwd',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> urlResetV1UserUrlResetGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/url_reset',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postBuyInviteV1UserBuyInvitePost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/buy_invite',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> passwordV1UserPasswordPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/password',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> boughtV1UserBoughtGet({
    FormalEnum? format = FormalEnum.valueJson,
    int? page = 1,
    int? size = 15,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'format': format,
      r'page': page,
      r'size': size,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/bought',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> deleteBoughtV1UserBoughtDelete({
    required BodyDeleteBoughtVUserBoughtDelete body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(
        method: 'DELETE',
        headers: _headers,
        extra: _extra,
        contentType: 'application/x-www-form-urlencoded',
      )
          .compose(
        _dio.options,
        '/v1/user/bought',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> checkinV1UserCheckinGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/checkin',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> checkinV1UserCheckinPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/checkin',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postPurchaseV1UserPaymentPurchasePost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/user/payment/purchase',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postResetV1PasswordResetPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/password/reset',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> postResetV1PasswordTokenTokenPost({
    required String token,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/password/token/${token}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getShopV1AppConfigGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/app/config',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getUserinfoV1LinkTokenGet({
    required String token,
    bool? surge = false,
    bool? quantumult = false,
    bool? quantumultx = false,
    bool? ssd = false,
    bool? clash = false,
    bool? isRemarkEmoji = true,
    bool? extend = false,
    SubscribeTypeEnum? list,
    int? sub,
    int? mu,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'surge': surge,
      r'quantumult': quantumult,
      r'quantumultx': quantumultx,
      r'ssd': ssd,
      r'clash': clash,
      r'is_remark_emoji': isRemarkEmoji,
      r'extend': extend,
      r'list': list,
      r'sub': sub,
      r'mu': mu,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/link/${token}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getLink2V1Link2TokenGet({
    required String token,
    bool? isNodeExtend,
    int? manualLinkGroup,
    SubLinkClientTypeEnum? clientType = SubLinkClientTypeEnum.auto,
    bool? isRemarkEmoji = true,
    bool? isProxyMode = false,
    String? filename = 'V2RayN',
    SuffixTypeEnum? suffixType = SuffixTypeEnum.txt,
    VpnTypeListEnum? vpnType = VpnTypeListEnum.vmess,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_node_extend': isNodeExtend,
      r'manual_link_group': manualLinkGroup,
      r'client_type': clientType,
      r'is_remark_emoji': isRemarkEmoji,
      r'is_proxy_mode': isProxyMode,
      r'filename': filename,
      r'suffix_type': suffixType,
      r'vpn_type': vpnType,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/link2/${token}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> authorizationV1AuthorizationGet({
    required String email,
    required String passwd,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'email': email,
      r'passwd': passwd,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/authorization',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getDetectV1NoticeGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/notice',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<List<SsNode>> readNodesApiV2AdminApiDbSsNodeGet({
    required String order,
    int? offset = 0,
    int? limit = 10000,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'order': order,
      r'offset': offset,
      r'limit': limit,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<SsNode>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/db/ss_node/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<SsNode> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => SsNode.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getNewUserApiV2AdminApiDbNewUserGet({
    required String order,
    int? offset = 0,
    int? limit = 10000,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'order': order,
      r'offset': offset,
      r'limit': limit,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/db/new_user/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ErrorResponse> rechargeItApiV2AdminApiUsrUserIdRechargeItPost({
    required int userId,
    required dynamic moneyAmount,
    String? remark = '',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'money_amount': moneyAmount.toJson(),
      r'remark': remark,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/usr/${userId}/recharge_it',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnnouncementResponse> getAnnouncementApiV2AdminApiAnnouncementGet({
    required AnnouncementEnum annType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AnnouncementResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/announcement',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnnouncementResponse _value;
    try {
      _value = AnnouncementResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnnouncementUpdateResponse>
  updateAnnouncementApiV2AdminApiAnnouncementPost({
    required AnnouncementEnum annType,
    String? body = '',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = body;
    final _options = _setStreamType<AnnouncementUpdateResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/announcement',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnnouncementUpdateResponse _value;
    try {
      _value = AnnouncementUpdateResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getAnnouncementHtmlApiV2AdminApiAnnouncementHtmlGet({
    required AnnouncementEnum annType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/announcement_html',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<String> getAnnouncementMarkdownApiV2AdminApiAnnouncementMarkdownGet({
    required AnnouncementEnum annType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<String>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/announcement_markdown',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<String>(_options);
    late String _value;
    try {
      _value = _result.data!;
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ReplaceEmailResponse>
  replaceUserEmailApiV2AdminApiReplaceUserEmailGet({
    required int userId,
    required String userOldEmail,
    required String userNewEmail,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'user_id': userId,
      r'user_old_email': userOldEmail,
      r'user_new_email': userNewEmail,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ReplaceEmailResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/replace_user_email',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ReplaceEmailResponse _value;
    try {
      _value = ReplaceEmailResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> test2510161ApiV2AdminApiMoveShopGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/admin_api/move_shop',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<AuthRegisterResponse> postIndexApiV2AuthAccountRegisterPost({
    required AccountRegisterParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<AuthRegisterResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/account_register/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AuthRegisterResponse _value;
    try {
      _value = AuthRegisterResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  postRequestEmailCodeApiV2AuthAccountRegisterRequestEmailCodePost({
    required RequestEmailCodeParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/account_register/request-email-code',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  postCheckInviteCodeApiV2AuthAccountRegisterCheckInviteCodePost({
    required CheckInviteCodeParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/account_register/check-invite-code',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse> postIndexApiV2AuthAccountResetPasswordPost({
    required AccountResetPasswordParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/account_reset_password/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  postRequestEmailCodeApiV2AuthAccountResetPasswordRequestEmailCodePost({
    required RequestEmailCodeParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/account_reset_password/request-email-code',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<LoginPostResultModel> loginPostApiV2AuthAccountLoginLoginPost({
    required WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<LoginPostResultModel>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/account_login/login',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late LoginPostResultModel _value;
    try {
      _value = LoginPostResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<RefreshPostResultModel>
  postJwtAccessRefreshApiV2AuthJwtTokenJwtAccessRefreshPost({
    required WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<RefreshPostResultModel>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/jwt_token/jwt_access_refresh',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late RefreshPostResultModel _value;
    try {
      _value = RefreshPostResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<PostLoginOldVResultModel>
  postLoginOldV1ApiV2AuthJwtTokenLoginOldV1Post({
    required WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<PostLoginOldVResultModel>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/auth/jwt_token/login_old_v1',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PostLoginOldVResultModel _value;
    try {
      _value = PostLoginOldVResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getUserLinkGroupApiV2CronTaskUserLinkGroupGet({
    bool? isAutoTrigger = false,
    bool? isAllFlush = false,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_auto_trigger': isAutoTrigger,
      r'is_all_flush': isAllFlush,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/cron_task/user_link_group',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<AnnouncementsGetResultModel>
  getAnnouncementsApiV2UserSystemAnnouncementsGet({
    AnnouncementEnum? annType = AnnouncementEnum.indexAnn,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ann_type': annType};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AnnouncementsGetResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/system/announcements',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnnouncementsGetResultModel _value;
    try {
      _value = AnnouncementsGetResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<TicketVGetResultModel> getIndexApiV2UserTicketsV2Get({
    int? page = 1,
    int? size = 10,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page, r'size': size};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<TicketVGetResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/tickets-v2/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late TicketVGetResultModel _value;
    try {
      _value = TicketVGetResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse> postIndexApiV2UserTicketsV2Post({
    required TicketVPostParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/tickets-v2/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserTicketsTicketIdEditStatusResponse>
  userTicketsTicketIdEditStatusApiV2UserTicketsV2TicketIdEditStatusPut({
    required int ticketId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserTicketsTicketIdEditStatusResponse>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/tickets-v2/${ticketId}/edit-status',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserTicketsTicketIdEditStatusResponse _value;
    try {
      _value = UserTicketsTicketIdEditStatusResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserTicketsTicketIdMessagesGetResponse>
  userTicketsTicketIdMessagesGetApiV2UserTicketsV2TicketIdMessagesGet({
    required int ticketId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserTicketsTicketIdMessagesGetResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/tickets-v2/${ticketId}/messages',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserTicketsTicketIdMessagesGetResponse _value;
    try {
      _value = UserTicketsTicketIdMessagesGetResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserTicketsTicketIdMessagesPostResponse>
  ticketIdSendMessagesApiV2UserTicketsV2TicketIdSendMessagesPost({
    required int ticketId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserTicketsTicketIdMessagesPostResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/tickets-v2/${ticketId}/send_messages',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserTicketsTicketIdMessagesPostResponse _value;
    try {
      _value = UserTicketsTicketIdMessagesPostResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountActivityResponse>
  userAccountActivityApiV2UserAccountActivityGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountActivityResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/activity',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountActivityResponse _value;
    try {
      _value = UserAccountActivityResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountEditEmailResponse>
  userAccountEditEmailApiV2UserAccountEditEmailPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountEditEmailResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/edit-email',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountEditEmailResponse _value;
    try {
      _value = UserAccountEditEmailResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountEditPasswordResponse>
  userAccountEditPasswordApiV2UserAccountEditPasswordPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountEditPasswordResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/edit-password',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountEditPasswordResponse _value;
    try {
      _value = UserAccountEditPasswordResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountEditProfileResponse>
  userAccountEditProfileApiV2UserAccountEditProfilePost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountEditProfileResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/edit-profile',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountEditProfileResponse _value;
    try {
      _value = UserAccountEditProfileResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountLinkTelegramResponse>
  userAccountLinkTelegramApiV2UserAccountLinkTelegramGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountLinkTelegramResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/link/telegram',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountLinkTelegramResponse _value;
    try {
      _value = UserAccountLinkTelegramResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountLoginIpLogResponse>
  userAccountLoginIpLogApiV2UserAccountLoginIpLogGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountLoginIpLogResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/login-ip-log',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountLoginIpLogResponse _value;
    try {
      _value = UserAccountLoginIpLogResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountMeResponse> userAccountMeApiV2UserAccountMeGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountMeResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/me',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountMeResponse _value;
    try {
      _value = UserAccountMeResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountSecurityGetResponse>
  userAccountSecurityGetApiV2UserAccountSecurityGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountSecurityGetResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/security',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountSecurityGetResponse _value;
    try {
      _value = UserAccountSecurityGetResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountSecurityPostResponse>
  userAccountSecurityPostApiV2UserAccountSecurityPost({
    required UserAccountSecurityPostRequest body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<UserAccountSecurityPostResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/security',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountSecurityPostResponse _value;
    try {
      _value = UserAccountSecurityPostResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountPasswordChangeResponse>
  userAccountChangePasswordApiV2UserAccountChangePasswordPost({
    required UserAccountPasswordChangeRequest body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<UserAccountPasswordChangeResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/change-password',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountPasswordChangeResponse _value;
    try {
      _value = UserAccountPasswordChangeResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserAccountLoginHistoryResponse>
  userAccountLoginHistoryApiV2UserAccountLoginHistoryGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserAccountLoginHistoryResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/account/login-history',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserAccountLoginHistoryResponse _value;
    try {
      _value = UserAccountLoginHistoryResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserInviteResponse> userInviteApiV2UserInviteGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserInviteResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/invite/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserInviteResponse _value;
    try {
      _value = UserInviteResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserInviteRecordResponse>
  userInviteRecordApiV2UserInviteRecordGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserInviteRecordResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/invite/record/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserInviteRecordResponse _value;
    try {
      _value = UserInviteRecordResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesSsPasswordResponse>
  userServicesSsPasswordApiV2UserServicesSsPasswordGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesSsPasswordResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/ss-password/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesSsPasswordResponse _value;
    try {
      _value = UserServicesSsPasswordResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesSsPasswordResetResponse>
  userServicesSsPasswordResetApiV2UserServicesSsPasswordResetPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesSsPasswordResetResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/ss-password/reset',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesSsPasswordResetResponse _value;
    try {
      _value = UserServicesSsPasswordResetResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesSubscribeLogAreaTimeAxisResponse>
  userServicesSubscribeLogAreaTimeAxisApiV2UserServicesSubscribeLogAreaTimeAxisGet(
      {
        int? limit = 10000,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'limit': limit};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<UserServicesSubscribeLogAreaTimeAxisResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/subscribe-log/area-time-axis',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesSubscribeLogAreaTimeAxisResponse _value;
    try {
      _value = UserServicesSubscribeLogAreaTimeAxisResponse.fromJson(
        _result.data!,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesSubscribeLogCalendarPieResponse>
  userServicesSubscribeLogCalendarPieApiV2UserServicesSubscribeLogCalendarPieGet(
      {
        String? yearMonth,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'year_month': yearMonth};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<UserServicesSubscribeLogCalendarPieResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/subscribe-log/calendar-pie',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesSubscribeLogCalendarPieResponse _value;
    try {
      _value = UserServicesSubscribeLogCalendarPieResponse.fromJson(
        _result.data!,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesSubscribeLogDetailRecordResponse>
  userServicesSubscribeLogDetailRecordApiV2UserServicesSubscribeLogDetailRecordGet(
      {
        int? offset = 0,
        int? limit,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<UserServicesSubscribeLogDetailRecordResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/subscribe-log/detail-record',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesSubscribeLogDetailRecordResponse _value;
    try {
      _value = UserServicesSubscribeLogDetailRecordResponse.fromJson(
        _result.data!,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesAuditRecordResponse>
  userServicesAuditRecordApiV2UserServicesAuditRecordGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesAuditRecordResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/audit/record',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesAuditRecordResponse _value;
    try {
      _value = UserServicesAuditRecordResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesAuditRuleResponse>
  userServicesAuditRuleApiV2UserServicesAuditRuleGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesAuditRuleResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/audit/rule',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesAuditRuleResponse _value;
    try {
      _value = UserServicesAuditRuleResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesLinkTokenResponse>
  userServicesLinkTokenApiV2UserServicesLinkTokenLinkTokenGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesLinkTokenResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/link-token/link-token/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesLinkTokenResponse _value;
    try {
      _value = UserServicesLinkTokenResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesLinkTokenResetResponse>
  userServicesLinkTokenResetApiV2UserServicesLinkTokenLinkTokenResetPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesLinkTokenResetResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/link-token/link-token/reset',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesLinkTokenResetResponse _value;
    try {
      _value = UserServicesLinkTokenResetResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesNodesResponse>
  userServicesNodesApiV2UserServicesNodesGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesNodesResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/nodes/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesNodesResponse _value;
    try {
      _value = UserServicesNodesResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesNodesNodeIdResponse>
  userServicesNodesNodeIdApiV2UserServicesNodesNodeIdGet({
    required int nodeId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesNodesNodeIdResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/nodes/${nodeId}/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesNodesNodeIdResponse _value;
    try {
      _value = UserServicesNodesNodeIdResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesNodesNodeIdResponse>
  userServicesNodesNodeIdApiV2UserServicesNodeIdGet({
    required int nodeId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesNodesNodeIdResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/${nodeId}/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesNodesNodeIdResponse _value;
    try {
      _value = UserServicesNodesNodeIdResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesShareAccountResponse>
  userServicesShareAccountApiV2UserServicesShareAccountGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesShareAccountResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services/share-account/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesShareAccountResponse _value;
    try {
      _value = UserServicesShareAccountResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesOldBillResponse>
  userServicesOldBillApiV2UserServicesOldBillGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesOldBillResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services-old/bill/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesOldBillResponse _value;
    try {
      _value = UserServicesOldBillResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesOldBillServiceIdResponse>
  userServicesOldBillServiceIdApiV2UserServicesOldBillServiceIdGet({
    required int serviceId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesOldBillServiceIdResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services-old/bill/${serviceId}/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesOldBillServiceIdResponse _value;
    try {
      _value = UserServicesOldBillServiceIdResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesOldBillServiceIdEnableAutoRenewalResponse>
  userServicesOldBillServiceIdEnableAutoRenewalApiV2UserServicesOldBillServiceIdEnableAutoRenewalGet(
      {
        required int serviceId,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<UserServicesOldBillServiceIdEnableAutoRenewalResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services-old/bill/${serviceId}/enable-auto-renewal',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesOldBillServiceIdEnableAutoRenewalResponse _value;
    try {
      _value = UserServicesOldBillServiceIdEnableAutoRenewalResponse.fromJson(
        _result.data!,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesOldCheckinGetResponse>
  userServicesOldCheckinGetApiV2UserServicesOldCheckinGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesOldCheckinGetResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services-old/checkin/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesOldCheckinGetResponse _value;
    try {
      _value = UserServicesOldCheckinGetResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesOldCheckinPostResponse>
  userServicesOldCheckinPostApiV2UserServicesOldCheckinPost() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesOldCheckinPostResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services-old/checkin/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesOldCheckinPostResponse _value;
    try {
      _value = UserServicesOldCheckinPostResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserServicesOldResponse>
  userServicesOldApiV2UserServicesOldGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserServicesOldResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/services-old/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserServicesOldResponse _value;
    try {
      _value = UserServicesOldResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserShopOldResult> userShopOldApiV2UserShopOldGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserShopOldResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/shop-old/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserShopOldResult _value;
    try {
      _value = UserShopOldResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserShopOldShopIdConfirmOrderResponse>
  userShopOldShopIdConfirmOrderApiV2UserShopOldShopIdConfirmOrderPost({
    required int shopId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserShopOldShopIdConfirmOrderResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/shop-old/${shopId}/confirm-order',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserShopOldShopIdConfirmOrderResponse _value;
    try {
      _value = UserShopOldShopIdConfirmOrderResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserShopOldShopIdPreOrderResponse>
  userShopOldShopIdPreOrderApiV2UserShopOldShopIdPreOrderPost({
    required int shopId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserShopOldShopIdPreOrderResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/shop-old/${shopId}/pre-order',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserShopOldShopIdPreOrderResponse _value;
    try {
      _value = UserShopOldShopIdPreOrderResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserShopOldShopIdConfirmOrderResult>
  getShopIdInfoApiV2UserShopOldShopIdInfoGet({required int shopId}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserShopOldShopIdConfirmOrderResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/shop-old/${shopId}/info',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserShopOldShopIdConfirmOrderResult _value;
    try {
      _value = UserShopOldShopIdConfirmOrderResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserWalletRechargeResult>
  userWalletRechargeApiV2UserWalletRechargeGet({
    int? offset = 0,
    int? limit,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserWalletRechargeResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/wallet/recharge/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserWalletRechargeResult _value;
    try {
      _value = UserWalletRechargeResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserWalletRechargeRechargeIdResponse>
  userWalletRechargeRechargeIdApiV2UserWalletRechargeRechargeIdPost({
    required int rechargeId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserWalletRechargeRechargeIdResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/wallet/recharge/${rechargeId}/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserWalletRechargeRechargeIdResponse _value;
    try {
      _value = UserWalletRechargeRechargeIdResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserWalletCdKeyResponse>
  userWalletCdKeyApiV2UserWalletCdKeyCdKeyGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserWalletCdKeyResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/wallet/cd-key/cd-key/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserWalletCdKeyResponse _value;
    try {
      _value = UserWalletCdKeyResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserWalletCdKeyCdKeyResponse>
  userWalletCdKeyCdKeyApiV2UserWalletCdKeyCdKeyPost({
    required String cdKey,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserWalletCdKeyCdKeyResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/wallet/cd-key/${cdKey}/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserWalletCdKeyCdKeyResponse _value;
    try {
      _value = UserWalletCdKeyCdKeyResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserWalletResult> userWalletApiV2UserWalletGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserWalletResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/wallet/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserWalletResult _value;
    try {
      _value = UserWalletResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<PurchaseRecordsResult>
  getUserPurchaseRecordsApiV2UserWalletPurchaseRecordsGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PurchaseRecordsResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/wallet/purchase-records',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PurchaseRecordsResult _value;
    try {
      _value = PurchaseRecordsResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetDashboardResultModel> getIndexApiV2UserDashboardGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetDashboardResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/dashboard/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetDashboardResultModel _value;
    try {
      _value = GetDashboardResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<IndexGetResultModel> getIndexApiV2UserGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<IndexGetResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late IndexGetResultModel _value;
    try {
      _value = IndexGetResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetMeGetResultModel> getGetMeApiV2UserGetMeGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetMeGetResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/get_me',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetMeGetResultModel _value;
    try {
      _value = GetMeGetResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetOldServiceResultModel>
  getOldServiceApiV2UserGetOldServiceGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetOldServiceResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/get_old_service',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetOldServiceResultModel _value;
    try {
      _value = GetOldServiceResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CrispDataResultModel> getCrispDataApiV2UserCrispDataGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<CrispDataResultModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/user/crisp_data',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late CrispDataResultModel _value;
    try {
      _value = CrispDataResultModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> postNodeConfigApiV2ToolsPydanticCheckSsNodeNodeConfigPost({
    required NodeConfig body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<void>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/tools/pydantic_check/ss_node/node_config',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<GetSearchUserResult> getSearchUserApiV2GrafanaAdminViewSearchUserGet({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetSearchUserResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_admin_view/search_user',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetSearchUserResult _value;
    try {
      _value = GetSearchUserResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetServiceOldShopResult>
  getServiceOldShopApiV2GrafanaAdminViewServiceOldShopGet({String? q}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': q};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetServiceOldShopResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_admin_view/service_old_shop',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetServiceOldShopResult _value;
    try {
      _value = GetServiceOldShopResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetViewUserResult> getViewUserApiV2GrafanaAdminViewViewUserGet({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetViewUserResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_admin_view/view_user',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetViewUserResult _value;
    try {
      _value = GetViewUserResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetViewUserBoughtResult>
  getViewUserBoughtApiV2GrafanaAdminViewViewUserBoughtGet({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetViewUserBoughtResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_admin_view/view_user_bought',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetViewUserBoughtResult _value;
    try {
      _value = GetViewUserBoughtResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserDataHistoryResponse>
  getUserDataHistoryChApiV2GrafanaAdminViewUserDataHistoryChGet({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<UserDataHistoryResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_admin_view/user_data_history_ch',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserDataHistoryResponse _value;
    try {
      _value = UserDataHistoryResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getUserTrafficLogFullChApiV2GrafanaViewUserTrafficLogFullChGet({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_view/user_traffic_log_full_ch',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void>
  getUserTrafficLogUserTrafficApiV2GrafanaViewUserTrafficLogUserTrafficGet({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/grafana_view/user_traffic_log_user_traffic',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<ErrorResponse>
  putUserOldServiceApiV2LowAdminApiUserOldServiceUserIdPut({
    required int userId,
    required WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut
    body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_old_service/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  patchUserOldServiceApiV2LowAdminApiUserOldServiceUserIdPatch({
    required int userId,
    required WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch
    body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'PATCH', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_old_service/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<
      WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
  >
  getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet({
    required int userId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<
        WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
    >(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_old_service/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
    _value;
    try {
      _value =
          WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
              .fromJson(
            _result.data!,
          );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse> putUserV2ApiV2LowAdminApiUserV2UserIdPut({
    required int userId,
    required WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_v2/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse> patchUserV2ApiV2LowAdminApiUserV2UserIdPatch({
    required int userId,
    required WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'PATCH', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_v2/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse>
  getUserV2ByUserIdApiV2LowAdminApiUserV2UserIdGet({
    required int userId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<
        WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse
    >(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_v2/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse
    _value;
    try {
      _value =
          WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse
              .fromJson(
            _result.data!,
          );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetSearchUserResult> getUserV2ApiV2LowAdminApiUserV2Get({
    int? sqlStmtLimit = 3000,
    String? q,
    DateTime? fromIso,
    DateTime? toIso,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sql_stmt_limit': sqlStmtLimit,
      r'q': q,
      r'from_iso': fromIso?.toIso8601String(),
      r'to_iso': toIso?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetSearchUserResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_v2/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetSearchUserResult _value;
    try {
      _value = GetSearchUserResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse>
  getUserBoughtApiV2LowAdminApiUserBoughtGet({
    int? limit = 3000,
    int? userId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'user_id': userId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<
        WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse
    >(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_bought/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse
    _value;
    try {
      _value =
          WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse
              .fromJson(
            _result.data!,
          );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  deleteUserBoughtApiV2LowAdminApiUserBoughtBoughtIdDelete({
    required int boughtId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'DELETE', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_bought/${boughtId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse> putUserBoughtApiV2LowAdminApiUserBoughtBoughtIdPut({
    required int boughtId,
    required WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_bought/${boughtId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetUserMoneyResponse>
  getUserV2ByUserIdApiV2LowAdminApiUserMoneyUserIdGet({
    required int userId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetUserMoneyResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_money/${userId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetUserMoneyResponse _value;
    try {
      _value = GetUserMoneyResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  postUserMoneyMoneyRechargeItApiV2LowAdminApiUserMoneyMoneyRechargeItUserIdPost(
      {
        required int userId,
        required WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel
        body,
      }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_money_money_recharge_it/${userId}/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse>
  getUserPayListApiV2LowAdminApiUserPayListGet({
    int? limit = 3000,
    int? userId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'user_id': userId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
    _setStreamType<
        WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse
    >(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_pay_list/',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(
        baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      ),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse
    _value;
    try {
      _value =
          WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse
              .fromJson(
            _result.data!,
          );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  deleteUserPayListApiV2LowAdminApiUserPayListUserPayListIdDelete({
    required String userPayListId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'DELETE', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_pay_list/${userPayListId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ErrorResponse>
  putUserPayListApiV2LowAdminApiUserPayListUserPayListIdPut({
    required String userPayListId,
    required WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModel body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<ErrorResponse>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/low_admin_api/user_pay_list/${userPayListId}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ErrorResponse _value;
    try {
      _value = ErrorResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CaptchaKeyModel> getCaptchaKeyApiV2CaptchaKeyGet({
    required CaptchaKeyTypeEnum captchaKeyType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'captcha_key_type': captchaKeyType,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<CaptchaKeyModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/captcha-key',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late CaptchaKeyModel _value;
    try {
      _value = CaptchaKeyModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetCsrfTokenResult> getCsrfTokenApiV2CsrfGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetCsrfTokenResult>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/v2/csrf',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetCsrfTokenResult _value;
    try {
      _value = GetCsrfTokenResult.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetVersionModel> getVersionApiVersionGet() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetVersionModel>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/api/version',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late GetVersionModel _value;
    try {
      _value = GetVersionModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> getUserinfoLinkTokenGet({
    required String token,
    bool? surge = false,
    bool? quantumult = false,
    bool? quantumultx = false,
    bool? ssd = false,
    bool? clash = false,
    bool? isRemarkEmoji = true,
    bool? extend = false,
    SubscribeTypeEnum? list,
    int? sub,
    int? mu,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'surge': surge,
      r'quantumult': quantumult,
      r'quantumultx': quantumultx,
      r'ssd': ssd,
      r'clash': clash,
      r'is_remark_emoji': isRemarkEmoji,
      r'extend': extend,
      r'list': list,
      r'sub': sub,
      r'mu': mu,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/link/${token}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<void> getLink2Link2TokenGet({
    required String token,
    bool? isNodeExtend,
    int? manualLinkGroup,
    SubLinkClientTypeEnum? clientType = SubLinkClientTypeEnum.auto,
    bool? isRemarkEmoji = true,
    bool? isProxyMode = false,
    String? filename = 'V2RayN',
    SuffixTypeEnum? suffixType = SuffixTypeEnum.txt,
    VpnTypeListEnum? vpnType = VpnTypeListEnum.vmess,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'is_node_extend': isNodeExtend,
      r'manual_link_group': manualLinkGroup,
      r'client_type': clientType,
      r'is_remark_emoji': isRemarkEmoji,
      r'is_proxy_mode': isProxyMode,
      r'filename': filename,
      r'suffix_type': suffixType,
      r'vpn_type': vpnType,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/link2/${token}',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl
        .trim()
        .isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
