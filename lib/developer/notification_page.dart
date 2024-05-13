import 'package:flutter/material.dart';
import 'package:rever/src/core/constants/assets.dart';
import 'package:rever/src/core/theme/themes.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.getTheme().secondaryColor.withOpacity(0.5),
        title: const Text(
          'Notifications',
          style: TextStyle(
              //  color: Color.fromARGB(255, 1, 78, 5),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Assets.logo),
          //fit: BoxFit.cover,
        )),
        child: const Center(
          child: Text(
            "No notifactions yet !",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
