class UserModel{
  int id;
  String email;
  String name;
  String phone;
  int orderCount;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.orderCount
  });
  factory UserModel.fromjson(Map <String, dynamic> json){
    return UserModel(
        id: json['id'],
        email: json['email'],
        name: json['f_name'],
        phone: json['phone'],
        orderCount: json['order_count']);

  }
}