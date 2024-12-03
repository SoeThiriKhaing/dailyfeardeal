import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceSetting extends StatefulWidget {
  const FinanceSetting({super.key});

  @override
  State<FinanceSetting> createState() => _FinanceSettingState();
}

class _FinanceSettingState extends State<FinanceSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Finance Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 4.0, // Adds elevation to the AppBar
      ),
      body: ListView(
        children: [
          const Text(
            "Payments",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
          ),
          const SizedBox(height: 10),
          // Payment Section
          _buildSection(
            icon: Icons.payment,
            title: 'All Payment Methods',
            subtitle: 'Manage your payment methods and top ups',
            onTap: () {
              //Get.to(() => const PaymentMethodsScreen());
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            "Security",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
          ),
          const SizedBox(height: 10),

          // Security Section
          _buildSection(
            icon: Icons.lock,
            title: 'DFD PIN',
            subtitle: 'Create or reset your PIN',
            onTap: () {
              //Get.to(() => const DfdPinScreen());
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build each section
  Widget _buildSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 30,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
