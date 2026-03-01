import 'package:kelasqna/kelasqna.dart';

part 'token_provider_di.dart';
part 'token_provider_impl.dart';

abstract class TokenProvider {
  Future<String?> getToken();
}
