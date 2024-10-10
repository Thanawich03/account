import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/laptop_provider.dart';
import 'package:account/models/laptop.dart';

class LaptopFormScreen extends StatefulWidget {
  final Laptop? laptop;

  const LaptopFormScreen({super.key, this.laptop});

  @override
  _LaptopFormScreenState createState() => _LaptopFormScreenState();
}

class _LaptopFormScreenState extends State<LaptopFormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cpuController = TextEditingController();
  final ramController = TextEditingController();
  final ssdController = TextEditingController();
  final gpuController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.laptop != null) {
      nameController.text = widget.laptop!.name;
      cpuController.text = widget.laptop!.cpu;
      ramController.text = widget.laptop!.ram;
      ssdController.text = widget.laptop!.ssd;
      gpuController.text = widget.laptop!.gpu;
      priceController.text = widget.laptop!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่ม/แก้ไข โน้ตบุ๊ก'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อโน้ตบุ๊ก', labelStyle: TextStyle(color: Colors.yellow)),
                controller: nameController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกชื่อโน้ตบุ๊ก';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CPU', labelStyle: TextStyle(color: Colors.yellow)),
                controller: cpuController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล CPU';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'RAM', labelStyle: TextStyle(color: Colors.yellow)),
                controller: ramController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล RAM';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'SSD', labelStyle: TextStyle(color: Colors.yellow)),
                controller: ssdController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล SSD';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'GPU', labelStyle: TextStyle(color: Colors.yellow)),
                controller: gpuController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล GPU';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ราคา', labelStyle: TextStyle(color: Colors.yellow)),
                controller: priceController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกราคา';
                  }
                  return null;
                },
              ),
              TextButton(
                child: const Text('บันทึก', style: TextStyle(color: Colors.black)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var laptop = Laptop(
                      id: widget.laptop?.id,
                      name: nameController.text,
                      cpu: cpuController.text,
                      ram: ramController.text,
                      ssd: ssdController.text,
                      gpu: gpuController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                    );

                    var provider = Provider.of<LaptopProvider>(context, listen: false);
                    if (widget.laptop == null) {
                      provider.addLaptop(laptop);
                    } else {
                      provider.updateLaptop(laptop);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
