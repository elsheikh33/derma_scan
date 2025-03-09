import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../model/User_details.dart';
import '../../screens/Login_page.dart';
import '../../screens/Main_page.dart';
import '../../screens/Welcome_page.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  UserDetails? _userDetails;

  AuthProvider() {
    _user = _auth.currentUser;
    if (_user != null) {
      fetchUserDetails(); // Fetch details if already logged in
    }
  }

  User? get user => _user;
  UserDetails? get userDetails => _userDetails;

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
    }
  }

  Future<void> addUserDetails(
      String uid, String email, String userName, DateTime BD, String gender) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(BD); // Format the date

      await _firestore.collection('Users').doc(uid).set({
        'uid': uid,
        'email': email,
        'username': userName,
        'date_of_birth': formattedDate, // Save as string instead of Timestamp
        'gender': gender,
        'skinType': '',
        'allergies': '',
      });

      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error saving user details.");
    }
  }


    Future<void> login(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;

      if (_user != null) {
        await fetchUserDetails();
        if (_userDetails != null) {
          if (_userDetails!.skinType!.isNotEmpty  && _userDetails!.allergies!.isNotEmpty ) {
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
    }
  }

  Future<void> fetchUserDetails() async {
    if (_user == null) return;

    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(_user!.uid).get();

      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        data['skinType'] = data['skinType'] ?? ''; // Ensure non-null value
        data['allergies'] = data['allergies'] ?? '';
        _userDetails = UserDetails.fromMap(data);
      } else {
        _userDetails = null;
      }

      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching user details.");
    }
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    _user = null;
    _userDetails = null;
    Navigator.pushReplacementNamed(context, LoginPage.id);
    notifyListeners();
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
      default:
        return 'An error occurred. Please try again.';
    }
  }

  Future<void> addAdditionalUserDetails(String? skinType, String? allergies) async {
    if (_user == null) return;

    try {
      await _firestore.collection('Users').doc(_user!.uid).update({
        'skinType': skinType ?? '',
        'allergies': allergies ?? '',
      });
      await fetchUserDetails(); // Refresh user details
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating user details.");
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
      await _firestore.collection('Users').doc(_user!.uid).update({
        'username': username,
        'email': email,
        'date_of_birth': birthdate, // Ensure the date format is "yyyy-MM-dd"
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
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating profile.");
    }
  }
}

