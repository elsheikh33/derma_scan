class UserDetails {
  final String? uid;
  final String name;
  final String email;
  final String? password;
  final String? birthdate;

  UserDetails({
    this.uid,
    required this.name,
    required this.email,
    this.password,
    this.birthdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'birthdate': birthdate,
    };
  }
}
