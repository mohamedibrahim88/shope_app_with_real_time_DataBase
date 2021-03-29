import 'dart:convert';
import '../models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier{
  String _token;
  String _userId ;
  DateTime _expiryDate;

  String get userId{
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }
  Future <void> signUp (String email , String pass) async {
  return _authentication(email, pass, 'signUp');
  }
  Future <void> logIn (String email , String pass) async {
    return _authentication(email, pass, 'signInWithPassword');
  }
  String get token {
    if (_expiryDate!=null && _expiryDate.isAfter(DateTime.now())&&_token!=null){
      return _token ;
    }
    return null ;
  }

  Future<void> _authentication (String email, String password, String segment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$segment?key=AIzaSyA1TiRA_IsjvICRc7fblDIUMkWbvUgdbEA';
    try {
      final response = await http.post(url,body: json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true,
    },
      ),
    );
    final responseData = json.decode(response.body);
    if (responseData['error']!=null) {
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
     _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
    );
        notifyListeners();
    } catch(error){
      throw error;
    }
  }

}