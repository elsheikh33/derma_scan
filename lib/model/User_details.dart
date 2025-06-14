class UserDetails {
  final String uid;
  final String username;
  final String email;
  final String? birthdate;
  final String gender;
  final String? skinType;
  final String? allergies;
  final List<String> diseases; // Add diseases list

  UserDetails({
    required this.uid,
    required this.username,
    required this.email,
    this.birthdate,
    required this.gender,
    this.allergies,
    this.skinType,
    this.diseases = const [], // Initialize as empty list
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'birthdate': birthdate,
      'gender': gender,
      'skinType': skinType,
      'allergies': allergies,
      'diseases': diseases, // Include diseases in the map
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      birthdate: map['birthdate']?.toString(),
      gender: map['gender'] ?? '',
      skinType: map['skinType'],
      allergies: map['allergies'],
      diseases: List<String>.from(map['diseases'] ?? []), // Convert to List<String>
    );
  }
}