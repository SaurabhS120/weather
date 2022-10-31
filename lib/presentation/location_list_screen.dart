import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Location list'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Placeholder(
                fallbackHeight: 36,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/location');
            },
            child: Text('Add city'),
          )
        ],
      ),
    ));
  }
}
