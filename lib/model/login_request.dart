class LoginRequest {
  String email;
  String password;
  String action = "login";

  LoginRequest({this.email, this.password});

  Map<String, dynamic> toJson() => {
    "email": this.email,
    "password": this.password,
    "action": this.action
  };


}
