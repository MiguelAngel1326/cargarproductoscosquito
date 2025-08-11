// To parse this JSON data, do
//
//     final usuarioResponse = usuarioResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cargaproductos/feactures/cliente/infrastructure/models/user/usuariodb.dart';

UsuarioResponse usuarioResponseFromJson(String str) => UsuarioResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) => json.encode(data.toJson());

class UsuarioResponse {
    final bool ok;
    final Usuario usuario;
    final String token;

    UsuarioResponse({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    factory UsuarioResponse.fromJson(Map<String, dynamic> json) => UsuarioResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}
