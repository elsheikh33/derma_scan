class UserDetails {
  final String uid;
  final String username;
  final String email;
  final String? birthdate;
  final String gender;

  UserDetails({
    required this.uid,  // Make UID required
    required this.username,
    required this.email,
    this.birthdate,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': username,
      'email': email,
      'birthdate': birthdate,
      'gender': gender,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      birthdate: map['date_of_birth']?.toString(),  // Ensure it converts Timestamp correctly
      gender: map['gender'],
    );
  }

}
