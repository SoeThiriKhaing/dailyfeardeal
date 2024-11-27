import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Dummy data for recent transactions
  final List<Map<String, String>> recentTransactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings or perform settings action
              debugPrint('Settings clicked');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add a Card Section
            GestureDetector(
              onTap: () {
                // Navigate to 'Add a Card' functionality
                debugPrint('Add a card clicked');
              },
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.credit_card, size: 40),
                  title: Text('Add a card'),
                  subtitle: Text('Go cashless with a credit or debit card'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Recent Transactions Header
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Recent Transactions or Placeholder
            Expanded(
              child: recentTransactions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "There's no recent activity to show here.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                            onPressed: () {
                              // Navigate to past transactions
                              debugPrint('View past transactions clicked');
                            },
                            child: const Text('See past transactions'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: recentTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = recentTransactions[index];
                        return ListTile(
                          leading: const Icon(Icons.payment),
                          title: Text(transaction['title']!),
                          subtitle: Text(transaction['date']!),
                          trailing: Text(transaction['amount']!),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
