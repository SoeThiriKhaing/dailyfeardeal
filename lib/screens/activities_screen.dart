import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activities'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood), text: 'Food'),
              Tab(icon: Icon(Icons.local_taxi), text: 'Taxi'),
              Tab(icon: Icon(Icons.store), text: 'Mall'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Food Delivery Tab
            FoodActivities(),
            // Taxi Tab
            TaxiActivities(),
            // Mall Tab
            MallActivities(),
          ],
        ),
      ),
    );
  }
}

class FoodActivities extends StatelessWidget {
  const FoodActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.fastfood),
          title: Text('Order #12345'),
          subtitle: Text('Status: Out for Delivery'),
          trailing: Text('ETA: 20 mins'),
        ),
        ListTile(
          leading: Icon(Icons.fastfood),
          title: Text('Order #12344'),
          subtitle: Text('Status: Delivered'),
          trailing: Text('Yesterday'),
        ),
      ],
    );
  }
}

class TaxiActivities extends StatelessWidget {
  const TaxiActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.local_taxi),
          title: Text('Ride to Downtown'),
          subtitle: Text('Driver: John Doe'),
          trailing: Text('Ongoing'),
        ),
        ListTile(
          leading: Icon(Icons.local_taxi),
          title: Text('Ride to Airport'),
          subtitle: Text('Completed'),
          trailing: Text('2 days ago'),
        ),
      ],
    );
  }
}

class MallActivities extends StatelessWidget {
  const MallActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Shopping at Fashion Store'),
          subtitle: Text('Purchase Total: \$120'),
          trailing: Text('1 hour ago'),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Shopping at Electronics'),
          subtitle: Text('Purchase Total: \$450'),
          trailing: Text('3 days ago'),
        ),
      ],
    );
  }
}
