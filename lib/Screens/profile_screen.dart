import 'package:flutter/material.dart';
import 'package:food_scan/models/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Personal Details', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 20),

        ]),
      ),
    );
  }
}
