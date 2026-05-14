import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/member_model.dart';
import '../services/member_service.dart';

class MemberProvider extends ChangeNotifier {
  final MemberService _service = MemberService();

  List<MemberModel> _members = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription<List<MemberModel>>? _sub;

  List<MemberModel> get members => _members;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get count => _members.length;
  int get activeCount => _members.where((m) => !m.isExpired).length;

  MemberProvider() {
    _start();
  }

  void _start() {
    _isLoading = true;
    notifyListeners();

    _sub = _service.watchAll().listen(
      (list) {
        _members = list;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (Object e) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> add({
    required String name,
    required String phone,
    required String pt,
    required String packageName,
    required DateTime expiredDate,
  }) async {
    await _service.add(
      name: name,
      phone: phone,
      pt: pt,
      packageName: packageName,
      expiredDate: expiredDate,
    );
  }

  Future<void> delete(String id) async {
    await _service.delete(id);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
