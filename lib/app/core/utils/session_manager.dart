import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SessionManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getUserId() async => await _storage.read(key: 'id');
  
  Future<String?> getToken() async => await _storage.read(key: 'token');

  Future<void> logout() async => await _storage.deleteAll();
}