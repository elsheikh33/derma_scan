class UserDetails {
  late final String? uid;
  late final String? name;
  late final String? email;
  late final String? password;
  late final String? gender;
  late final String? birthdate;
  final String? profilePicture;
  final List<String>? history; // Example: List of scanned skin conditions

  UserDetails({
    this.uid,
    required this.name,
    required this.email,
    this.password,
    this.gender,
    this.birthdate,
    this.profilePicture,
    this.history,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password' : password,
      'gender': gender,
      'birthdate': birthdate,
      'profilePicture': profilePicture ?? "",
      'history': history ?? [],
    };
  }
  Map<String,dynamic> tojson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['Uid'] = this.uid;
    data['username'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['BD'] = this.birthdate;
    data['profilePicture'] = this.profilePicture;
    data['history'] = this.history;

return data;

  }

}
