import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import '../services/purchase_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final _iap = InAppPurchase.instance;
  late PurchaseService _purchaseService;

  @override
  void initState() {
    super.initState();
    _purchaseService = context.read<PurchaseService>();
    _purchaseService.init(_iap);
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<PurchaseService>().products;
    final status = context.watch<PurchaseService>().status;

    return Scaffold(
      appBar: AppBar(title: const Text('Подписка')),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16),
        children: products.map((product) {
          final isActive = status == product.id;
          return Card(
            child: ListTile(
              title: Text(product.title),
              subtitle: Text(product.description),
              trailing: ElevatedButton(
                onPressed: isActive ? null : () => _purchaseService.buy(product),
                child: Text(isActive ? 'Активно' : product.price),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}