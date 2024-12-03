import 'package:dailyfeardeal/screens/payment/add_card_screen.dart';
import 'package:dailyfeardeal/screens/payment/all_transactions_screen.dart';
import 'package:dailyfeardeal/widget/app_color.dart';
import 'package:dailyfeardeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<Map<String, String>> recentTransactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment', style: AppWidget.appBarTextStyle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const AddCardScreen());
              },
              child: const Card(
                color: AppColor.primaryColor,
                child: ListTile(
                  leading: Icon(Icons.credit_card, size: 40),
                  title: Text('Add a card'),
                  subtitle: Text('Go cashless with a credit or debit card'),
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
                              Get.to(() => const AllTransactionsScreen());
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
