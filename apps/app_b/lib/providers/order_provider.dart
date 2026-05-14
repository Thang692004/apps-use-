import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription<List<OrderModel>>? _sub;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get count => _orders.length;

  OrderProvider() {
    _start();
  }

  void _start() {
    _isLoading = true;
    notifyListeners();

    _sub = _service.watchAll().listen(
      (list) {
        _orders = list;
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
    required String addressFrom,
    required String addressTo,
    required String customerName,
    required String customerPhone,
    required String foodName,
    required String shiperName,
    required String shiperPhone,
  }) async {
    await _service.add(
      addressFrom: addressFrom,
      addressTo: addressTo,
      customerName: customerName,
      customerPhone: customerPhone,
      foodName: foodName,
      shiperName: shiperName,
      shiperPhone: shiperPhone,
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
