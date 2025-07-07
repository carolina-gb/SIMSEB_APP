import 'package:jwt_decoder/jwt_decoder.dart';
import 'security_storage.dart';

class TokenHelper {
  static Future<Map<String, String?>> getUserInfoFromToken() async {
    String token = await SecurityStorage.getToken();
    if (token.isEmpty) return {"userId": null, "typeId": null};

    try {
      Map<String, dynamic> decoded = JwtDecoder.decode(token);
      return {
        "userId": decoded['userId']?.toString(),
        "typeId": decoded['typeId']?.toString(),
      };
    } catch (e) {
      return {"userId": null, "typeId": null};
    }
  }
}
