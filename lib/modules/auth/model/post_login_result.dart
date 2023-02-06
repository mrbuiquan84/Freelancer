import 'dart:convert';

PostLoginResult postLoginResultFromJson(String str) =>
    PostLoginResult.fromJson(json.decode(str));

String postLoginResultToJson(PostLoginResult data) =>
    json.encode(data.toJson());

class PostLoginResult {
  PostLoginResult({
    required this.result,
    required this.message,
    required this.token,
  });

  final bool result;
  final String message;
  final String token;

  factory PostLoginResult.fromJson(Map<String, dynamic> json) =>
      PostLoginResult(
        result: json["result"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "token": token,
      };
}
