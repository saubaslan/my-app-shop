import 'package:flutter/material.dart';

import '../payment/payment_page.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<Map<String, String>> selectedItems;

  const ShoppingCartPage({Key? key, required this.selectedItems})
      : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  double totalPrice = 0;
  late List<int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = List.generate(widget.selectedItems.length, (index) => 1);
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < widget.selectedItems.length; i++) {
      final item = widget.selectedItems[i];
      if (item['price'] != null) {
        totalPrice += double.parse(item['price']!) * quantities[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.selectedItems.length,
        itemBuilder: (context, index) {
          final item = widget.selectedItems[index];
          final quantity = quantities[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: Image.network(
              item['image']!,
              width: 80,
              height: 80,
            ),
            title: Text(item['name'] ?? ''),
            subtitle: Text('Price: ${item['price'] ?? ''}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantities[index]--;
                        calculateTotalPrice();
                      });
                    }
                  },
                  child: const Text('-'),
                ),
                const SizedBox(width: 10),
                Text('$quantity  '),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quantities[index]++;
                      calculateTotalPrice();
                    });
                  },
                  child: const Text('+'),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ชำระเงินทั้งหมด: \$${totalPrice.toStringAsFixed(0)} บาท',
                style: const TextStyle(color: Colors.green),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PaymentPage(items: widget.selectedItems),
                    ),
                  );
                },
                child: const Icon(Icons.monetization_on),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
