import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_b_config.dart';
import '../providers/order_provider.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameCtrl = TextEditingController();
  final _customerPhoneCtrl = TextEditingController();
  final _foodNameCtrl = TextEditingController();
  final _addressFromCtrl = TextEditingController();
  final _addressToCtrl = TextEditingController();
  final _shiperNameCtrl = TextEditingController();
  final _shiperPhoneCtrl = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    _customerNameCtrl.dispose();
    _customerPhoneCtrl.dispose();
    _foodNameCtrl.dispose();
    _addressFromCtrl.dispose();
    _addressToCtrl.dispose();
    _shiperNameCtrl.dispose();
    _shiperPhoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      await context.read<OrderProvider>().add(
        customerName: _customerNameCtrl.text.trim(),
        customerPhone: _customerPhoneCtrl.text.trim(),
        foodName: _foodNameCtrl.text.trim(),
        addressFrom: _addressFromCtrl.text.trim(),
        addressTo: _addressToCtrl.text.trim(),
        shiperName: _shiperNameCtrl.text.trim(),
        shiperPhone: _shiperPhoneCtrl.text.trim(),
      );

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Order')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _section('Customer'),
              _field(
                _customerNameCtrl,
                'Customer name',
                required: true,
              ),
              const SizedBox(height: 12),
              _field(
                _customerPhoneCtrl,
                'Customer phone',
                keyboard: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              _section('Food'),
              _field(_foodNameCtrl, 'Food name', required: true),
              const SizedBox(height: 20),
              _section('Address'),
              _field(_addressFromCtrl, 'From'),
              const SizedBox(height: 12),
              _field(_addressToCtrl, 'To', required: true),
              const SizedBox(height: 20),
              _section('Shipper'),
              _field(_shiperNameCtrl, 'Shipper name'),
              const SizedBox(height: 12),
              _field(
                _shiperPhoneCtrl,
                'Shipper phone',
                keyboard: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: foodConfig.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

  Widget _field(
    TextEditingController ctrl,
    String label, {
    bool required = false,
    TextInputType? keyboard,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: InputDecoration(labelText: label),
      validator: required
          ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
          : null,
    );
  }
}
