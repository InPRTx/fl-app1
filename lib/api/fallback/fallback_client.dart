// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/account_register_params_model.dart';
import '../models/account_reset_password_params_model.dart';
import '../models/admin_old_service_input.dart';
import '../models/admin_user_v.dart';
import '../models/announcement_enum.dart';
import '../models/announcement_response.dart';
import '../models/announcement_update_response.dart';
import '../models/announcements_get_result_model.dart';
import '../models/auth_register_response.dart';
import '../models/captcha_key_model.dart';
import '../models/captcha_key_type_enum.dart';
import '../models/check_invite_code_params_model.dart';
import '../models/crisp_data_result_model.dart';
import '../models/error_response.dart';
import '../models/fastapi_compat_v_body_delete_bought_v_user_bought_delete.dart';
import '../models/get_csrf_token_result.dart';
import '../models/get_dashboard_result_model.dart';
import '../models/get_me_get_result_model.dart';
import '../models/get_old_service_result_model.dart';
import '../models/get_old_service_shop_list_response.dart';
import '../models/get_old_service_shop_response.dart';
import '../models/get_search_user_result.dart';
import '../models/get_service_old_shop_result.dart';
import '../models/get_ss_node_list_response.dart';
import '../models/get_ss_node_response.dart';
import '../models/get_ticket_detail_response.dart';
import '../models/get_ticket_list_response.dart';
import '../models/get_user_infos_response.dart';
import '../models/get_user_money_response.dart';
import '../models/get_usernames_request.dart';
import '../models/get_usernames_response.dart';
import '../models/get_version_model.dart';
import '../models/get_view_user_bought_result.dart';
import '../models/get_view_user_result.dart';
import '../models/index_get_result_model.dart';
import '../models/login_post_result_model.dart';
import '../models/login_web_version_enum.dart';
import '../models/node_config.dart';
import '../models/old_service_shop_input.dart';
import '../models/post_add_alive_ip_model.dart';
import '../models/post_add_detect_log_model.dart';
import '../models/post_func_block_ip_model.dart';
import '../models/post_login_old_v_result_model.dart';
import '../models/post_traffic_model.dart';
import '../models/purchase_records_result.dart';
import '../models/refresh_post_result_model.dart';
import '../models/replace_email_response.dart';
import '../models/reply_params.dart';
import '../models/request_email_code_params_model.dart';
import '../models/ss_node_input.dart';
import '../models/ss_node_output.dart';
import '../models/sub_link_client_type_enum.dart';
import '../models/subscribe_type_enum.dart';
import '../models/suffix_type_enum.dart';
import '../models/system_meta_data_announcement_model.dart';
import '../models/ticket_v_get_result_model.dart';
import '../models/ticket_v_post_params_model.dart';
import '../models/total_node_list.dart';
import '../models/total_user_list.dart';
import '../models/type_mode_enum.dart';
import '../models/user_account_activity_response.dart';
import '../models/user_account_edit_email_response.dart';
import '../models/user_account_edit_password_response.dart';
import '../models/user_account_edit_profile_response.dart';
import '../models/user_account_link_telegram_response.dart';
import '../models/user_account_login_history_response.dart';
import '../models/user_account_login_ip_log_response.dart';
import '../models/user_account_me_response.dart';
import '../models/user_account_password_change_request.dart';
import '../models/user_account_password_change_response.dart';
import '../models/user_account_security_get_response.dart';
import '../models/user_account_security_post_request.dart';
import '../models/user_account_security_post_response.dart';
import '../models/user_data_history_response.dart';
import '../models/user_invite_record_response.dart';
import '../models/user_invite_response.dart';
import '../models/user_services_audit_record_response.dart';
import '../models/user_services_audit_rule_response.dart';
import '../models/user_services_link_token_reset_response.dart';
import '../models/user_services_link_token_response.dart';
import '../models/user_services_nodes_node_id_response.dart';
import '../models/user_services_nodes_response.dart';
import '../models/user_services_old_bill_response.dart';
import '../models/user_services_old_bill_service_id_enable_auto_renewal_response.dart';
import '../models/user_services_old_bill_service_id_response.dart';
import '../models/user_services_old_checkin_get_response.dart';
import '../models/user_services_old_checkin_post_response.dart';
import '../models/user_services_old_response.dart';
import '../models/user_services_share_account_response.dart';
import '../models/user_services_ss_password_reset_response.dart';
import '../models/user_services_ss_password_response.dart';
import '../models/user_services_subscribe_log_area_time_axis_response.dart';
import '../models/user_services_subscribe_log_calendar_pie_response.dart';
import '../models/user_services_subscribe_log_detail_record_response.dart';
import '../models/user_shop_old_result.dart';
import '../models/user_shop_old_shop_id_confirm_order_response.dart';
import '../models/user_shop_old_shop_id_confirm_order_result.dart';
import '../models/user_shop_old_shop_id_pre_order_response.dart';
import '../models/user_tickets_ticket_id_edit_status_response.dart';
import '../models/user_tickets_ticket_id_messages_get_response.dart';
import '../models/user_tickets_ticket_id_messages_post_response.dart';
import '../models/user_wallet_cd_key_cd_key_response.dart';
import '../models/user_wallet_cd_key_response.dart';
import '../models/user_wallet_recharge_recharge_id_response.dart';
import '../models/user_wallet_recharge_result.dart';
import '../models/user_wallet_result.dart';
import '../models/version_response_model.dart';
import '../models/vpn_type_list_enum.dart';
import '../models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';
import '../models/web_sub_fastapi_routers_api_v_auth_jwt_token_access_refresh_params_model.dart';
import '../models/web_sub_fastapi_routers_api_v_auth_jwt_token_login_old_v_params_model.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_bought_get_user_bought_response.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_bought_put_params_model.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_money_money_recharge_it_params_model.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_old_service_get_user_old_service_response.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_pay_list_get_user_bought_response.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_pay_list_put_params_model.dart';
import '../models/web_sub_fastapi_routers_api_v_low_admin_api_user_v_get_user_old_service_response.dart';
import '../models/web_sub_fastapi_routers_v_casino_function_sql_table_enum.dart';
import '../models/web_sub_fastapi_routers_v_emby_function_sql_table_enum.dart';
import '../models/web_sub_fastapi_routers_v_user_ticket_view_formal_enum.dart';

part 'fallback_client.g.dart';

@RestApi()
abstract class FallbackClient {
  factory FallbackClient(Dio dio, {String? baseUrl}) = _FallbackClient;

  /// Get Healthcheck
  @GET('/health')
  Future<void> getHealthcheckHealthGet();

  /// Get Healthcheck
  @GET('/ip')
  Future<void> getHealthcheckIpGet();

  /// Get Version
  @GET('/v1/version')
  Future<VersionResponseModel> getVersionV1VersionGet();

  /// Emby Function.
  ///
  /// emby bot配合脚本.
  @GET('/v1/emby_function')
  Future<void> embyFunctionV1EmbyFunctionGet({
    @Query('api_key') required String apiKey,
    @Query('sql_table')
    required WebSubFastapiRoutersVEmbyFunctionSqlTableEnum sqlTable,
    @Query('sql_table_user_id') int? sqlTableUserId,
    @Query('sql_table_link_token') String? sqlTableLinkToken,
  });

  /// Casino Function.
  ///
  /// emby bot配合脚本.
  @GET('/v1/casino_function')
  Future<void> casinoFunctionV1CasinoFunctionGet({
    @Query('api_key') required String apiKey,
    @Query('sql_table')
    required WebSubFastapiRoutersVCasinoFunctionSqlTableEnum sqlTable,
    @Query('sql_table_telegram_id') int? sqlTableTelegramId,
    @Query('sql_table_add_transfer_enable') int? sqlTableAddTransferEnable,
    @Query('type_mode') TypeModeEnum? typeMode,
  });

