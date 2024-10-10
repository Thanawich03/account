import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/laptop_provider.dart';
import 'package:account/screens/laptopform_screen.dart';
import 'package:account/screens/laptopdetailscreen.dart';

class LaptopHomeScreen extends StatefulWidget {
  const LaptopHomeScreen({super.key});

  @override
  _LaptopHomeScreenState createState() => _LaptopHomeScreenState();
}

class _LaptopHomeScreenState extends State<LaptopHomeScreen> {
  double maxPrice = double.infinity; // ราคาไม่เกิน
  String selectedCpu = ''; // ค่าที่เลือกสำหรับ CPU
  String selectedGpu = ''; // ค่าที่เลือกสำหรับ GPU

  @override
  void initState() {
    super.initState();
    Provider.of<LaptopProvider>(context, listen: false).initData();
  }

  void _showFilterDialog(BuildContext context) {
    double tempMaxPrice = maxPrice;
    String tempCpu = selectedCpu;
    String tempGpu = selectedGpu;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('กรองข้อมูล', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF333333), // สีพื้นหลังของป๊อปอัพ
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'ราคาไม่เกิน',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    tempMaxPrice = double.tryParse(value) ?? double.infinity;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: tempCpu.isEmpty ? null : tempCpu,
                  hint: const Text('เลือก CPU', style: TextStyle(color: Colors.white)),
                  dropdownColor: const Color(0xFF444444), // สีพื้นหลังของ Dropdown
                  items: ['Intel', 'AMD'].map((cpu) {
                    return DropdownMenuItem(
                      value: cpu,
                      child: Text(cpu, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tempCpu = value ?? '';
                      selectedCpu = tempCpu; // อัปเดต selectedCpu ทันที
                    });
                  },
                ),
                DropdownButton<String>(
                  value: tempGpu.isEmpty ? null : tempGpu,
                  hint: const Text('เลือก GPU', style: TextStyle(color: Colors.white)),
                  dropdownColor: const Color(0xFF444444), // สีพื้นหลังของ Dropdown
                  items: ['NVIDIA', 'AMD', 'Intel'].map((gpu) {
                    return DropdownMenuItem(
                      value: gpu,
                      child: Text(gpu, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tempGpu = value ?? '';
                      selectedGpu = tempGpu; // อัปเดต selectedGpu ทันที
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('ล้างการกรอง', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  tempMaxPrice = double.infinity;
                  tempCpu = '';
                  tempGpu = '';
                  selectedCpu = '';
                  selectedGpu = '';
                });
              },
            ),
            TextButton(
              child: const Text('ยกเลิก', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ตกลง', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  maxPrice = tempMaxPrice;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการโน้ตบุ๊ก'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaptopFormScreen(),
                ),
              ).then((_) {
                Provider.of<LaptopProvider>(context, listen: false).initData();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Consumer<LaptopProvider>(
        builder: (context, provider, child) {
          var filteredLaptops = provider.laptops.where((laptop) {
            return laptop.price <= maxPrice &&
                   (selectedCpu.isEmpty || laptop.cpu.contains(selectedCpu)) &&
                   (selectedGpu.isEmpty || laptop.gpu.contains(selectedGpu));
          }).toList();

          if (filteredLaptops.isEmpty) {
            return const Center(child: Text('ไม่มีโน้ตบุ๊กที่ตรงกับเงื่อนไข'));
          } else {
            return ListView.builder(
              itemCount: filteredLaptops.length,
              itemBuilder: (context, index) {
                var laptop = filteredLaptops[index];
                return Card(
                  color: Colors.yellow[700],
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(
                      laptop.name,
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CPU: ${laptop.cpu}', style: TextStyle(color: Colors.black)),
                        Text('GPU: ${laptop.gpu}', style: TextStyle(color: Colors.black)),
                        SizedBox(height: 5),
                        Text(
                          'ราคา: ${laptop.price.toString()} บาท',
                          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LaptopFormScreen(laptop: laptop),
                              ),
                            ).then((_) {
                              provider.initData();
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed: () {
                            provider.deleteLaptop(laptop.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaptopDetailScreen(laptop: laptop),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
