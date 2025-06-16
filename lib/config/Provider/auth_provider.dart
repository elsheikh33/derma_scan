import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/User_details.dart';
import '../../model/detection_history.dart';
import '../../screens/Login_page.dart';
import '../../screens/Main_page.dart';
import '../../screens/Welcome_page.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _historyCollection = FirebaseFirestore.instance.collection('DetectionHistory');
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userIdKey = 'userId';
  static const String userEmailKey = 'userEmail';
  User? _user;
  UserDetails? _userDetails;

  AuthProvider() {
    _user = _auth.currentUser;
    initialize(); // Initialize auth state listener
    if (_user != null) {
      fetchUserDetails(); // Fetch details if already logged in
    }
  }

  User? get user => _user;
  UserDetails? get userDetails => _userDetails;

  Future<void> initialize() async {
    // Check shared preferences first
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;

    if (isLoggedIn) {
      // If shared preferences says we're logged in, verify with Firebase
      _auth.authStateChanges().listen((User? user) async {
        _user = user;
        if (user != null) {
          await fetchUserDetails();
        } else {
          // If Firebase says we're not logged in, clear shared preferences
          await _clearPreferences();
          _userDetails = null;
        }
        notifyListeners();
      });
    } else {
      _user = null;
      _userDetails = null;
      notifyListeners();
    }
  }

  Future<void> signup({
    required BuildContext context,
    required String email,
    required String password,
    required String userName,
    required String gender,
    required DateTime birthdate,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;

      if (_user != null) {
        await addUserDetails(_user!.uid, email, userName, birthdate, gender);
        await fetchUserDetails();
        if (_userDetails != null) {
          Navigator.pushNamed(context, LoginPage.id);
          Fluttertoast.showToast(msg: 'Account Created Successfully');
        } else {
          Fluttertoast.showToast(msg: "Error fetching user details.");
        }
      }

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message = _getErrorMessage(e.code);
      Fluttertoast.showToast(msg: message);
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred: ${e.toString()}");
    }
  }

  Future<void> addUserDetails(
      String uid, String email, String userName, DateTime BD, String gender,
      ) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(BD);

      await _firestore.collection('Users').doc(uid).set({
        'uid': uid,
        'email': email,
        'username': userName,
        'date_of_birth': formattedDate,
        'gender': gender,
        'skinType': '',
        'allergies': '',
      }, SetOptions(merge: true));

      await fetchUserDetails(); // Refresh local user details
    } catch (e) {
      Fluttertoast.showToast(msg: "Error saving user details: ${e.toString()}");
    }
  }



  Future<void> _saveLoginState(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, true);
    await prefs.setString(userIdKey, user.uid);
    await prefs.setString(userEmailKey, user.email ?? '');
  }

  Future<void> _clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLoggedInKey);
    await prefs.remove(userIdKey);
    await prefs.remove(userEmailKey);
  }

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;

      if (_user != null) {
        await _saveLoginState(_user!); // Save login state
        await fetchUserDetails();
        if (_userDetails != null) {
          if (_userDetails!.skinType!.isNotEmpty && _userDetails!.allergies!.isNotEmpty) {
            Navigator.pushNamed(context, MainPage.id);
          } else {
            Navigator.pushNamed(context, WelcomePage.id);
          }
        } else {
          Fluttertoast.showToast(msg: "Error fetching user details.");
        }
      }

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message = _getErrorMessage(e.code);
      Fluttertoast.showToast(msg: message);
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred: ${e.toString()}");
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      await _clearPreferences(); // Clear saved preferences
      _user = null;
      _userDetails = null;
      Navigator.pushReplacementNamed(context, LoginPage.id);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error during logout: ${e.toString()}");
    }
  }

  Future<void> fetchUserDetails() async {
    if (_user == null) return;

    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(_user!.uid).get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        _userDetails = UserDetails(
          uid: _user!.uid,
          username: data['username'] ?? '',
          email: data['email'] ?? '',
          birthdate: data['date_of_birth']?.toString() ?? '',
          gender: data['gender'] ?? '',
          skinType: data['skinType'] ?? '',
          allergies: data['allergies'] ?? '',
        );
      } else {
        _userDetails = null;
      }
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching user details: ${e.toString()}");
    }
  }


  Future<void> saveUserDetails({
    required BuildContext context,
    required String username,
    required String email,
    required String birthdate,
    required String gender,
    required String skinType,
    required String allergies,
  }) async {
    if (_user == null) {
      Fluttertoast.showToast(msg: "Error: User not logged in.");
      return;
    }

    try {
      // Validate date format
      final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
      if (!dateRegex.hasMatch(birthdate)) {
        throw FormatException('Invalid date format');
      }

      await _firestore.collection('Users').doc(_user!.uid).update({
        'username': username,
        'email': email,
        'date_of_birth': birthdate,
        'gender': gender,
        'skinType': skinType,
        'allergies': allergies,
      });

      // Update local state
      _userDetails = UserDetails(
        uid: _user!.uid,
        username: username,
        email: email,
        birthdate: birthdate,
        gender: gender,
        skinType: skinType,
        allergies: allergies,
      );

      notifyListeners();
      Fluttertoast.showToast(msg: "Profile updated successfully!");
    } on FormatException {
      Fluttertoast.showToast(msg: "Please use YYYY-MM-DD date format");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating profile: ${e.toString()}");
    }
  }

  Future<void> addAdditionalUserDetails(String? skinType, String? allergies) async {
    if (_user == null) return;

    try {
      await _firestore.collection('Users').doc(_user!.uid).update({
        'skinType': skinType ?? '',
        'allergies': allergies ?? '',
      });
      await fetchUserDetails();
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating user details: ${e.toString()}");
    }
  }

  Future<void> saveDetectionHistory({
    required String disease,
    required String description,
    required Map<String, String?> userInputs,
    required String? imageBase64,
  }) async {
    if (_user == null) return;

    try {
      await _historyCollection.add({
        'userId': _user!.uid,
        'disease': disease,
        'description': description,
        'date': FieldValue.serverTimestamp(),
        'imageBase64': imageBase64,
        'userInputs': userInputs,
      });
    } catch (e, stackTrace) {
      print('Failed to save history: $e');
      print(stackTrace);
      Fluttertoast.showToast(
        msg: "Couldn't save report to history",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<List<DetectionHistory>> getDetectionHistory() async {
    if (_user == null) return [];

    try {
      final querySnapshot = await _historyCollection
          .where('userId', isEqualTo: _user!.uid)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return DetectionHistory.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
    } catch (e) {
      print('Error fetching history: $e');
      return [];
    }
  }

  DateTime? parseBirthdate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is invalid.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}