  /// Get Userinfo
  @GET('/v1/emby_link/{token}')
  Future<void> getUserinfoV1EmbyLinkTokenGet({
    @Path('token') required String token,
  });

  /// Get Emby Link List
  @GET('/v1/emby_link_list')
  Future<void> getEmbyLinkListV1EmbyLinkListGet({
    @Query('api_key') required String apiKey,
  });

  /// Get Notify
  @GET('/v1/payment/notify/{payment_system}')
  Future<void> getNotifyV1PaymentNotifyPaymentSystemGet({
    @Path('payment_system') required String paymentSystem,
  });

  /// Post Notify
  @POST('/v1/payment/notify/{payment_system}')
  Future<void> postNotifyV1PaymentNotifyPaymentSystemPost({
    @Path('payment_system') required String paymentSystem,
  });

  /// Post Status
  @POST('/v1/payment/status')
  Future<void> postStatusV1PaymentStatusPost({
    @Query('tradeno') required String tradeno,
  });

  /// Admin Notify
  @GET('/v1/payment/admin_notify_by_cookies')
  Future<void> adminNotifyV1PaymentAdminNotifyByCookiesGet({
    @Query('out_trade_no') required String outTradeNo,
  });

  /// Admin Notify
  @GET('/v1/payment/admin_notify')
  Future<void> adminNotifyV1PaymentAdminNotifyGet({
    @Query('out_trade_no') required String outTradeNo,
  });

  /// Cron Queue User Post.
  ///
  /// 每分钟从队列中取出数据并处理.
  @GET('/v1/mod_mu/cron_queue_user_post')
  Future<void> cronQueueUserPostV1ModMuCronQueueUserPostGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Func Detect Rules
  @GET('/v1/mod_mu/func/detect_rules')
  Future<void> getFuncDetectRulesV1ModMuFuncDetectRulesGet();

  /// Get Func Detect Rules
  @GET('/v1/mod_mu/func/relay_rules')
  Future<void> getFuncDetectRulesV1ModMuFuncRelayRulesGet();

  /// Get Func Block Ip
  @GET('/v1/mod_mu/func/block_ip')
  Future<void> getFuncBlockIpV1ModMuFuncBlockIpGet();

  /// Post Func Block Ip
  @POST('/v1/mod_mu/func/block_ip')
  Future<void> postFuncBlockIpV1ModMuFuncBlockIpPost({
    @Body() required PostFuncBlockIpModel body,
  });

  /// Get Func Unblock Ip
  @GET('/v1/mod_mu/func/unblock_ip')
  Future<void> getFuncUnblockIpV1ModMuFuncUnblockIpGet();

  /// Post Func Speedtest
  @POST('/v1/mod_mu/func/speedtest')
  Future<void> postFuncSpeedtestV1ModMuFuncSpeedtestPost();

  /// Get Func Autoexec
  @GET('/v1/mod_mu/func/autoexec')
  Future<void> getFuncAutoexecV1ModMuFuncAutoexecGet();

  /// Post Func Autoexec
  @POST('/v1/mod_mu/func/autoexec')
  Future<void> postFuncAutoexecV1ModMuFuncAutoexecPost();

  /// Post Func Ping
  @POST('/v1/mod_mu/func/ping')
  Future<void> postFuncPingV1ModMuFuncPingPost();

  /// Get Node Info
  @GET('/v1/mod_mu/nodes/{id}/info')
  Future<void> getNodeInfoV1ModMuNodesIdInfoGet({@Path('id') required int id});

  /// Post Nodes Info
  @POST('/v1/mod_mu/nodes/{id}/info')
  Future<void> postNodesInfoV1ModMuNodesIdInfoPost({
    @Path('id') required int id,
  });

  /// Get Nodes
  @GET('/v1/mod_mu/nodes')
  Future<void> getNodesV1ModMuNodesGet();

  /// Post Nodes Config.
  ///
  /// 无需实现.
  /// :return:.
  @POST('/v1/mod_mu/nodes/config')
  Future<void> postNodesConfigV1ModMuNodesConfigPost();

