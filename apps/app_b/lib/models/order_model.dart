import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String addressFrom;
  final String addressTo;
  final String customerName;
  final String customerPhone;
  final String foodName;
  final String shiperName;
  final String shiperPhone;

  const OrderModel({
    required this.id,
    required this.addressFrom,
    required this.addressTo,
    required this.customerName,
    required this.customerPhone,
    required this.foodName,
    required this.shiperName,
    required this.shiperPhone,
  });

  factory OrderModel.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return OrderModel(
      id: id,
      addressFrom: data['addressFrom'] as String? ?? '',
      addressTo: data['addressTo'] as String? ?? '',
      customerName: data['customerName'] as String? ?? '',
      customerPhone: data['customerPhone'] as String? ?? '',
      foodName: data['foodName'] as String? ?? '',
      shiperName: data['shiperName'] as String? ?? '',
      shiperPhone: data['shiperPhone'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'addressFrom': addressFrom,
    'addressTo': addressTo,
    'customerName': customerName,
    'customerPhone': customerPhone,
    'foodName': foodName,
    'shiperName': shiperName,
    'shiperPhone': shiperPhone,
  };
}
