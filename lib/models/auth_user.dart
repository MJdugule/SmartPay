class AuthUser {
  final String? email;
  final String? password;
  final String? fullName;
  final String? country;
  final String? id;
  final String? token;
  final String? username;


  AuthUser({
     this.email,
     this.password,
    this.fullName,
    this.id,
    this.country,
    this.token,
    this.username,
  
  });

   factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      email: json['data']["user"]['email'],
      id: json['data']["user"]['id'],
      fullName: json['data']["user"]['full_name'],
      country: json['data']["user"]['country'],
      token: json['data']['token'],
      username: json['data']["user"]['username']??"",
    );
  }
}


class UserWallet {
  final dynamic total;
  final dynamic transactions;
  final bool? status;
 
  UserWallet({
     this.total,
     this.transactions,
    this.status,
  });

   factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      total: json['result']['total'],
      transactions: json['result']['transactions'],
      status: json['result']['status'],
      
    );
  }
}
