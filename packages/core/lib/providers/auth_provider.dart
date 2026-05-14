import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  late final AuthService _authService;

  UserModel? _user;

  bool _isLoading = false;

  AuthProvider({
    String? webClientId,
  }) {
    _authService = AuthService(
      webClientId: webClientId,
    );

    _user =
        _authService.getCurrentUser();
  }

  UserModel? get user => _user;

  bool get isLoading => _isLoading;

  bool get isLoggedIn =>
      _user != null;

  Future<void> loginWithGoogle()
  async {
    try {
      _isLoading = true;

      notifyListeners();

      _user =
      await _authService
          .signInWithGoogle();
    } catch (e) {
      debugPrint(
        'AuthProvider Login Error: $e',
      );
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.signOut();

    _user = null;

    notifyListeners();
  }
}