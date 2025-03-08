class UserDetails {
  final String uid;
  final String username;
  final String email;
  final String? birthdate;
  final String gender;
  final String? skinType;
  final String? allergies;

  UserDetails({
    required this.uid,  // Make UID required
    required this.username,
    required this.email,
    this.birthdate,
    required this.gender,
    this.allergies,
    this.skinType
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
      birthdate: map['date_of_birth']?.toString(),
      gender: map['gender'],
      skinType: map['skinType'],  // Ensure these are mapped
      allergies: map['allergies'],
    );
  }

}
