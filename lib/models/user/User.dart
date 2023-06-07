class User {
  int? id;
  String username;
  String firstName;
  String lastName;
  String password;

  User({
    this.id,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.password = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };
  }
}
