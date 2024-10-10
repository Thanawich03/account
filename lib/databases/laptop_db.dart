import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/laptop.dart';

class LaptopDB {
  String dbName;

  LaptopDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertLaptop(Laptop laptop) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('laptops');

    var id = store.add(db, {
      "name": laptop.name,
      "cpu": laptop.cpu,
      "ram": laptop.ram,
      "ssd": laptop.ssd,
      "gpu": laptop.gpu,
      "price": laptop.price,
    });
    db.close();
    return id;
  }

  Future<void> updateLaptop(Laptop laptop) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('laptops');

    await store.record(laptop.id!).update(db, {
      "name": laptop.name,
      "cpu": laptop.cpu,
      "ram": laptop.ram,
      "ssd": laptop.ssd,
      "gpu": laptop.gpu,
      "price": laptop.price,
    });
    db.close();
  }

  Future<List<Laptop>> loadAllLaptops() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('laptops');
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Laptop> laptops = [];
    for (var record in snapshot) {
      laptops.add(Laptop(
        id: record.key,
        name: record['name'].toString(),
        cpu: record['cpu'].toString(),
        ram: record['ram'].toString(),
        ssd: record['ssd'].toString(),
        gpu: record['gpu'].toString(),
        price: (record['price'] as num).toDouble(),
      ));
    }
    db.close();
    return laptops;
  }

  Future<void> deleteLaptop(int id) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('laptops');
    
    await store.delete(db, finder: Finder(filter: Filter.equals(Field.key, id)));
    db.close();
  }
}
