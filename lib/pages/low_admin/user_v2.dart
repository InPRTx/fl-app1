import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/pages/low_admin/widgets/editable_user_old_service_card.dart';
import 'package:fl_app1/pages/low_admin/widgets/editable_user_v2_info_card.dart';
import 'package:flutter/material.dart';

class UserV2Page extends StatefulWidget {
  final int userId;

  const UserV2Page({super.key, required this.userId});

  @override
  State<UserV2Page> createState() => _UserV2PageState();
}

class _UserV2PageState extends State<UserV2Page> {
  final Dio _dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
  late final RestClient _restClient = RestClient(
    _dio,
    baseUrl: kDefaultBaseUrl,
  );

  bool _isLoading = false;
  AdminUserV? _userV2Data;
  AdminOldService? _userOldServiceData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final client = _restClient.fallback;

    final results = await Future.wait<dynamic>([
      client.getUserV2ByUserIdApiV2LowAdminApiUserV2UserIdGet(
        userId: widget.userId,
      ),
      client.getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet(
        userId: widget.userId,
      ),
    ]);

    setState(() {
      _isLoading = false;
      _userV2Data =
          (results[0]
                  as WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse)
              .result;
      _userOldServiceData =
          (results[1]
                  as WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse)
              .result;
    });
  }

  Future<bool> _updateUserV2Field(String field, dynamic value) async {
    final Map<String, dynamic> body = {};

    switch (field) {
      case 'email':
        body['email'] = value as String;
        break;
      case 'userName':
        body['user_name'] = value as String;
        break;
      case 'isEnable':
        body['is_enable'] = value as bool;
        break;
      case 'telegramId':
        body['telegram_id'] = value as int?;
        break;
      case 'isEmailVerify':
        body['is_email_verify'] = value as bool;
        break;
      case 'userAccountExpireIn':
        final localTime = value as DateTime;
        final utcTime = localTime.toUtc();
        print('📅 本地时间: $localTime (isUtc: ${localTime.isUtc})');
        print('📅 UTC时间: $utcTime (isUtc: ${utcTime.isUtc})');
        body['user_account_expire_in'] = utcTime.toIso8601String();
        break;
      default:
        return false;
    }

    final response = await _dio.patch<Map<String, dynamic>>(
      '/api/v2/low_admin_api/user_v2/${widget.userId}',
      data: body,
    );

    if (response.statusCode == 200 && response.data?['is_success'] == true) {
      await _loadUserData();
      return true;
    }
    return false;
  }

  Future<bool> _updateUserOldServiceField(String field, dynamic value) async {
    final Map<String, dynamic> body = {};

    switch (field) {
      case 'ssUploadSize':
        body['ss_upload_size'] = value as int;
        break;
      case 'ssDownloadSize':
        body['ss_download_size'] = value as int;
        break;
      case 'ssBandwidthTotalSize':
        body['ss_bandwidth_total_size'] = value as int;
        break;
      case 'ssBandwidthYesterdayUsedSize':
        body['ss_bandwidth_yesterday_used_size'] = value as int;
        break;
      case 'userLevel':
        body['user_level'] = value as int;
        break;
      case 'userLevelExpireIn':
        final localTime = value as DateTime;
        final utcTime = localTime.toUtc();
        print('📅 本地时间: $localTime (isUtc: ${localTime.isUtc})');
        print('📅 UTC时间: $utcTime (isUtc: ${utcTime.isUtc})');
        body['user_level_expire_in'] = utcTime.toIso8601String();
        break;
      case 'nodeSpeedLimit':
        body['node_speed_limit'] = value as int?;
        break;
      case 'nodeConnector':
        body['node_connector'] = value as int;
        break;
      case 'autoResetDay':
        body['auto_reset_day'] = value as int;
        break;
      case 'autoResetBandwidth':
        body['auto_reset_bandwidth'] = value as num;
        break;
      default:
        return false;
    }

    final response = await _dio.patch<Map<String, dynamic>>(
      '/api/v2/low_admin_api/user_old_service/${widget.userId}',
      data: body,
    );

    if (response.statusCode == 200 && response.data?['is_success'] == true) {
      await _loadUserData();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户信息 - ID: ${widget.userId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadUserData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red[700]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadUserData,
                    child: const Text('重试'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  EditableUserV2InfoCard(
                    userData: _userV2Data,
                    onFieldUpdate: _updateUserV2Field,
                  ),
                  const SizedBox(height: 16),
                  EditableUserOldServiceCard(
                    serviceData: _userOldServiceData,
                    onFieldUpdate: _updateUserOldServiceField,
                  ),
                ],
              ),
            ),
    );
  }
}
