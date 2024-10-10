class Laptop {
  final int? id;
  final String name;
  final String cpu;
  final String ram;
  final String ssd;
  final String gpu;
  final double price;

  Laptop({
    this.id,
    required this.name,
    required this.cpu,
    required this.ram,
    required this.ssd,
    required this.gpu,
    required this.price,
  });

  @override
  String toString() {
    return 'Laptop{id: $id, name: $name, cpu: $cpu, ram: $ram, ssd: $ssd, gpu: $gpu, price: $price}';
  }
}
