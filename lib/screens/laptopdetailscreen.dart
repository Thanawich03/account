import 'package:flutter/material.dart';
import 'package:account/models/laptop.dart';

class LaptopDetailScreen extends StatelessWidget {
  final Laptop laptop;

  const LaptopDetailScreen({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(laptop.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CPU: ${laptop.cpu}', style: TextStyle(fontSize: 18, color: Colors.yellow)),
            SizedBox(height: 8),
            Text('RAM: ${laptop.ram}', style: TextStyle(fontSize: 18, color: Colors.yellow)),
            SizedBox(height: 8),
            Text('SSD: ${laptop.ssd}', style: TextStyle(fontSize: 18, color: Colors.yellow)),
            SizedBox(height: 8),
            Text('GPU: ${laptop.gpu}', style: TextStyle(fontSize: 18, color: Colors.yellow)),
            SizedBox(height: 8),
            Text('ราคา: ${laptop.price} บาท', style: TextStyle(fontSize: 18, color: Colors.yellow)),
          ],
        ),
      ),
    );
  }
}
