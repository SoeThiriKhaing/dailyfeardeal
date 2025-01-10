import 'package:dailyfairdeal/screens/dashboard/drawer/restaurant_owner_drawer.dart';
import 'package:dailyfairdeal/widget/app_color.dart';
import 'package:dailyfairdeal/widget/support_widget.dart';
import 'package:flutter/material.dart';
    
class ChangeRestaurantAddress extends StatelessWidget {

  const ChangeRestaurantAddress({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('Change Address', style: AppWidget.subTitle()),
        backgroundColor: AppColor.primaryColor,
      ),
      drawer: const RestaurantOwnerDrawer(),
      body: Container(),
    );
  }
}