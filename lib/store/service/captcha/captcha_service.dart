import 'package:fl_app1/api/models/get_captcha_key_model.dart';
import 'package:fl_app1/api/models/post_captcha_key_verify_model.dart';
import 'package:fl_app1/api/models/post_captcha_key_verify_request_model.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/captcha/pow_service.dart';

/// 验证码API服务
///
/// 封装POW验证码的完整流程：获取 → 计算 → 验证
class CaptchaService {
  CaptchaService._();

  static CaptchaService? _instance;

  /// 单例实例
  static CaptchaService get instance {
    _instance ??= CaptchaService._();
    return _instance!;
  }

  /// 1. 获取验证码
  ///
  /// 返回包含cap_id、challenge_count、difficulty等信息的验证码对象
  Future<GetCaptchaKeyModel> getCaptcha({
    required RestClient restClient,
  }) async {
    return await restClient.fallback.getCaptchaKeyV2ApiV2CaptchaKeyV2Get();
  }

  /// 2. 提交验证
  ///
  /// [capId] 验证码ID
  /// [solutions] POW计算出的解决方案数组
  ///
  /// 返回包含verify_token的验证结果
  Future<PostCaptchaKeyVerifyModel> verifyCaptcha({
    required RestClient restClient,
    required String capId,
    required List<int> solutions,
  }) async {
    final PostCaptchaKeyVerifyRequestModel body =
        PostCaptchaKeyVerifyRequestModel(capId: capId, solutions: solutions);

    return await restClient.fallback
        .postCaptchaKeyV2VerifyApiV2CaptchaKeyV2VerifyPost(body: body);
  }

  /// 完整流程：获取 + 计算 + 验证
  ///
  /// [restClient] REST客户端实例
  /// [onProgress] 进度回调 (当前索引, 总数)
  ///
  /// 返回verify_token字符串
  ///
  /// 抛出异常：
  /// - 获取验证码失败
  /// - POW计算失败
  /// - 验证失败
  Future<String> getVerifyToken({
    required RestClient restClient,
    void Function(int current, int total)? onProgress,
  }) async {
    // 1. 获取验证码
    final GetCaptchaKeyModel captcha = await getCaptcha(restClient: restClient);

    if (!captcha.isSuccess) {
      throw Exception('获取验证码失败: ${captcha.message}');
    }

    final String capId = captcha.result.id ?? '';
    final int challengeCount = captcha.result.capChallengeCount;
    final int difficulty = captcha.result.capDifficulty;

    if (capId.isEmpty) {
      throw Exception('验证码ID为空');
    }

    // 2. 计算解决方案（在isolate中）
    final List<int> solutions = await POWService.computeSolutions(
      capId: capId,
      challengeCount: challengeCount,
      difficulty: difficulty,
    );

    // 3. 提交验证
    final PostCaptchaKeyVerifyModel result = await verifyCaptcha(
      restClient: restClient,
      capId: capId,
      solutions: solutions,
    );

    if (!result.isSuccess || result.result == null) {
      throw Exception('验证失败: ${result.message}');
    }

    return result.result!.verifyToken;
  }
}
