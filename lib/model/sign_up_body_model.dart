class SignUpBody
{
    String username;
    String phone;
    String account;
    String password;

    SignUpBody({
      required this.username,
      required this.phone,
      required this.account,
      required this.password,
    });

    Map<String, dynamic> toJson(){
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['name'] = this.username;
      data['phone'] = this.phone;
      data['email'] = this.account;
      data['password'] = this.password;
      return data;
    } 
}