import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> _authenticate(
      String email, String password, String urlsegment) async {
    final data = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlsegment}?key=AIzaSyCxB9CBLmDHUdRZsd389weIBrA1_lTmTSA';
    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    final jsonres = response.body;
    print(jsonres);
  }

  Future<void> singin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }
}