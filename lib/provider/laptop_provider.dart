import 'package:flutter/foundation.dart';
import 'package:account/models/laptop.dart';
import 'package:account/databases/laptop_db.dart';

class LaptopProvider with ChangeNotifier {
  List<Laptop> laptops = [];

  Future<void> initData() async {
    await loadLaptops();
  }

  Future<void> loadLaptops() async {
    var db = LaptopDB(dbName: 'laptops.db');
    laptops = await db.loadAllLaptops();
    notifyListeners();
  }

  Future<void> addLaptop(Laptop laptop) async {
    var db = LaptopDB(dbName: 'laptops.db');
    await db.insertLaptop(laptop);
    await loadLaptops();
  }

  Future<void> updateLaptop(Laptop laptop) async {
    var db = LaptopDB(dbName: 'laptops.db');
    await db.updateLaptop(laptop);
    await loadLaptops();
  }

  Future<void> deleteLaptop(int? id) async {
    if (id == null) {
      print("Cannot delete laptop: id is null");
      return;
    }

    var db = LaptopDB(dbName: 'laptops.db');
    await db.deleteLaptop(id);
    await loadLaptops();
  }
}
