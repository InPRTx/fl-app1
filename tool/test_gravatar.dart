import 'dart:convert';

import 'package:crypto/crypto.dart';

String? gravatarUrlForEmail(String? email, {int size = 80}) {
  if (email == null) return null;
  final trimmed = email.trim().toLowerCase();
  if (trimmed.isEmpty) return null;

  final bytes = utf8.encode(trimmed);
  final digest = md5.convert(bytes).toString();
  return 'https://www.gravatar.com/avatar/$digest?s=$size&d=identicon';
}

void main() {
  final samples = ['Example@Email.com ', '  ', null, 'user+tag@example.com'];

  for (final s in samples) {
    final url = gravatarUrlForEmail(s, size: 100);
    print('email: ${s ?? "null"} -> $url');
  }
}
