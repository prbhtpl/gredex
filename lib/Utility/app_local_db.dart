
import 'package:get_storage/get_storage.dart';


class AppPreference {
  
  static const STORAGE_NAME = 'flutter_base_setup';
 
  static const _token = 'token';
 

  final _storage = GetStorage(STORAGE_NAME);

  Future<bool> init() {
    return _storage.initStorage;
  }


  void saveToken(String token) {
    _storage.write(_token, token);
  }

  String get token {

      return _storage.read(_token)??"";

  }



  Future<void> logout() async {
    await _storage.erase();
  }
}
