import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/providers/main_provider.dart';

class TableTest extends StatelessWidget {
  const TableTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(builder: (context, viewModel, child) {
      if (viewModel.getTestCars.isEmpty) {
        return const Center(child: Text('Chưa có dữ liệu'));
      }

      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Name Car')),
              DataColumn(label: Text('Note')),
              DataColumn(label: Text('Created At')),
              DataColumn(label: Text('Updated At')),
            ],
            rows: viewModel.getTestCars.map((car) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(car.id.toString())),
                  DataCell(Text(car.name ?? 'N/A')),
                  DataCell(Text(car.numberPhone ?? 'N/A')),
                  DataCell(Text(car.email ?? 'N/A')),
                  DataCell(Text(car.nameCar ?? 'N/A')),
                  DataCell(Text(car.note)),
                  DataCell(Text(car.createdAt.toLocal().toString())),
                  DataCell(Text(car.updatedAt.toLocal().toString())),
                ],
              );
            }).toList(),
          ));
    });
  }
}
