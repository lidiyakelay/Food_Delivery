class SignUpBody{
  String email;
  String password;
  String name;
  String phone;


  SignUpBody({
    required this.email,
    required this.password,
    required this.name,
    required this.phone
});
 Map<String, dynamic> toJson(){
   return{
     "f_name":this.name,
     "phone":this.phone,
     "email":this.email,
     "password":this.password,
   };
 }
}