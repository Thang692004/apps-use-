import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String id;
  final String name;
  final String phone;
  final String pt;
  final String packageName;
  final DateTime expiredDate;

  const MemberModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.pt,
    required this.packageName,
    required this.expiredDate,
  });

  factory MemberModel.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return MemberModel(
      id: id,
      name: data['name'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      pt: data['PT'] as String? ?? '',
      packageName: data['packageName'] as String? ?? '',
      expiredDate:
          (data['expiredDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'PT': pt,
    'packageName': packageName,
    'expiredDate': Timestamp.fromDate(expiredDate),
  };

  bool get isExpired => expiredDate.isBefore(DateTime.now());
}
