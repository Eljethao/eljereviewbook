class UserModel{
  String id;
  String user;
  String password;
  UserModel({this.id,this.user,this.password});

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['User_ID'];
    user = json['user_name'];
    password = json['user_password'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.user;
    data['user_password'] = this.password;
    return data;
  }
}