  /// Get Users
  @GET('/v1/mod_mu/users')
  Future<void> getUsersV1ModMuUsersGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
    @Query('skip_cache_key') String? skipCacheKey,
  });

  /// Get Users Traffic
  @POST('/v1/mod_mu/users/traffic')
  Future<void> getUsersTrafficV1ModMuUsersTrafficPost({
    @Body() required PostTrafficModel body,
  });

  /// Add Alive Ip
  @POST('/v1/mod_mu/users/aliveip')
  Future<void> addAliveIpV1ModMuUsersAliveipPost({
    @Body() required PostAddAliveIpModel body,
  });

  /// Add Detect Log
  @POST('/v1/mod_mu/users/detectlog')
  Future<void> addDetectLogV1ModMuUsersDetectlogPost({
    @Body() required PostAddDetectLogModel body,
  });

  /// Active Check Paylist.
  ///
  /// 每分钟从队列中取出数据并处理.
  @GET('/v1/mod_mu/active_check_paylist')
  Future<void> activeCheckPaylistV1ModMuActiveCheckPaylistGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Clickhouse Import User Traffic Raw
  @GET('/v1/mod_mu/clickhouse_import_user_traffic_raw')
  Future<void>
  clickhouseImportUserTrafficRawV1ModMuClickhouseImportUserTrafficRawGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Clickhouse Import Mod Mu User Alive Ip
  @GET('/v1/mod_mu/clickhouse_import_mod_mu_user_alive_ip')
  Future<void>
  clickhouseImportModMuUserAliveIpV1ModMuClickhouseImportModMuUserAliveIpGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Cron 1Min Task All.
  ///
  /// 每分钟执行一次的定时任务.
  @GET('/v1/mod_mu/cron_1min_task_all')
  Future<ErrorResponse> cron1minTaskAllV1ModMuCron1minTaskAllGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Check User Password.
  ///
  /// 每分钟从队列中取出数据并处理.
  @GET('/v1/mod_mu/check_user_password')
  Future<void> checkUserPasswordV1ModMuCheckUserPasswordGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Cron Ban Task
  @GET('/v1/mod_mu/cron_ban_task')
  Future<ErrorResponse> getCronBanTaskV1ModMuCronBanTaskGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Daily Job
  @POST('/v1/mod_mu/daily_job')
  Future<void> getDailyJobV1ModMuDailyJobPost({
    @Query('api_token_uuid') String? apiTokenUuid,
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Check Job
  @POST('/v1/mod_mu/check_job')
  Future<void> getCheckJobV1ModMuCheckJobPost({
    @Query('api_token_uuid') String? apiTokenUuid,
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Clickhouse Import Clickhouse Import User Data History
  @GET('/v1/mod_mu/clickhouse_import_user_data_history')
  Future<void>
  clickhouseImportClickhouseImportUserDataHistoryV1ModMuClickhouseImportUserDataHistoryGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Check Old Service Auto Renew
  @POST('/v1/mod_mu/check_old_service_auto_renew')
  Future<void> getCheckOldServiceAutoRenewV1ModMuCheckOldServiceAutoRenewPost({
    @Query('api_token_uuid') String? apiTokenUuid,
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Clickhouse Import User Traffic Log Total
  @GET('/v1/mod_mu/clickhouse_import_user_traffic_log_total')
  Future<void>
  getClickhouseImportUserTrafficLogTotalV1ModMuClickhouseImportUserTrafficLogTotalGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
  });

  /// Get Login
  @GET('/v1/auth/login')
  Future<void> getLoginV1AuthLoginGet();

  /// Post Login
  @POST('/v1/auth/login')
  Future<void> postLoginV1AuthLoginPost();

  /// Get Login
  @GET('/v1/auth/register')
  Future<void> getLoginV1AuthRegisterGet();

  /// Post Register
  @POST('/v1/auth/register')
  Future<void> postRegisterV1AuthRegisterPost();

  /// Post Login
  @POST('/v1/auth/send')
  Future<void> postLoginV1AuthSendPost();

  /// Post Qrcode Check
  @POST('/v1/auth/qrcode_login')
  Future<void> postQrcodeCheckV1AuthQrcodeLoginPost();

  /// By Url
  @GET('/v1/auth/by_url')
  Future<void> byUrlV1AuthByUrlGet({
    @Query('created_at_unix') required int createdAtUnix,
    @Query('valid_token') required String validToken,
    @Query('input_data') required String inputData,
    @Query('login_web_version')
    LoginWebVersionEnum? loginWebVersion = LoginWebVersionEnum.v1,
  });

  /// Get Admin Total Node D
  @POST('/v1/total/traffic/node/{node_id}')
  Future<void> getAdminTotalNodeDV1TotalTrafficNodeNodeIdPost({
    @Path('node_id') required int nodeId,
    @Body() required TotalNodeList body,
  });

  /// Get User By Month Calendar Pie
  @GET('/v1/total/traffic/user_by_month_calendar_pie/{token_uuid}')
  Future<void>
  getUserByMonthCalendarPieV1TotalTrafficUserByMonthCalendarPieTokenUuidGet({
    @Path('token_uuid') required String tokenUuid,
    @Query('year_month') String? yearMonth,
  });

  /// Get User Area Time Axis
  @GET('/v1/total/traffic/user_area_time_axis/{token_uuid}')
  Future<void> getUserAreaTimeAxisV1TotalTrafficUserAreaTimeAxisTokenUuidGet({
    @Path('token_uuid') required String tokenUuid,
    @Query('limit') dynamic limit = 10000,
  });

  /// Get Admin Total User D
  @POST('/v1/total/traffic/user/{user_id}')
  Future<void> getAdminTotalUserDV1TotalTrafficUserUserIdPost({
    @Path('user_id') required int userId,
    @Body() required TotalUserList body,
  });

  /// Get Announcement
  @GET('/v1/admin/announcement')
  Future<SystemMetaDataAnnouncementModel>
  getAnnouncementV1AdminAnnouncementGet({
    @Query('ann_type') required AnnouncementEnum annType,
  });

  /// Post Announcement
  @POST('/v1/admin/announcement')
  Future<void> postAnnouncementV1AdminAnnouncementPost({
    @Query('ann_type') required AnnouncementEnum annType,
    @Body() String? body = '',
  });

  /// Get Announcement
  @GET('/v1/admin/announcement_html')
  Future<void> getAnnouncementV1AdminAnnouncementHtmlGet({
    @Query('ann_type') required AnnouncementEnum annType,
  });

  /// Get Announcement
  @GET('/v1/admin/announcement_markdown')
  Future<String> getAnnouncementV1AdminAnnouncementMarkdownGet({
    @Query('ann_type') required AnnouncementEnum annType,
  });

  /// Gen User Link V1
  @GET('/v1/admin/gen_user_link_v1')
  Future<void> genUserLinkV1V1AdminGenUserLinkV1Get({
    @Query('a1_host') required String a1Host,
    @Query('a2_host') required String a2Host,
    @Query('a3_host') required String a3Host,
    @Query('a1_port') int? a1Port,
    @Query('a2_port') int? a2Port,
    @Query('a3_port') int? a3Port,
  });

  /// Post User Ban Task Insert
  @POST('/v1/admin/user_ban_task_insert')
  Future<ErrorResponse> postUserBanTaskInsertV1AdminUserBanTaskInsertPost({
    @Query('user_id') required int userId,
    @Query('task_end_at') required DateTime taskEndAt,
    @Query('is_need_send_email') bool? isNeedSendEmail = true,
    @Query('ban_context') String? banContext = '管理员禁封用户',
    @Query('remark') String? remark = '',
    @Query('task_start_at') DateTime? taskStartAt,
  });

  /// Post User Ban Task Unban
  @POST('/v1/admin/user_ban_task_unban')
  Future<ErrorResponse> postUserBanTaskUnbanV1AdminUserBanTaskUnbanPost({
    @Query('user_id') required int userId,
  });

  /// Replace User Email
  @GET('/v1/admin/replace_user_email')
  Future<void> replaceUserEmailV1AdminReplaceUserEmailGet({
    @Query('user_id') required int userId,
    @Query('user_old_email') required String userOldEmail,
    @Query('user_new_email') required String userNewEmail,
  });

  /// Post Request Ip Ban Task Insert
  @POST('/v1/admin/request_ip_ban_task_insert')
  Future<ErrorResponse>
  postRequestIpBanTaskInsertV1AdminRequestIpBanTaskInsertPost({
    @Query('ip_cidr') required String ipCidr,
    @Query('task_end_at') required DateTime taskEndAt,
    @Query('ban_context') String? banContext = '管理员禁封IP',
    @Query('remark') String? remark = '',
    @Query('task_start_at') DateTime? taskStartAt,
  });

  /// Post Request Ip Ban Task Unban
  @POST('/v1/admin/request_ip_ban_task_unban')
  Future<ErrorResponse>
  postRequestIpBanTaskUnbanV1AdminRequestIpBanTaskUnbanPost({
    @Query('ip_cidr') required String ipCidr,
  });

  /// Post Gaset
  @POST('/v1/user/gaset')
  Future<void> postGasetV1UserGasetPost();

  /// Post Gacheck
  @POST('/v1/user/gacheck')
  Future<void> postGacheckV1UserGacheckPost();

  /// Buy Traffic Package.
  ///
  /// 购买流量套餐.
  @POST('/v1/user/shop/buytrafficpackage')
  Future<void> buyTrafficPackageV1UserShopBuytrafficpackagePost();

  /// Get Plan Info.
  ///
  /// 获取可购买的套餐.
  @GET('/v1/user/shop/getplaninfo')
  Future<void> getPlanInfoV1UserShopGetplaninfoGet({
    @Query('time') String? time,
    @Query('num') String? num,
  });

  /// Get Plan Time.
  ///
  /// 获取可购买的套餐时间.
  @GET('/v1/user/shop/getplantime')
  Future<void> getPlanTimeV1UserShopGetplantimeGet({
    @Query('num') required String? num,
  });

  /// Get Shop
  @GET('/v1/user/shop/')
  Future<void> getShopV1UserShopGet({
    @Query('page') int? page = 1,
    @Query('size') int? size = 15,
    @Query('format') WebSubFastapiRoutersVUserTicketViewFormalEnum? format,
  });

  /// Get Detect
  @GET('/v1/user/detect/')
  Future<void> getDetectV1UserDetectGet();

  /// Get Log
  @GET('/v1/user/detect/log')
  Future<void> getLogV1UserDetectLogGet();

  /// Ticket
  @GET('/v1/user/ticket/')
  Future<void> ticketV1UserTicketGet({
    @Query('page') int? page = 1,
    @Query('size') int? size = 15,
    @Query('format') WebSubFastapiRoutersVUserTicketViewFormalEnum? format,
  });

  /// Post Ticket.
  ///
  /// 创建工单.
  @POST('/v1/user/ticket/')
  Future<void> postTicketV1UserTicketPost();

  /// Put Ticket
  @PUT('/v1/user/ticket/{ticket_id}')
  Future<void> putTicketV1UserTicketTicketIdPut({
    @Path('ticket_id') required int? ticketId,
  });

  /// Get Create
  @GET('/v1/user/ticket/create')
  Future<void> getCreateV1UserTicketCreateGet();

  /// Get Detect
  @GET('/v1/user/ticket/{ticket_id}/view')
  Future<void> getDetectV1UserTicketTicketIdViewGet({
    @Path('ticket_id') required int ticketId,
    @Query('page') int? page = 1,
    @Query('size') int? size = 5,
    @Query('format') WebSubFastapiRoutersVUserTicketViewFormalEnum? format,
  });

  /// Post Buy Pre.
  ///
  /// 预先购买套餐.
  @POST('/v1/user/buy_pre')
  Future<dynamic> postBuyPreV1UserBuyPrePost();

  /// Post Buy Pre.
  ///
  /// 预先购买套餐.
  @POST('/v1/user/buy')
  Future<dynamic> postBuyPreV1UserBuyPost();

  /// Sspwd
  @POST('/v1/user/sspwd')
  Future<void> sspwdV1UserSspwdPost();

  /// Url Reset
  @GET('/v1/user/url_reset')
  Future<void> urlResetV1UserUrlResetGet();

  /// Post Buy Invite
  @POST('/v1/user/buy_invite')
  Future<void> postBuyInviteV1UserBuyInvitePost();

  /// Password
  @POST('/v1/user/password')
  Future<void> passwordV1UserPasswordPost();

  /// Bought
  @GET('/v1/user/bought')
  Future<void> boughtV1UserBoughtGet({
    @Query('format')
    WebSubFastapiRoutersVUserTicketViewFormalEnum? format =
        WebSubFastapiRoutersVUserTicketViewFormalEnum.valueJson,
    @Query('page') int? page = 1,
    @Query('size') int? size = 15,
  });

  /// Delete Bought
  @FormUrlEncoded()
  @DELETE('/v1/user/bought')
  Future<void> deleteBoughtV1UserBoughtDelete({
    @Body() required FastapiCompatVBodyDeleteBoughtVUserBoughtDelete body,
  });

  /// Checkin
  @GET('/v1/user/checkin')
  Future<void> checkinV1UserCheckinGet();

  /// Checkin
  @POST('/v1/user/checkin')
  Future<void> checkinV1UserCheckinPost();

  /// Post Purchase.
  ///
  /// 官网充值.
  @POST('/v1/user/payment/purchase')
  Future<void> postPurchaseV1UserPaymentPurchasePost();

  /// Post Reset
  @POST('/v1/password/reset')
  Future<void> postResetV1PasswordResetPost();

  /// Post Reset
  @POST('/v1/password/token/{token}')
  Future<void> postResetV1PasswordTokenTokenPost({
    @Path('token') required String token,
  });

  /// Get Shop
  @GET('/v1/app/config')
  Future<void> getShopV1AppConfigGet();

  /// Get Userinfo
  @GET('/v1/link/{token}')
  Future<void> getUserinfoV1LinkTokenGet({
    @Path('token') required String token,
    @Query('surge') bool? surge = false,
    @Query('quantumult') bool? quantumult = false,
    @Query('quantumultx') bool? quantumultx = false,
    @Query('ssd') bool? ssd = false,
    @Query('clash') bool? clash = false,
    @Query('is_remark_emoji') bool? isRemarkEmoji = true,
    @Query('extend') bool? extend = false,
    @Query('list') SubscribeTypeEnum? list,
    @Query('sub') int? sub,
    @Query('mu') int? mu,
  });

  /// Get Link2.
  ///
  /// 获取订阅链接内容.
  @GET('/v1/link2/{token}')
  Future<void> getLink2V1Link2TokenGet({
    @Path('token') required String token,
    @Query('is_node_extend') bool? isNodeExtend,
    @Query('manual_link_group') int? manualLinkGroup,
    @Query('client_type')
    SubLinkClientTypeEnum? clientType = SubLinkClientTypeEnum.auto,
    @Query('is_remark_emoji') bool? isRemarkEmoji = true,
    @Query('is_proxy_mode') bool? isProxyMode = false,
    @Query('filename') String? filename = 'V2RayN',
    @Query('suffix_type') SuffixTypeEnum? suffixType = SuffixTypeEnum.txt,
    @Query('vpn_type') VpnTypeListEnum? vpnType = VpnTypeListEnum.vmess,
  });

  /// Authorization
  @GET('/v1/authorization')
  Future<void> authorizationV1AuthorizationGet({
    @Query('email') required String email,
    @Query('passwd') required String passwd,
  });

  /// Get Detect
  @GET('/v1/notice')
  Future<void> getDetectV1NoticeGet();

  /// Read Nodes
  @GET('/api/v2/admin_api/db/ss_node/')
  Future<List<SsNodeOutput>> readNodesApiV2AdminApiDbSsNodeGet({
    @Query('order') required String order,
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 10000,
  });

  /// Get New User
  @GET('/api/v2/admin_api/db/new_user/')
  Future<void> getNewUserApiV2AdminApiDbNewUserGet({
    @Query('order') required String order,
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 10000,
  });

  /// Recharge It.
  ///
  /// 管理员为用户充值IT币接口.
  @POST('/api/v2/admin_api/usr/{user_id}/recharge_it')
  Future<ErrorResponse> rechargeItApiV2AdminApiUsrUserIdRechargeItPost({
    @Path('user_id') required int userId,
    @Query('money_amount') required dynamic moneyAmount,
    @Query('remark') String? remark = '',
  });

  /// Get Announcement.
  ///
  /// 获取系统公告接口.
  @GET('/api/v2/admin_api/announcement')
  Future<AnnouncementResponse> getAnnouncementApiV2AdminApiAnnouncementGet({
    @Query('ann_type') required AnnouncementEnum annType,
  });

  /// Update Announcement.
  ///
  /// 更新系统公告接口.
  @POST('/api/v2/admin_api/announcement')
  Future<AnnouncementUpdateResponse>
  updateAnnouncementApiV2AdminApiAnnouncementPost({
    @Query('ann_type') required AnnouncementEnum annType,
    @Body() String? body = '',
  });

  /// Get Announcement Html.
  ///
  /// 获取HTML格式公告接口.
  @GET('/api/v2/admin_api/announcement_html')
  Future<void> getAnnouncementHtmlApiV2AdminApiAnnouncementHtmlGet({
    @Query('ann_type') required AnnouncementEnum annType,
  });

  /// Get Announcement Markdown.
  ///
  /// 获取Markdown格式公告接口.
  @GET('/api/v2/admin_api/announcement_markdown')
  Future<String> getAnnouncementMarkdownApiV2AdminApiAnnouncementMarkdownGet({
    @Query('ann_type') required AnnouncementEnum annType,
  });

  /// Replace User Email.
  ///
  /// 管理员替换用户邮箱接口.
  @GET('/api/v2/admin_api/replace_user_email')
  Future<ReplaceEmailResponse>
  replaceUserEmailApiV2AdminApiReplaceUserEmailGet({
    @Query('user_id') required int userId,
    @Query('user_old_email') required String userOldEmail,
    @Query('user_new_email') required String userNewEmail,
  });

  /// Post Index
  @POST('/api/v2/auth/account_register/')
  Future<AuthRegisterResponse> postIndexApiV2AuthAccountRegisterPost({
    @Body() required AccountRegisterParamsModel body,
  });

  /// Post Request Email Code
  @POST('/api/v2/auth/account_register/request-email-code')
  Future<ErrorResponse>
  postRequestEmailCodeApiV2AuthAccountRegisterRequestEmailCodePost({
    @Body() required RequestEmailCodeParamsModel body,
  });

  /// Post Check Invite Code
  @POST('/api/v2/auth/account_register/check-invite-code')
  Future<ErrorResponse>
  postCheckInviteCodeApiV2AuthAccountRegisterCheckInviteCodePost({
    @Body() required CheckInviteCodeParamsModel body,
  });

  /// Post Index
  @POST('/api/v2/auth/account_reset_password/')
  Future<ErrorResponse> postIndexApiV2AuthAccountResetPasswordPost({
    @Body() required AccountResetPasswordParamsModel body,
  });

  /// Post Request Email Code
  @POST('/api/v2/auth/account_reset_password/request-email-code')
  Future<ErrorResponse>
  postRequestEmailCodeApiV2AuthAccountResetPasswordRequestEmailCodePost({
    @Body() required RequestEmailCodeParamsModel body,
  });

  /// Login Post
  @POST('/api/v2/auth/account_login/login')
  Future<LoginPostResultModel> loginPostApiV2AuthAccountLoginLoginPost({
    @Body()
    required WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel body,
  });

  /// Post Jwt Access Refresh
  @POST('/api/v2/auth/jwt_token/jwt_access_refresh')
  Future<RefreshPostResultModel>
  postJwtAccessRefreshApiV2AuthJwtTokenJwtAccessRefreshPost({
    @Body()
    required WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModel body,
  });

  /// Post Login Old V1
  @POST('/api/v2/auth/jwt_token/login_old_v1')
  Future<PostLoginOldVResultModel>
  postLoginOldV1ApiV2AuthJwtTokenLoginOldV1Post({
    @Body()
    required WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel body,
  });

  /// Get User Link Group
  @GET('/api/v2/cron_task/user_link_group')
  Future<void> getUserLinkGroupApiV2CronTaskUserLinkGroupGet({
    @Query('is_auto_trigger') bool? isAutoTrigger = false,
    @Query('is_all_flush') bool? isAllFlush = false,
  });

  /// Get Announcements.
  ///
  /// 获取系统公告信息.
  @GET('/api/v2/user/system/announcements')
  Future<AnnouncementsGetResultModel>
  getAnnouncementsApiV2UserSystemAnnouncementsGet({
    @Query('ann_type') AnnouncementEnum? annType = AnnouncementEnum.indexAnn,
  });

  /// 获取用户工单列表.
  ///
  /// 获取用户工单列表接口.
  ///
  /// [page] - 页码.
  ///
  /// [size] - 每页数量.
  @GET('/api/v2/user/tickets-v2/')
  Future<TicketVGetResultModel> getIndexApiV2UserTicketsV2Get({
    @Query('page') int? page = 1,
    @Query('size') int? size = 10,
  });

  /// 创建新工单.
  ///
  /// 创建新工单.
  @POST('/api/v2/user/tickets-v2/')
  Future<ErrorResponse> postIndexApiV2UserTicketsV2Post({
    @Body() required TicketVPostParamsModel body,
  });

  /// User Tickets Ticket Id Edit Status
  @PUT('/api/v2/user/tickets-v2/{ticket_id}/edit-status')
  Future<UserTicketsTicketIdEditStatusResponse>
  userTicketsTicketIdEditStatusApiV2UserTicketsV2TicketIdEditStatusPut({
    @Path('ticket_id') required int ticketId,
  });

  /// User Tickets Ticket Id Messages Get
  @GET('/api/v2/user/tickets-v2/{ticket_id}/messages')
  Future<UserTicketsTicketIdMessagesGetResponse>
  userTicketsTicketIdMessagesGetApiV2UserTicketsV2TicketIdMessagesGet({
    @Path('ticket_id') required int ticketId,
  });

  /// Ticket Id Send Messages
  @POST('/api/v2/user/tickets-v2/{ticket_id}/send_messages')
  Future<UserTicketsTicketIdMessagesPostResponse>
  ticketIdSendMessagesApiV2UserTicketsV2TicketIdSendMessagesPost({
    @Path('ticket_id') required int ticketId,
  });

  /// User Account Activity.
  ///
  /// 获取用户账户活动记录接口.
  @GET('/api/v2/user/account/activity')
  Future<UserAccountActivityResponse>
  userAccountActivityApiV2UserAccountActivityGet();

  /// User Account Edit Email
  @POST('/api/v2/user/account/edit-email')
  Future<UserAccountEditEmailResponse>
  userAccountEditEmailApiV2UserAccountEditEmailPost();

  /// User Account Edit Password
  @POST('/api/v2/user/account/edit-password')
  Future<UserAccountEditPasswordResponse>
  userAccountEditPasswordApiV2UserAccountEditPasswordPost();

  /// User Account Edit Profile
  @POST('/api/v2/user/account/edit-profile')
  Future<UserAccountEditProfileResponse>
  userAccountEditProfileApiV2UserAccountEditProfilePost();

  /// User Account Link Telegram
  @GET('/api/v2/user/account/link/telegram')
  Future<UserAccountLinkTelegramResponse>
  userAccountLinkTelegramApiV2UserAccountLinkTelegramGet();

  /// User Account Login Ip Log.
  ///
  /// 获取用户登录IP日志.
  @GET('/api/v2/user/account/login-ip-log')
  Future<UserAccountLoginIpLogResponse>
  userAccountLoginIpLogApiV2UserAccountLoginIpLogGet();

  /// User Account Me.
  ///
  /// 获取用户账户详细信息接口.
  @GET('/api/v2/user/account/me')
  Future<UserAccountMeResponse> userAccountMeApiV2UserAccountMeGet();

  /// User Account Security Get.
  ///
  /// 获取用户安全设置信息.
  @GET('/api/v2/user/account/security')
  Future<UserAccountSecurityGetResponse>
  userAccountSecurityGetApiV2UserAccountSecurityGet();

  /// User Account Security Post.
  ///
  /// 更新用户安全设置.
  @POST('/api/v2/user/account/security')
  Future<UserAccountSecurityPostResponse>
  userAccountSecurityPostApiV2UserAccountSecurityPost({
    @Body() required UserAccountSecurityPostRequest body,
  });

  /// User Account Change Password.
  ///
  /// 修改用户密码.
  @POST('/api/v2/user/account/change-password')
  Future<UserAccountPasswordChangeResponse>
  userAccountChangePasswordApiV2UserAccountChangePasswordPost({
    @Body() required UserAccountPasswordChangeRequest body,
  });

  /// User Account Login History.
  ///
  /// 获取用户登录历史.
  @GET('/api/v2/user/account/login-history')
  Future<UserAccountLoginHistoryResponse>
  userAccountLoginHistoryApiV2UserAccountLoginHistoryGet();

  /// User Invite.
  ///
  /// 获取用户邀请信息接口.
  @GET('/api/v2/user/invite/')
  Future<UserInviteResponse> userInviteApiV2UserInviteGet();

  /// User Invite Record
  @GET('/api/v2/user/invite/record/')
  Future<UserInviteRecordResponse> userInviteRecordApiV2UserInviteRecordGet();

  /// User Services Ss Password
  @GET('/api/v2/user/services/ss-password/')
  Future<UserServicesSsPasswordResponse>
  userServicesSsPasswordApiV2UserServicesSsPasswordGet();

  /// User Services Ss Password Reset
  @POST('/api/v2/user/services/ss-password/reset')
  Future<UserServicesSsPasswordResetResponse>
  userServicesSsPasswordResetApiV2UserServicesSsPasswordResetPost();

  /// User Services Subscribe Log Area Time Axis.
  ///
  /// 获取用户订阅日志区域时间轴数据.
  @GET('/api/v2/user/services/subscribe-log/area-time-axis')
  Future<UserServicesSubscribeLogAreaTimeAxisResponse>
  userServicesSubscribeLogAreaTimeAxisApiV2UserServicesSubscribeLogAreaTimeAxisGet();

  /// User Services Subscribe Log Calendar Pie.
  ///
  /// 获取用户订阅日志日历数据.
  ///
  /// [yearMonth] - 年月格式：YYYY-MM.
  @GET('/api/v2/user/services/subscribe-log/calendar-pie')
  Future<UserServicesSubscribeLogCalendarPieResponse>
  userServicesSubscribeLogCalendarPieApiV2UserServicesSubscribeLogCalendarPieGet({
    @Query('year_month') String? yearMonth,
  });

  /// User Services Subscribe Log Detail Record.
  ///
  /// 获取用户订阅日志详细记录数据.
  ///
  /// [limit] - 数据条数限制.
  ///
  /// [offset] - 数据偏移量.
  @GET('/api/v2/user/services/subscribe-log/detail-record')
  Future<UserServicesSubscribeLogDetailRecordResponse>
  userServicesSubscribeLogDetailRecordApiV2UserServicesSubscribeLogDetailRecordGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit,
  });

  /// User Services Audit Record
  @GET('/api/v2/user/services/audit/record')
  Future<UserServicesAuditRecordResponse>
  userServicesAuditRecordApiV2UserServicesAuditRecordGet();

  /// User Services Audit Rule
  @GET('/api/v2/user/services/audit/rule')
  Future<UserServicesAuditRuleResponse>
  userServicesAuditRuleApiV2UserServicesAuditRuleGet();

  /// User Services Link Token
  @GET('/api/v2/user/services/link-token/link-token/')
  Future<UserServicesLinkTokenResponse>
  userServicesLinkTokenApiV2UserServicesLinkTokenLinkTokenGet();

  /// User Services Link Token Reset
  @POST('/api/v2/user/services/link-token/link-token/reset')
  Future<UserServicesLinkTokenResetResponse>
  userServicesLinkTokenResetApiV2UserServicesLinkTokenLinkTokenResetPost();

  /// User Services Nodes.
  ///
  /// 获取用户可用节点列表接口.
  @GET('/api/v2/user/services/nodes/')
  Future<UserServicesNodesResponse>
  userServicesNodesApiV2UserServicesNodesGet();

  /// User Services Nodes Node Id
  @GET('/api/v2/user/services/nodes/{node_id}/')
  Future<UserServicesNodesNodeIdResponse>
  userServicesNodesNodeIdApiV2UserServicesNodesNodeIdGet({
    @Path('node_id') required int nodeId,
  });

  /// User Services Nodes Node Id
  @GET('/api/v2/user/services/{node_id}/')
  Future<UserServicesNodesNodeIdResponse>
  userServicesNodesNodeIdApiV2UserServicesNodeIdGet({
    @Path('node_id') required int nodeId,
  });

  /// User Services Share Account.
  ///
  /// 获取用户共享账户信息接口.
  @GET('/api/v2/user/services/share-account/')
  Future<UserServicesShareAccountResponse>
  userServicesShareAccountApiV2UserServicesShareAccountGet();

  /// User Services Old Bill
  @GET('/api/v2/user/services-old/bill/')
  Future<UserServicesOldBillResponse>
  userServicesOldBillApiV2UserServicesOldBillGet();

  /// User Services Old Bill Service Id
  @GET('/api/v2/user/services-old/bill/{service_id}/')
  Future<UserServicesOldBillServiceIdResponse>
  userServicesOldBillServiceIdApiV2UserServicesOldBillServiceIdGet({
    @Path('service_id') required int serviceId,
  });

  /// User Services Old Bill Service Id Enable Auto Renewal
  @GET('/api/v2/user/services-old/bill/{service_id}/enable-auto-renewal')
  Future<UserServicesOldBillServiceIdEnableAutoRenewalResponse>
  userServicesOldBillServiceIdEnableAutoRenewalApiV2UserServicesOldBillServiceIdEnableAutoRenewalGet({
    @Path('service_id') required int serviceId,
  });

  /// User Services Old Checkin Get.
  ///
  /// 获取签到历史列表.
  @GET('/api/v2/user/services-old/checkin/')
  Future<UserServicesOldCheckinGetResponse>
  userServicesOldCheckinGetApiV2UserServicesOldCheckinGet();

  /// User Services Old Checkin Post.
  ///
  /// 立即签到.
  @POST('/api/v2/user/services-old/checkin/')
  Future<UserServicesOldCheckinPostResponse>
  userServicesOldCheckinPostApiV2UserServicesOldCheckinPost();

  /// User Services Old.
  ///
  /// 获取用户旧版服务列表接口.
  @GET('/api/v2/user/services-old/')
  Future<UserServicesOldResponse> userServicesOldApiV2UserServicesOldGet();

  /// User Shop Old.
  ///
  /// 获取旧版商店商品列表接口.
  @GET('/api/v2/user/shop-old/')
  Future<UserShopOldResult> userShopOldApiV2UserShopOldGet();

  /// User Shop Old Shop Id Confirm Order
  @POST('/api/v2/user/shop-old/{shop_id}/confirm-order')
  Future<UserShopOldShopIdConfirmOrderResponse>
  userShopOldShopIdConfirmOrderApiV2UserShopOldShopIdConfirmOrderPost({
    @Path('shop_id') required int shopId,
  });

  /// User Shop Old Shop Id Pre Order
  @POST('/api/v2/user/shop-old/{shop_id}/pre-order')
  Future<UserShopOldShopIdPreOrderResponse>
  userShopOldShopIdPreOrderApiV2UserShopOldShopIdPreOrderPost({
    @Path('shop_id') required int shopId,
  });

  /// Get Shop Id Info
  @GET('/api/v2/user/shop-old/{shop_id}/info')
  Future<UserShopOldShopIdConfirmOrderResult>
  getShopIdInfoApiV2UserShopOldShopIdInfoGet({
    @Path('shop_id') required int shopId,
  });

  /// User Wallet Recharge.
  ///
  /// [limit] - 数据条数限制.
  ///
  /// [offset] - 数据偏移量.
  @GET('/api/v2/user/wallet/recharge/')
  Future<UserWalletRechargeResult>
  userWalletRechargeApiV2UserWalletRechargeGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit,
  });

  /// User Wallet Recharge Recharge Id
  @POST('/api/v2/user/wallet/recharge/{recharge_id}/')
  Future<UserWalletRechargeRechargeIdResponse>
  userWalletRechargeRechargeIdApiV2UserWalletRechargeRechargeIdPost({
    @Path('recharge_id') required int rechargeId,
  });

  /// User Wallet Cd Key
  @GET('/api/v2/user/wallet/cd-key/cd-key/')
  Future<UserWalletCdKeyResponse> userWalletCdKeyApiV2UserWalletCdKeyCdKeyGet();

  /// User Wallet Cd Key Cd Key
  @POST('/api/v2/user/wallet/cd-key/{cd_key}/')
  Future<UserWalletCdKeyCdKeyResponse>
  userWalletCdKeyCdKeyApiV2UserWalletCdKeyCdKeyPost({
    @Path('cd_key') required String cdKey,
  });

  /// User Wallet.
  ///
  /// 获取用户钱包信息接口.
  @GET('/api/v2/user/wallet/')
  Future<UserWalletResult> userWalletApiV2UserWalletGet();

  /// Get User Purchase Records.
  ///
  /// 获取用户购买记录.
  @GET('/api/v2/user/wallet/purchase-records')
  Future<PurchaseRecordsResult>
  getUserPurchaseRecordsApiV2UserWalletPurchaseRecordsGet();

  /// Get Index.
  ///
  /// 获取用户仪表板信息.
  @GET('/api/v2/user/dashboard/')
  Future<GetDashboardResultModel> getIndexApiV2UserDashboardGet();

  /// Get Index.
  ///
  /// 获取用户基础令牌信息接口.
  @GET('/api/v2/user/')
  Future<IndexGetResultModel> getIndexApiV2UserGet();

  /// Get Get Me.
  ///
  /// 获取当前用户账户信息接口.
  @GET('/api/v2/user/get_me')
  Future<GetMeGetResultModel> getGetMeApiV2UserGetMeGet();

  /// Get Old Service.
  ///
  /// 获取用户旧版服务信息接口.
  @GET('/api/v2/user/get_old_service')
  Future<GetOldServiceResultModel> getOldServiceApiV2UserGetOldServiceGet();

  /// Get Crisp Data.
  ///
  /// 获取当前用户账户信息接口，返回crisp格式数据.
  @GET('/api/v2/user/crisp_data')
  Future<CrispDataResultModel> getCrispDataApiV2UserCrispDataGet();

  /// Post Node Config
  @POST('/api/v2/tools/pydantic_check/ss_node/node_config')
  Future<void> postNodeConfigApiV2ToolsPydanticCheckSsNodeNodeConfigPost({
    @Body() required NodeConfig body,
  });

  /// Get Search User
  @GET('/api/v2/grafana_admin_view/search_user')
  Future<GetSearchUserResult> getSearchUserApiV2GrafanaAdminViewSearchUserGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get Service Old Shop
  @GET('/api/v2/grafana_admin_view/service_old_shop')
  Future<GetServiceOldShopResult>
  getServiceOldShopApiV2GrafanaAdminViewServiceOldShopGet({
    @Query('q') String? q,
  });

  /// Get View User
  @GET('/api/v2/grafana_admin_view/view_user')
  Future<GetViewUserResult> getViewUserApiV2GrafanaAdminViewViewUserGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get View User Bought
  @GET('/api/v2/grafana_admin_view/view_user_bought')
  Future<GetViewUserBoughtResult>
  getViewUserBoughtApiV2GrafanaAdminViewViewUserBoughtGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get User Data History Ch
  @GET('/api/v2/grafana_admin_view/user_data_history_ch')
  Future<UserDataHistoryResponse>
  getUserDataHistoryChApiV2GrafanaAdminViewUserDataHistoryChGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get User Traffic Log Full Ch
  @GET('/api/v2/grafana_view/user_traffic_log_full_ch')
  Future<void> getUserTrafficLogFullChApiV2GrafanaViewUserTrafficLogFullChGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get User Traffic Log User Traffic
  @GET('/api/v2/grafana_view/user_traffic_log_user_traffic')
  Future<void>
  getUserTrafficLogUserTrafficApiV2GrafanaViewUserTrafficLogUserTrafficGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Put User Old Service.
  ///
  /// 更新用户信息 - 需要提供所有必填字段（完全替换）.
  @PUT('/api/v2/low_admin_api/user_old_service/{user_id}')
  Future<ErrorResponse>
  putUserOldServiceApiV2LowAdminApiUserOldServiceUserIdPut({
    @Path('user_id') required int userId,
    @Body() required AdminOldServiceInput body,
  });

  /// Get User Old Service
  @GET('/api/v2/low_admin_api/user_old_service/{user_id}')
  Future<
    WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
  >
  getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet({
    @Path('user_id') required int userId,
  });

  /// Put User V2.
  ///
  /// 更新用户信息 - 需要提供所有必填字段（完全替换）.
  @PUT('/api/v2/low_admin_api/user_v2/{user_id}')
  Future<ErrorResponse> putUserV2ApiV2LowAdminApiUserV2UserIdPut({
    @Path('user_id') required int userId,
    @Body() required AdminUserV body,
  });

  /// Get User V2 By User Id
  @GET('/api/v2/low_admin_api/user_v2/{user_id}')
  Future<WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse>
  getUserV2ByUserIdApiV2LowAdminApiUserV2UserIdGet({
    @Path('user_id') required int userId,
  });

  /// Get User V2
  @GET('/api/v2/low_admin_api/user_v2/')
  Future<GetSearchUserResult> getUserV2ApiV2LowAdminApiUserV2Get({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get User Bought.
  ///
  /// 查询用户购买记录，可按用户ID过滤，或按ID模糊搜索.
  @GET('/api/v2/low_admin_api/user_bought/')
  Future<WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse>
  getUserBoughtApiV2LowAdminApiUserBoughtGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Delete User Bought.
  ///
  /// 删除用户购买记录.
  @DELETE('/api/v2/low_admin_api/user_bought/{bought_id}')
  Future<ErrorResponse>
  deleteUserBoughtApiV2LowAdminApiUserBoughtBoughtIdDelete({
    @Path('bought_id') required int boughtId,
  });

  /// Put User Bought.
  ///
  /// 更新用户购买记录 - 需要提供所有必填字段（完全替换）.
  @PUT('/api/v2/low_admin_api/user_bought/{bought_id}')
  Future<ErrorResponse> putUserBoughtApiV2LowAdminApiUserBoughtBoughtIdPut({
    @Path('bought_id') required String boughtId,
    @Body()
    required WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel body,
  });

  /// Get User V2 By User Id
  @GET('/api/v2/low_admin_api/user_money/{user_id}')
  Future<GetUserMoneyResponse>
  getUserV2ByUserIdApiV2LowAdminApiUserMoneyUserIdGet({
    @Path('user_id') required int userId,
  });

  /// Post User Money Money Recharge It
  @POST('/api/v2/low_admin_api/user_money_money_recharge_it/{user_id}/')
  Future<ErrorResponse>
  postUserMoneyMoneyRechargeItApiV2LowAdminApiUserMoneyMoneyRechargeItUserIdPost({
    @Path('user_id') required int userId,
    @Body()
    required WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel
    body,
  });

  /// Get User Pay List.
  ///
  /// 更新用户信息 - 需要提供所有必填字段（完全替换）.
  @GET('/api/v2/low_admin_api/user_pay_list/')
  Future<WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse>
  getUserPayListApiV2LowAdminApiUserPayListGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Delete User Pay List.
  ///
  /// 删除充值记录.
  @DELETE('/api/v2/low_admin_api/user_pay_list/{user_pay_list_id}')
  Future<ErrorResponse>
  deleteUserPayListApiV2LowAdminApiUserPayListUserPayListIdDelete({
    @Path('user_pay_list_id') required String userPayListId,
  });

  /// Put User Pay List.
  ///
  /// 更新用户购买记录.
  @PUT('/api/v2/low_admin_api/user_pay_list/{user_pay_list_id}')
  Future<ErrorResponse>
  putUserPayListApiV2LowAdminApiUserPayListUserPayListIdPut({
    @Path('user_pay_list_id') required String userPayListId,
    @Body()
    required WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModel body,
  });

  /// Admin Notify
  @POST(
    '/api/v2/low_admin_api/user_pay_list/{user_pay_list_id}/is_finish_notify',
  )
  Future<ErrorResponse>
  adminNotifyApiV2LowAdminApiUserPayListUserPayListIdIsFinishNotifyPost({
    @Path('user_pay_list_id') required String userPayListId,
  });

  /// Put Old Service Shop.
  ///
  /// 更新用户信息 - 需要提供所有必填字段（完全替换）.
  @PUT('/api/v2/low_admin_api/old_service_shop/{shop_id}')
  Future<ErrorResponse>
  putOldServiceShopApiV2LowAdminApiOldServiceShopShopIdPut({
    @Path('shop_id') required int shopId,
    @Body() required OldServiceShopInput body,
  });

  /// Get Old Service Shop By Shop Id
  @GET('/api/v2/low_admin_api/old_service_shop/{shop_id}')
  Future<GetOldServiceShopResponse>
  getOldServiceShopByShopIdApiV2LowAdminApiOldServiceShopShopIdGet({
    @Path('shop_id') required int shopId,
  });

  /// Put Ss Node.
  ///
  /// 更新节点信息 - 需要提供所有必填字段（完全替换）.
  @PUT('/api/v2/low_admin_api/ss_node/{node_id}')
  Future<ErrorResponse> putSsNodeApiV2LowAdminApiSsNodeNodeIdPut({
    @Path('node_id') required int nodeId,
    @Body() required SsNodeInput body,
  });

  /// Delete Ss Node.
  ///
  /// 删除节点.
  @DELETE('/api/v2/low_admin_api/ss_node/{node_id}')
  Future<ErrorResponse> deleteSsNodeApiV2LowAdminApiSsNodeNodeIdDelete({
    @Path('node_id') required int nodeId,
  });

  /// Get Ss Node By Id.
  ///
  /// 根据ID获取节点信息.
  @GET('/api/v2/low_admin_api/ss_node/{node_id}')
  Future<GetSsNodeResponse> getSsNodeByIdApiV2LowAdminApiSsNodeNodeIdGet({
    @Path('node_id') required int nodeId,
  });

  /// Post Ss Node.
  ///
  /// 创建新节点.
  @POST('/api/v2/low_admin_api/ss_node/')
  Future<ErrorResponse> postSsNodeApiV2LowAdminApiSsNodePost({
    @Body() required SsNodeInput body,
  });

  /// Get Ss Node List.
  ///
  /// 获取节点列表，支持搜索和分页.
  ///
  /// 支持的查询参数:.
  /// - q: 模糊搜索（节点名称、备注、ID）.
  /// - q_command: 精确查询命令，如 {"id": "123", "node_level": "1", "vpn_type": "vmess"}.
  /// - limit: 每页数量.
  /// - offset: 偏移量.
  @GET('/api/v2/low_admin_api/ss_node/')
  Future<GetSsNodeListResponse> getSsNodeListApiV2LowAdminApiSsNodeGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get Batch Usernames.
  ///
  /// 批量获取用户名.
  ///
  /// 根据提供的用户ID列表，返回对应的用户名。.
  /// 如果用户不存在或已删除，则返回 [已销号].
  @POST('/api/v2/low_admin_api/user_v2/batch_usernames')
  Future<GetUsernamesResponse>
  getBatchUsernamesApiV2LowAdminApiUserV2BatchUsernamesPost({
    @Body() required GetUsernamesRequest body,
  });

  /// Get Batch User Infos.
  ///
  /// 批量获取用户信息（用户名和邮箱）.
  ///
  /// 根据提供的用户ID列表，返回对应的用户名和邮箱。.
  /// 如果用户不存在或已删除，则返回用户名为 [已销号]，邮箱为空字符串.
  @POST('/api/v2/low_admin_api/user_v2/batch_user_infos')
  Future<GetUserInfosResponse>
  getBatchUserInfosApiV2LowAdminApiUserV2BatchUserInfosPost({
    @Body() required GetUsernamesRequest body,
  });

  /// Get Old Service Shop
  @GET('/api/v2/low_admin_api/old_service_shop/')
  Future<GetOldServiceShopListResponse>
  getOldServiceShopApiV2LowAdminApiOldServiceShopGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get Ticket.
  ///
  /// 管理端：工单列表（支持 GrafanaParamsModel 的通用筛选）.
  /// 搜索支持 q 中的命令参数：id:, user_id:, status: 以及模糊搜索.
  /// 返回 DB2M.T2.UserTicketView 列表（已封装为 Pydantic model）.
  @GET('/api/v2/low_admin_api/ticket/')
  Future<GetTicketListResponse> getTicketApiV2LowAdminApiTicketGet({
    @Query('offset') int? offset = 0,
    @Query('limit') int? limit = 3000,
    @Query('q') String? q,
    @Query('from_iso') DateTime? fromIso,
    @Query('to_iso') DateTime? toIso,
  });

  /// Get Ticket Detail
  @GET('/api/v2/low_admin_api/ticket/{ticket_id}')
  Future<GetTicketDetailResponse>
  getTicketDetailApiV2LowAdminApiTicketTicketIdGet({
    @Path('ticket_id') required int ticketId,
  });

  /// Post Ticket Reply.
  ///
  /// 管理端回复工单：插入一条 UserTicketMessage，并可选择更新工单状态.
  /// 注意：此接口未进行管理员鉴权，调用方需保证权限（低权限 API 目录约定）.
  @POST('/api/v2/low_admin_api/ticket/{ticket_id}/reply')
  Future<ErrorResponse> postTicketReplyApiV2LowAdminApiTicketTicketIdReplyPost({
    @Path('ticket_id') required int ticketId,
    @Body() required ReplyParams body,
  });

  /// Get Captcha Key.
  ///
  /// 获取一次性验证码.
  @GET('/api/v2/captcha-key')
  Future<CaptchaKeyModel> getCaptchaKeyApiV2CaptchaKeyGet({
    @Query('captcha_key_type') required CaptchaKeyTypeEnum captchaKeyType,
  });

  /// Get Csrf Token
  @GET('/api/v2/csrf')
  Future<GetCsrfTokenResult> getCsrfTokenApiV2CsrfGet();

  /// Get Version
  @GET('/api/version')
  Future<GetVersionModel> getVersionApiVersionGet();

  /// Get Userinfo
  @GET('/link/{token}')
  Future<void> getUserinfoLinkTokenGet({
    @Path('token') required String token,
    @Query('surge') bool? surge = false,
    @Query('quantumult') bool? quantumult = false,
    @Query('quantumultx') bool? quantumultx = false,
    @Query('ssd') bool? ssd = false,
    @Query('clash') bool? clash = false,
    @Query('is_remark_emoji') bool? isRemarkEmoji = true,
    @Query('extend') bool? extend = false,
    @Query('list') SubscribeTypeEnum? list,
    @Query('sub') int? sub,
    @Query('mu') int? mu,
  });

  /// Get Link2.
  ///
  /// 获取订阅链接内容.
  @GET('/link2/{token}')
  Future<void> getLink2Link2TokenGet({
    @Path('token') required String token,
    @Query('is_node_extend') bool? isNodeExtend,
    @Query('manual_link_group') int? manualLinkGroup,
    @Query('client_type')
    SubLinkClientTypeEnum? clientType = SubLinkClientTypeEnum.auto,
    @Query('is_remark_emoji') bool? isRemarkEmoji = true,
    @Query('is_proxy_mode') bool? isProxyMode = false,
    @Query('filename') String? filename = 'V2RayN',
    @Query('suffix_type') SuffixTypeEnum? suffixType = SuffixTypeEnum.txt,
    @Query('vpn_type') VpnTypeListEnum? vpnType = VpnTypeListEnum.vmess,
  });
}
