class PostGetForgotPasswordOTPResult {
  PostGetForgotPasswordOTPResult({
    required this.result,
    required this.message,
    required this.token,
  });

  final bool result;
  final String message;
  final String token;

  factory PostGetForgotPasswordOTPResult.fromJson(Map<String, dynamic> json) =>
      PostGetForgotPasswordOTPResult(
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
