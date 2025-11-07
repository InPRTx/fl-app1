import 'package:fl_app1/store/model/jwt_token_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

void testTokenParsing() {
  // Your actual access token from the error
  const accessToken =
      'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIwMTlhNGZiMi1mZjkxLTc3OGItYmIyOC1hZGNjYWQ1Y2E3MDEiLCJleHAiOjE3NjIyNzQ5MjIsImlhdCI6MTc2MjI3MzcyMiwicm9sZSI6Im1hbGlvX3Bvc3RncmVzdF91c2VyIiwic3ViamVjdF9hY2Nlc3MiOnsidXNlcl9pZCI6MTg0MDEsInVzZXJfbmV3X2lkIjoiMDE3YWE1ZTktZThjMC03MDAwLWEwMDEtOWU4MjhiNWZhMTg0IiwidXNlcl9uYW1lIjoi5oqA5pyvIiwiZW1haWwiOiJhZG1pbkB5eGlra2oudG9wIn0sInRva2VuX3R5cGUiOiJhY2Nlc3MifQ.UQqvCjzemQCWRhKM6Syrvfvb2Z5KbgThVCYVrmZt6bHNYcLgDpFGTPfGZpO9_djckFCg4jJpt2Qhs9biMbJCzA';

  print('Testing token parsing...');
  print('');

  try {
    // Parse JWT
    final payload = Jwt.parseJwt(accessToken);
    print('Raw payload: $payload');
    print('');

    // Try to create model
    final model = JWTTokenModel.fromJson(payload);
    print('✅ Token parsed successfully!');
    print('exp: ${model.exp}');
    print('iat: ${model.iat}');
    print('jti: ${model.jti}');
    print('role: ${model.role}');
    print('tokenType: ${model.tokenType}');
    print('');

    if (model.subjectAccess != null) {
      print('SubjectAccess:');
      print('  email: ${model.subjectAccess!.email}');
      print('  userId: ${model.subjectAccess!.userId}');
      print('  userNewId: ${model.subjectAccess!.userNewId}');
      print('  userName: ${model.subjectAccess!.userName}');
    }
  } catch (e, stack) {
    print('❌ Error parsing token: $e');
    print('Stack: $stack');
  }
}

void main() {
  testTokenParsing();
}
