import 'package:crypto/crypto.dart';
import 'dart:convert';

String generateHashFromNews(List<dynamic> news) {
  final bytes = utf8.encode(jsonEncode(news));
  return sha256.convert(bytes).toString();
}
