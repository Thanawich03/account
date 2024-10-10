import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/laptop_provider.dart';
import 'package:account/screens/laptopform_screen.dart';
import 'package:account/screens/laptophome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LaptopProvider()),
      ],
      child: MaterialApp(
        title: 'โน้ตบุ๊กในตลาด',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.yellow[700],
          scaffoldBackgroundColor: const Color.fromARGB(255, 53, 53, 53),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 44, 44, 44),
            titleTextStyle: TextStyle(color: Colors.yellow[700], fontSize: 20),
          ),
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: const Color.fromARGB(179, 0, 0, 0)),
                titleLarge: TextStyle(
                    color: Colors.yellow[700],
                    fontSize: 20), // สำหรับ AppBar title
              ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LaptopProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("โน้ตบุ๊กในตลาด"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "รายการโน้ตบุ๊ก", icon: Icon(Icons.laptop)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const LaptopHomeScreen(),
            LaptopFormScreen(),
          ],
        ),
      ),
    );
  }
}
