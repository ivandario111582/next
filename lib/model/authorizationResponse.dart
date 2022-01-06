
import 'dart:convert';
class AuthorizationResponse {
    AuthorizationResponse({
        required this.numeroPedido,
        required this.success,
    });

    int ? numeroPedido;
    String ? success;
    
    factory AuthorizationResponse.fromJson(String str) => AuthorizationResponse.fromMap(json.decode(str));

    factory AuthorizationResponse.fromMap(Map<String, dynamic> json) => AuthorizationResponse(
        numeroPedido  : json["numeroPedido"],
        success: json["success"].toString(),
    );
}
