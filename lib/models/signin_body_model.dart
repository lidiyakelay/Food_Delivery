class SignInBody{
  String phone;
  String password;



  SignInBody({
    required this.phone,
    required this.password,

  });
  Map<String, dynamic> toJson(){
    return{

      "phone":this.phone,
      "password":this.password,
    };
  }
}