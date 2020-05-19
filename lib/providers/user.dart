import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  final String id;
  final String email;
  final String userType;
 
  User({
    this.id,
    @required this.email,
    @required this.userType,
  });
 }
