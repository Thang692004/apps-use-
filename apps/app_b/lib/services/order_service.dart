import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

class OrderService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection('orders');

  Stream<List<OrderModel>> watchAll() {
    return _collection.snapshots().map(
      (snap) => snap.docs
          .map((d) => OrderModel.fromFirestore(d.id, d.data()))
          .toList(),
    );
  }

  Future<List<OrderModel>> fetchAll() async {
    final snap = await _collection.get();

    return snap.docs
        .map((d) => OrderModel.fromFirestore(d.id, d.data()))
        .toList();
  }

  Future<String> add({
    required String addressFrom,
    required String addressTo,
    required String customerName,
    required String customerPhone,
    required String foodName,
    required String shiperName,
    required String shiperPhone,
  }) async {
    final doc = await _collection.add({
      'addressFrom': addressFrom,
      'addressTo': addressTo,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'foodName': foodName,
      'shiperName': shiperName,
      'shiperPhone': shiperPhone,
    });

    return doc.id;
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }
}
