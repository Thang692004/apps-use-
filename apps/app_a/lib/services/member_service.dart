import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/member_model.dart';

class MemberService {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection('members');

  Stream<List<MemberModel>> watchAll() {
    return _collection.snapshots().map(
      (snap) => snap.docs
          .map((d) => MemberModel.fromFirestore(d.id, d.data()))
          .toList(),
    );
  }

  Future<List<MemberModel>> fetchAll() async {
    final snap = await _collection.get();

    return snap.docs
        .map((d) => MemberModel.fromFirestore(d.id, d.data()))
        .toList();
  }

  Future<String> add({
    required String name,
    required String phone,
    required String pt,
    required String packageName,
    required DateTime expiredDate,
  }) async {
    final doc = await _collection.add({
      'name': name,
      'phone': phone,
      'PT': pt,
      'packageName': packageName,
      'expiredDate': Timestamp.fromDate(expiredDate),
    });

    return doc.id;
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }
}
