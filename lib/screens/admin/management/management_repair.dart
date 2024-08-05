import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/providers/main_provider.dart';
import 'package:webvinfast/widgets/table_test.dart';

class ManagementRepair extends StatefulWidget {
  const ManagementRepair({super.key});

  @override
  State<ManagementRepair> createState() => _ManagementRepairState();
}

class _ManagementRepairState extends State<ManagementRepair> {
  late Future<List<TestCar>> _testCarsFuture;

  @override
  void initState() {
    super.initState();
    _testCarsFuture =
        Provider.of<MainViewModel>(context, listen: false).getTestCarsByType(2);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TestCar>>(
      future: _testCarsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final testCars = snapshot.data!;

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
                  'Quản lý sửa chữa & bảo hành',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          List<Map<String, dynamic>> testCarsMap =
                              testCars.map((car) => car.toJson()).toList();
                          Provider.of<MainViewModel>(context, listen: false)
                              .exportExcel(testCarsMap);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(55),
                          backgroundColor:
                              const Color.fromARGB(255, 70, 75, 215),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/excel.svg',
                              width: 24,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Xuất Excel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                              label: Text('Số điện thoại',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Email',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Tên xe',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Note',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          // DataColumn(
                          //     label: Text('Created At',
                          //         style:
                          //             TextStyle(fontWeight: FontWeight.bold))),
                          // DataColumn(
                          //     label: Text('Updated At',
                          //         style:
                          //             TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Actions',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: testCars.map((car) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text(car.id.toString())),
                              DataCell(Text(car.name ?? 'N/A')),
                              DataCell(Text(car.numberPhone ?? 'N/A')),
                              DataCell(Text(car.email ?? 'N/A')),
                              DataCell(Text(car.nameCar ?? 'N/A')),
                              DataCell(Text(car.note)),
                              // DataCell(
                              //     Text(car.createdAt.toLocal().toString())),
                              // DataCell(
                              //     Text(car.updatedAt.toLocal().toString())),
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
