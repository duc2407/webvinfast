import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/models/product_model.dart';
import 'package:webvinfast/providers/main_provider.dart';
import 'package:webvinfast/widgets/table_test.dart';

class ManagementProduct extends StatefulWidget {
  const ManagementProduct({super.key});

  @override
  State<ManagementProduct> createState() => _ManagementProductState();
}

class _ManagementProductState extends State<ManagementProduct> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture =
        Provider.of<MainViewModel>(context, listen: false).getAllProducts();
  }

  String formatNumberWithCommas(int number) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final products = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: const Text(
                  'Quản lý sản phẩm',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width - 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 300,
                      child: DataTable(
                        columnSpacing: 20,
                        headingRowColor: MaterialStateProperty.all(
                            Colors.blueAccent.shade100),
                        columns: const <DataColumn>[
                          DataColumn(
                              label: Text('ID',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Tên',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Giá',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Số chỗ ngồi',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Loại la-zăng',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Hành động',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: products.map((product) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text(product.id.toString())),
                              DataCell(Text(product.name)),
                              DataCell(Text(
                                  formatNumberWithCommas(product.price)
                                      .toString())),
                              DataCell(Text(product.numberOfSeats.toString())),
                              DataCell(Text(product.typeLaZang)),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blueAccent),
                                    onPressed: () {
                                      // Thêm xử lý chỉnh sửa ở đây
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      // Thêm xử lý xóa ở đây
                                    },
                                  ),
                                ],
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
