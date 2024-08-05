import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webvinfast/widgets/chart_demo.dart';
import 'package:webvinfast/widgets/chart_demo2.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(181, 240, 240, 240),
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            height: 65,
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Thống kê',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height - 110,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(181, 240, 240, 240),
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 3 + 120,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(181, 240, 240, 240),
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 196, 196, 196)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: const PieChartSample2()),
                      Container(
                          width: MediaQuery.of(context).size.width / 3 + 120,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(181, 240, 240, 240),
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 196, 196, 196)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: const PieChartSample2()),
                    ],
                  ),
                ),
                SizedBox(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3 + 120,
                            child: const LineChartSample2()),
                        // SizedBox(
                        //     width: MediaQuery.of(context).size.width / 3 + 120,
                        //     child: const LineChartSample2())
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
