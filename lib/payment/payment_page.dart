import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const PaymentPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final productName = item['name'];
          final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
          final price = double.tryParse(item['price'].toString()) ?? 1.0;
          final totalPrice = quantity * price;

          return ListTile(
            title: Text('Product: $productName'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity: $quantity'),
                Text('Price: $price บาท'),
              ],
            ),
            trailing: Text('Total: $totalPrice บาท'),
          );
        },
      ),
    );
  }
}


